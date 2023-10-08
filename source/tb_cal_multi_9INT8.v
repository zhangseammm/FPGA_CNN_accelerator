`timescale 1ns/1ps
`define CLK_PERIOD 20//50MHZ


module tb_cal_multi_9INT8(

   );
    reg clk;
    reg rst_n;
    reg valid_in;

    reg signed [7:0]din_1;
    reg signed [7:0]din_2;
    reg signed [7:0]din_3;

    reg signed [7:0]weight_11;
    reg signed [7:0]weight_12;
    reg signed [7:0]weight_13;
    reg signed [7:0]weight_21;
    reg signed [7:0]weight_22;
    reg signed [7:0]weight_23;
    reg signed [7:0]weight_31;
    reg signed [7:0]weight_32;
    reg signed [7:0]weight_33;

    wire signed [17:0]dout;


    GTP_GRS GRS_INST(
        .GRS_N(1'b1)
    );
initial begin
    clk = 1;
    rst_n=1;
    valid_in = 0;

    #(`CLK_PERIOD * 10);
    rst_n = 0;

    #(`CLK_PERIOD*10);
    rst_n=1;
    #(`CLK_PERIOD*10);
    valid_in = 1;
    #(`CLK_PERIOD*480*5);
    valid_in = 0;
    #(`CLK_PERIOD*20);
    $stop;
end
always #(`CLK_PERIOD/2) clk = ~clk;


always @ (posedge clk or negedge rst_n)begin
    if(rst_n == 1'b10)begin
    din_1<=0;
    din_2<=0;
    din_3<=0;
    weight_11<=1;
    weight_12<=2;
    weight_13<=3;
    weight_21<=1;
    weight_22<=2;
    weight_23<=3;
    weight_31<=1;
    weight_32<=2;
    weight_33<=3;
    end
    else if(din_1 == 140)begin
        din_1 <= 0;
        din_2<=0;
        din_3<=0;
    end
    else if (valid_in == 1'b1)begin
        din_1 <= din_1 + 1'b1;
        din_2 <= din_2 + 1'b1;
        din_3 <= din_3 + 1'b1;

    end
end
cal_multi_3INT8 tb_cal_multi_3INT8
    (
    .clk(clk),              // input
    .rst_n(rst_n),              // input
    .valid_in(valid_in),    // input
    .din_1(din_1),          // input[7:0]
    .din_2(din_2),          // input[7:0]
    .din_3(din_3),          // input[7:0]
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