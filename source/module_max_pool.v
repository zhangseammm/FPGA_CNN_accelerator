module module_max_pool(//valid_in must delay 4 clocks
    input clk,
    input rst_n,
    input valid_in,
    input signed [7:0]din,
    output signed [7:0]dout,
    output valid_out
   );

parameter WIDTH = 8;//Êý¾ÝÎ»¿í
parameter           COL_NUM     =   128    ;
parameter           ROW_NUM     =   128    ;

reg clk_div2;
reg valid_out_r;
reg signed[7:0]reg_shift_1[1:0];
reg signed[7:0]reg_shift_2[1:0];
wire mat_flag;
wire signed [7:0]dout_r;
wire signed [7:0]dout_r0;
wire signed [7:0]dout_r1;
always@(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)
        clk_div2<=1;
    else if(mat_flag)begin
        reg_shift_1[0]<=dout_r0;
        reg_shift_1[1]<=reg_shift_1[0];
        
        reg_shift_2[0]<=dout_r1;
        reg_shift_2[1]<=reg_shift_2[0];
        clk_div2<=~clk_div2;
    end
    else
        clk_div2<=clk_div2;
end
reg                 [10:0]  col_cnt         ;
reg                 [10:0]  row_cnt         ;
always@(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)
        valid_out_r<=0;
    else if((row_cnt&10'b0000_0000_01)==1&&col_cnt==3)
        valid_out_r<=1;
    else if((row_cnt&10'b0000_0000_01)==0&&col_cnt==3)
        valid_out_r<=0;
    else
        valid_out_r<=valid_out_r;
end
assign dout = dout_r;
assign valid_out = valid_out_r&&mat_flag&&clk_div2;

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
    else
        row_cnt             <=          row_cnt;

//always@(posedge clk_div2 or negedge rst_n)begin

linebuffer2X2
    #(
    .COL_NUM(COL_NUM),
    .WIDTH(WIDTH)
    ) u_linebuffer2X2
    (
    .clk(clk),            // input
    .rst_n(rst_n),        // input
    .valid_in(valid_in),  // input
    .mat_flag(mat_flag),  // output
    .din(din),            // input[7:0]
    .dout_r0(dout_r0),    // output[7:0]
    .dout_r1(dout_r1)     // output[7:0]
);
cal_max_pool_2X2
    #(
    .WIDTH(WIDTH)
    ) u_cal_max_pool_2X2
    (
    .clk(clk),      // input
    .a(reg_shift_1[0]),          // input[7:0]
    .b(reg_shift_1[1]),          // input[7:0]
    .c(reg_shift_2[0]),          // input[7:0]
    .d(reg_shift_2[1]),          // input[7:0]
    .dout(dout_r)     // output[7:0]
);
endmodule