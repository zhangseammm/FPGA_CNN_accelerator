module cal_max_pool_2X2
#(
	parameter WIDTH=8
)
(
    input clk,
	input signed [WIDTH-1:0] a,
	input signed [WIDTH-1:0] b,
	input signed [WIDTH-1:0] c,
	input signed [WIDTH-1:0] d,
	output signed [WIDTH-1:0] dout
   );

wire signed[WIDTH-1:0]temp_1;
wire signed[WIDTH-1:0]temp_2;

cal_comparator_two
    #(
    .WIDTH(WIDTH)
    ) comparator_two_1
    (
    .clk(clk),      // input
    .a(a),          // input[7:0]
    .b(b),          // input[7:0]
    .dout(temp_1)     // output[7:0]
);
cal_comparator_two
    #(
    .WIDTH(WIDTH)
    ) comparator_two_2
    (
    .clk(clk),      // input
    .a(c),          // input[7:0]
    .b(d),          // input[7:0]
    .dout(temp_2)     // output[7:0]
);
cal_comparator_two
    #(
    .WIDTH(WIDTH)
    ) comparator_two_3
    (
    .clk(clk),      // input
    .a(temp_1),          // input[7:0]
    .b(temp_2),          // input[7:0]
    .dout(dout)     // output[7:0]
);


endmodule