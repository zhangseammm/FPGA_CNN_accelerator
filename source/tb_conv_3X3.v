`timescale 1ns/1ps
`define CLK_PERIOD 20//50MHZ
module tb_conv_3X3(


);


    reg clk;
    reg rst_n;
    reg valid_in;

    reg signed [7:0]din;

    wire valid_out;
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
    clk = 0;
    rst_n = 0;
    valid_in = 0;
    #(`CLK_PERIOD * 10);
    rst_n=1;
    #(`CLK_PERIOD*10);
    valid_in = 1;
    #(`CLK_PERIOD*480*272);
    valid_in = 0;
    #(`CLK_PERIOD*20);
    $stop;
end
always #(`CLK_PERIOD/2) clk = ~clk;


always @ (posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)begin
    din<=0;
    weight_11<=0;
    weight_12<=0;
    weight_13<=1;
    weight_21<=0;
    weight_22<=0;
    weight_23<=1;
    weight_31<=0;
    weight_32<=0;
    weight_33<=1;
    end
    else if(din == 118)begin
        din <= 0;
    end
    else if (valid_in == 1'b1)begin
    din <= din + 1'b1;



    end
end
conv_3X3 u_conv_3X3
    (
    .clk(clk),              // input
    .rst_n(rst_n),              // input
    .valid_in(valid_in),    // input
    .din(din),              // input[7:0]
    .weight_11(weight_11),  // input[7:0]
    .weight_12(weight_12),  // input[7:0]
    .weight_13(weight_13),  // input[7:0]
    .weight_21(weight_21),  // input[7:0]
    .weight_22(weight_22),  // input[7:0]
    .weight_23(weight_23),  // input[7:0]
    .weight_31(weight_31),  // input[7:0]
    .weight_32(weight_32),  // input[7:0]
    .weight_33(weight_33),  // input[7:0]
    .valid_out(valid_out),
    .dout(dout)             // output[17:0]
);
endmodule