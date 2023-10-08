module module_accu_fifo(
    input clk,
    input rst_n,
    input valid_in,
    input valid_in_rd_en,
    input signed[17:0] din,
    output valid_out,
    output signed[17:0] dout,
    output signed[17:0]rd_data,
    output signed[17:0]wr_data
   );

//parameter WIDTH = 18;//
//parameter           img_weight  =   10     ;
//parameter           img_height  =   10     ;

parameter           COL_NUM     =   128    ;
parameter           ROW_NUM     =   128     ;
parameter           IMG_LEN = COL_NUM*(ROW_NUM+2);
parameter           CHANNEL_NUM =   8 ;

reg [5:0]channel_cnt;
reg wr_en_r;
reg rd_en_r;

wire wr_en;
wire rd_en;

reg                 [15:0]  img_cnt         ;
wire valid_out_w;
reg valid_out_r;
//wire signed[17:0]rd_data;
//wire signed[17:0]wr_data;

reg signed[17:0]rd_data_r;

assign wr_data = (channel_cnt>=1)? (rd_data+din):din;
assign valid_out_w = (channel_cnt<CHANNEL_NUM-1) ? 0:1;


assign dout=wr_data;

reg valid_in_r;

assign valid_out = valid_out_r;
always @(posedge clk)begin
    valid_out_r<=valid_out_w;
    //valid_in_r<=valid_in;
    
end

always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        wr_en_r<=0;
        rd_en_r<=0;
    end
    else if(valid_in && (channel_cnt==1'd1||(img_cnt==IMG_LEN-1)))begin
        wr_en_r<=1;
        rd_en_r<=1;
        
    end
    
    else if( valid_in && (channel_cnt==1'd0) )begin
        wr_en_r<=1;
        rd_en_r<=0;
    end
    
    
end


assign wr_en= valid_in?wr_en_r:0;
assign rd_en= valid_in?rd_en_r:0;


always @(posedge clk or negedge rst_n)
    if(rst_n == 1'b0)begin
        img_cnt             <=          16'd0;
        channel_cnt         <=          6'd0;
    end
    else if(img_cnt == IMG_LEN-1  && valid_in == 1'b1)begin
        img_cnt             <=          16'd0;
        channel_cnt         <=          channel_cnt + 1'b1;
    end
    else if( valid_in == 1'b1) 
        img_cnt             <=          img_cnt + 1'b1;
accumulate_fifo u_accumulate_fifo (
  .clk(clk),                      // input
  .rst(!rst_n),                      // input
  .wr_en(wr_en),                  // input
  .wr_data(wr_data),              // input [15:0]
  .wr_full(),              // output
  .almost_full(),      // output
  .rd_en(rd_en),                  // input
  .rd_data(rd_data),              // output [15:0]
  .rd_empty(),            // output
  .almost_empty()     // output
);


endmodule