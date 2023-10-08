module cal_multi_3INT8(
    input clk,
    input rst_n,
    input valid_in,

    input signed [7:0]din_1,
    input signed [7:0]din_2,
    input signed [7:0]din_3,

    input signed [7:0]weight_11,
    input signed [7:0]weight_12,
    input signed [7:0]weight_13,
    input signed [7:0]weight_21,
    input signed [7:0]weight_22,
    input signed [7:0]weight_23,
    input signed [7:0]weight_31,
    input signed [7:0]weight_32,
    input signed [7:0]weight_33,

    output signed [17:0]dout   
    
   );
    parameter WIDTH = 8;//数据位宽
    //parameter           COL_NUM     =   12    ;
    //parameter           ROW_NUM     =   12     ;
    parameter LINE_NUM = 2;//行缓存的行数


    wire signed [17:0]result;
    

    wire signed [15:0]result_11;
    wire signed [15:0]result_12;
    wire signed [15:0]result_13;
    wire signed [15:0]result_21;
    wire signed [15:0]result_22;
    wire signed [15:0]result_23;    
    wire signed [15:0]result_31;
    wire signed [15:0]result_32;
    wire signed [15:0]result_33;

    assign dout= result;

wire cal_multi_en=!0;



acc_multi_3 u_acc_multi_31
    (
    .clk(clk),                // input
    .rst_n(rst_n),                // input
    .ce(cal_multi_en),                  // input
    .weight_111(weight_11),  // input[7:0]
    .weight_112(weight_12),  // input[7:0]
    .weight_113(weight_13),  // input[7:0]
    .din(din_1),                // input[7:0]
    .dout_1(result_11),          // output[15:0]
    .dout_2(result_12),          // output[15:0]
    .dout_3(result_13)           // output[15:0]
);
acc_multi_3 u_acc_multi_32
    (
    .clk(clk),                // input
    .rst_n(rst_n),                // input
    .ce(cal_multi_en),                  // input
    .weight_111(weight_21),  // input[7:0]
    .weight_112(weight_22),  // input[7:0]
    .weight_113(weight_23),  // input[7:0]
    .din(din_2),                // input[7:0]
    .dout_1(result_21),          // output[15:0]
    .dout_2(result_22),          // output[15:0]
    .dout_3(result_23)           // output[15:0]
);
acc_multi_3 u_acc_multi_33
    (
    .clk(clk),                // input
    .rst_n(rst_n),                // input
    .ce(cal_multi_en),                  // input
    .weight_111(weight_31),  // input[7:0]
    .weight_112(weight_32),  // input[7:0]
    .weight_113(weight_33),  // input[7:0]
    .din(din_3),                // input[7:0]
    .dout_1(result_31),          // output[15:0]
    .dout_2(result_32),          // output[15:0]
    .dout_3(result_33)           // output[15:0]
);
cal_adder_9INT8 u_cal_adder_9INT8
    (
    .clk(clk),    // input
    .a0(result_11),      // input[15:0]
    .a1(result_12),      // input[15:0]
    .a2(result_13),      // input[15:0]
    .a3(result_21),      // input[15:0]
    .a4(result_22),      // input[15:0]
    .a5(result_23),      // input[15:0]
    .a6(result_31),      // input[15:0]
    .a7(result_32),      // input[15:0]
    .a8(result_33),      // input[15:0]
    .dout(result)   // output[17:0]
);

    
endmodule