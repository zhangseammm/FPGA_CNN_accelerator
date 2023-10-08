module module_conv_same( //valid_in must delay 8+ROL_NUM clock
    input clk,
    input rst_n,
    input valid_in,
    input signed [7:0]din,
    input signed [7:0]weight_11,
    input signed [7:0]weight_12,
    input signed [7:0]weight_13,
    input signed [7:0]weight_21,
    input signed [7:0]weight_22,
    input signed [7:0]weight_23,
    input signed [7:0]weight_31,
    input signed [7:0]weight_32,
    input signed [7:0]weight_33,
    //input signed [7:0]bias,
    //input signed [7:0]zero_point,
    output valid_out,
    output signed [17:0]dout
    

   );
    
parameter WIDTH = 8;//数据位宽
parameter           img_weight  =   128     ;
parameter           img_height  =   128     ;
parameter           COL_NUM     =   img_weight    ;
parameter           ROW_NUM     =   img_height+2     ;
parameter LINE_NUM = 2;//行缓存的行数

wire signed [17:0]dout_t;
wire valid_conv_in;
wire signed [7:0] din_;
reg dout_zero_flag;
reg dout_zero_flags;
reg valid_out_r;
reg                 [10:0]  col_cnt         ;
reg                 [10:0]  row_cnt         ;
//reg                 [10:0]  zero_cnt        ;
reg zero_point=0;
assign din_ = din- zero_point;

always @(posedge clk or negedge rst_n)
    if(rst_n == 1'b0)begin
        dout_zero_flag<=0;
        valid_out_r<=0;
        
    end
    else if(row_cnt==LINE_NUM-1&&col_cnt==7)begin
        dout_zero_flag<=1;
        valid_out_r<=1;
    end
    else if(row_cnt==LINE_NUM&&col_cnt==7)
        dout_zero_flag<=0;
    else if(row_cnt==ROW_NUM-2&&col_cnt==7)
        dout_zero_flag<=1;
    else if(row_cnt==ROW_NUM-1&&col_cnt==7)begin
        dout_zero_flag<=0;    
        valid_out_r<=0;
    end
    else
        dout_zero_flag<=dout_zero_flag;
        
always@(posedge clk or negedge rst_n)
    
    if(rst_n == 1'b0)begin
        dout_zero_flags<=0;
    end
    else if(col_cnt==6||col_cnt==7)
        dout_zero_flags<=1;
    else if(col_cnt==8)
        dout_zero_flags<=0;
    else
        dout_zero_flags<=dout_zero_flags;

assign dout = (dout_zero_flag||dout_zero_flags)?18'b0:(dout_t);
assign valid_out=valid_out_r;

always @(posedge clk or negedge rst_n)
    if(rst_n == 1'b0)
        col_cnt             <=          11'd0;
    else if(col_cnt == COL_NUM-1 && valid_in == 1'b1)
        col_cnt             <=          11'd0;
    else if(valid_in == 1'b1)
        col_cnt             <=          col_cnt + 1'b1;
    else
        col_cnt             <=          col_cnt;

always @(posedge clk or negedge rst_n)
    if(rst_n == 1'b0)
        row_cnt             <=          11'd0;
    else if(row_cnt == ROW_NUM-1 && col_cnt == COL_NUM-1 && valid_in == 1'b1)
        row_cnt             <=          11'd0;
    else if(col_cnt == COL_NUM-1 && valid_in == 1'b1) 
        row_cnt             <=          row_cnt + 1'b1;


conv_3X3
    #(
    .COL_NUM(COL_NUM),
    .LINE_NUM(LINE_NUM),
    .ROW_NUM(ROW_NUM),
    .WIDTH(WIDTH)
    ) u_conv_3X3
    (
    .clk(clk),              // input
    .rst_n(rst_n),          // input
    .valid_in(valid_in),    // input
    .valid_out(valid_conv_in),  // output
    .din(din_),              // input[7:0]
    .weight_11(weight_11),  // input[7:0]
    .weight_12(weight_12),  // input[7:0]
    .weight_13(weight_13),  // input[7:0]
    .weight_21(weight_21),  // input[7:0]
    .weight_22(weight_22),  // input[7:0]
    .weight_23(weight_23),  // input[7:0]
    .weight_31(weight_31),  // input[7:0]
    .weight_32(weight_32),  // input[7:0]
    .weight_33(weight_33),  // input[7:0]
    .dout(dout_t)             // output[17:0]
);

endmodule