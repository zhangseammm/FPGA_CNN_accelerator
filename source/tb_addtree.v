module tb_addtree(

   );


    reg signed [15:0]result_11;
    reg signed [15:0]result_12;
    reg signed [15:0]result_13;
    reg signed [15:0]result_21;
    reg signed [15:0]result_22;
    reg signed [15:0]result_23;    
    reg signed [15:0]result_31;
    reg signed [15:0]result_32;
    reg signed [15:0]result_33;
    wire signed [17:0]result;
initial begin
    clk = 1;
    rst=0;
    valid_in = 0;

    #(`CLK_PERIOD * 10);
    rst = 1;
   
    #(`CLK_PERIOD*10);
    rst=0;
    #(`CLK_PERIOD*10);
    valid_in = 1;
    #(`CLK_PERIOD*480*5);
    valid_in = 0;
    #(`CLK_PERIOD*20);
    $stop;
end
always #(`CLK_PERIOD/2) clk = ~clk;
cal_adder_9INT8 tb_cal_adder_9INT8
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