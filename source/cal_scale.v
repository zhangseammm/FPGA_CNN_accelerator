module cal_scale(

	input clk,
	input signed [15:0] din,
    //input signed [15:0] scale_M0,
	input [3:0] shift,
	output signed [15:0] dout

   );
/*
wire [31:0] tmp;

	cal_scale_multi u_cal_scale_multi
	(
		.clk(clk),
		.din(din),
		.scale_M0(scale_M0),
		.dout(tmp)
	);
*/
	cal_scale_shift u_cal_scale_shift
	(
		.clk(clk),
		.din(din),
		.shift(shift),
		.dout(dout)
	);
endmodule