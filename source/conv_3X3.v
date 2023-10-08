module conv_3X3(
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
    output valid_out,
    output signed [17:0]dout
   );
parameter WIDTH = 8;//数据位宽
parameter           COL_NUM     =   128   ;
parameter           ROW_NUM     =   128   ;
parameter LINE_NUM = 2;//行缓存的行数


wire signed [7:0]line_1;
wire signed [7:0]line_2;
wire signed [7:0]line_3;
wire rdy_linebuffer;

reg valid_out_r;
assign valid_out=valid_out_r;

reg                 [10:0]  col_cnt         ;
reg                 [10:0]  row_cnt         ;
always @(posedge clk or negedge rst_n)
    if(rst_n == 1'b0)
        col_cnt             <=          11'd0;
    else if(col_cnt == COL_NUM-1 && valid_in == 1'b1)
        col_cnt             <=          11'd0;
    else if(valid_in == 1'b1)
        col_cnt             <=          col_cnt + 1'b1;
    else
        col_cnt             <=          col_cnt;
reg [3:0]flag;
always @(posedge clk or negedge rst_n)
    if(rst_n == 1'b0)begin
        row_cnt             <=          11'd0;
        flag <= 0;
    end
    else if(row_cnt == ROW_NUM-1 && col_cnt == COL_NUM-1 && valid_in == 1'b1)begin
        row_cnt             <=          11'd0;
    end
    else if(col_cnt == COL_NUM-1 && valid_in == 1'b1) 
        row_cnt             <=          row_cnt + 1'b1;

always @(posedge clk or negedge rst_n)
    if(!rst_n)
        valid_out_r<=0;
    else if(row_cnt==LINE_NUM&&col_cnt==7)
        valid_out_r<=1;
    else
        valid_out_r<=valid_out_r;
        
linebuffer
    #(
    .COL_NUM(COL_NUM),
    .LINE_NUM(LINE_NUM),
    .ROW_NUM(ROW_NUM),
    .WIDTH(WIDTH)
    )
     u_3_linebuffer
    (
    .clk(clk),            // input
    .rst_n(rst_n),            // input
    .valid_in(valid_in),  // input
    .mat_flag(rdy_linebuffer),  // output
    .din(din),            // input[7:0]
    .dout_r0(line_1),    // output[7:0]
    .dout_r1(line_2),    // output[7:0]
    .dout_r2(line_3)     // output[7:0]
);


cal_multi_3INT8 u_cal_multi_3INT8
    (
    .clk(clk),              // input
    .rst_n(rst_n),              // input
    .valid_in(rdy_linebuffer),    // input
    .din_1(line_1),          // input[7:0]
    .din_2(line_2),          // input[7:0]
    .din_3(line_3),          // input[7:0]
    .weight_11(weight_11),  // input[7:0]
    .weight_12(weight_12),  // input[7:0]
    .weight_13(weight_13),  // input[7:0]
    .weight_21(weight_21),  // input[7:0]
    .weight_22(weight_22),  // input[7:0]
    .weight_23(weight_23),  // input[7:0]
    .weight_31(weight_31),  // input[7:0]
    .weight_32(weight_32),  // input[7:0]
    .weight_33(weight_33),  // input[7:0]
    .dout(dout)             // output[17:0]
);

endmodule