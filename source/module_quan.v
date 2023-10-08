module module_quan(//dout delay din 5 clocks
    	input clk,
	input signed [17:0] din,
	//input signed [15:0] scale_M0,
    input [3:0] shift,
	input [7:0] zero_point,
	output [7:0] dout
   );


wire signed [15:0]after_satu_INT16;
wire signed [15:0]after_scale_INT16;
wire signed [7:0]after_satu_INT8;

cal_satu_INT18_INT16 u_cal_satu_INT18_INT16
    (
    .clk(clk),                    // input
    .data_in(din),                // input[17:0]
    .data_out(after_satu_INT16)   // output[15:0]
);

cal_scale u_cal_scale
    (
    .clk(clk),            // input
    .din(after_satu_INT16),            // input[15:0]
    //.scale_M0(scale_M0),  // input[15:0]
    .shift(shift),        // input[3:0]
    .dout(after_scale_INT16)           // output[15:0]
);

cal_satu_INT16_INT8 u_cal_satu_INT16_INT8
    (
    .clk(clk),            // input
    .data_in(after_scale_INT16),    // input[15:0]
    .data_out(after_satu_INT8)   // output[7:0]
);

assign dout=after_satu_INT8+zero_point;

endmodule
