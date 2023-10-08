module cal_scale_multi(

	input clk,
	input signed [15:0] din,
	input signed [15:0] scale_M0,
	output reg signed [31:0] dout
);
	reg signed [15:0] din_d;
	reg signed [15:0] scale_d;
	reg signed [31:0] dout_t;
	always@(posedge clk) begin
		din_d<=din;
		scale_d<=scale_M0;
		dout_t<=din_d*scale_d;
		dout<=dout_t;
	end
endmodule