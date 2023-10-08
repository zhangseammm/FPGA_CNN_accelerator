`timescale 1ns/1ps
`define CLK_PERIOD 20//50MHZ
module tb_module_conv_1X3X3(

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
    reg signed [15:0]scale_M0;
    reg signed [7:0]relu_zero_point;
    reg signed [7:0]zero_point_Z3;
    reg signed [3:0]shift;
    wire signed [17:0]after_conv;
    wire signed [7:0]after_quan;
    wire signed [7:0]dout;


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
    din<=0;
    weight_11<=99;
    weight_12<=99;
    weight_13<=99;
    weight_21<=99;
    weight_22<=99;
    weight_23<=99;
    weight_31<=99;
    weight_32<=99;
    weight_33<=99;
    //bias<=0;
    zero_point<=0;
    scale_M0<=99;
    shift<=1;
    relu_zero_point<=1;
    zero_point_Z3<=1;
    end
    else if(din == 10)begin
        din <= 1;
    end
    else if (valid_in == 1'b1)begin
    din <= din + 1'b1;



    end
end
conv_1X3X3
    u_module_conv_1x3x3
    (
    .clk(clk),                          // input
    .rst_n(rst_n),                      // input
    .valid_in(valid_in),                // input
    .valid_out(valid_out),              // output
    .din(din),                          // input[7:0]
    .zero_point(zero_point),            // input[7:0]
    .weight_11(weight_11),              // input[7:0]
    .weight_12(weight_12),              // input[7:0]
    .weight_13(weight_13),              // input[7:0]
    .weight_21(weight_21),              // input[7:0]
    .weight_22(weight_22),              // input[7:0]
    .weight_23(weight_23),              // input[7:0]
    .weight_31(weight_31),              // input[7:0]
    .weight_32(weight_32),              // input[7:0]
    .weight_33(weight_33),              // input[7:0]
    //.bias(bias),                        // input[7:0]
    .scale_M0(scale_M0),                // input[15:0]
    .shift(shift),                      // input[3:0]
    .relu_zero_point(relu_zero_point),  // input[7:0]
    .zero_point_Z3(zero_point_Z3),      // input[7:0]
    .dout(dout)     ,                    // output[7:0]
     .after_conv(after_conv),            // output[17:0]
    .after_quan(after_quan)             // output[7:0]
);
endmodule