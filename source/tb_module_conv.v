`timescale 1ns/1ps
`define CLK_PERIOD 20//50MHZ
module tb_module_conv(

);


    reg clk;
    reg rst_n;
    reg valid_in;

    reg signed [7:0]din;
    //wire valid_in_conv;
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
    //reg signed [7:0]bias;
    reg signed [7:0]zero_point;
    wire signed [17:0]dout;


    GTP_GRS GRS_INST(
        .GRS_N(1'b1)
    );

   initial begin
    clk = 1;
    rst_n = 0;
    valid_in = 0;
    #(`CLK_PERIOD * 10);
    rst_n=1;
    #(`CLK_PERIOD*10);
    valid_in = 1;
    #(`CLK_PERIOD*12*14);
    valid_in = 0;
    #(`CLK_PERIOD*20);
    $stop;
end
always #(`CLK_PERIOD/2) clk = ~clk;


always @ (posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)begin
    din<=1;
    weight_11<=1;
    weight_12<=1;
    weight_13<=1;
    weight_21<=1;
    weight_22<=1;
    weight_23<=1;
    weight_31<=1;
    weight_32<=1;
    weight_33<=1;
    //bias<=1;
    zero_point<=0;
    end
    else if(din == 11)begin
        din <= 1;
    end
    else if (valid_in == 1'b1)begin
    din <= din + 1'b1;



    end
end
module_conv_same u_module_conv_same
    (
    .clk(clk),                      // input
    .rst_n(rst_n),                  // input
    .valid_in(valid_in),            // input
    .valid_out(valid_out),          // output
    //.valid_in_conv(valid_in_conv),  // output
    .din(din),                      // input[7:0]
    .weight_11(weight_11),          // input[7:0]
    .weight_12(weight_12),          // input[7:0]
    .weight_13(weight_13),          // input[7:0]
    .weight_21(weight_21),          // input[7:0]
    .weight_22(weight_22),          // input[7:0]
    .weight_23(weight_23),          // input[7:0]
    .weight_31(weight_31),          // input[7:0]
    .weight_32(weight_32),          // input[7:0]
    .weight_33(weight_33),          // input[7:0]
    //.bias(bias),
    .zero_point(zero_point),
    .dout(dout) 
);
endmodule