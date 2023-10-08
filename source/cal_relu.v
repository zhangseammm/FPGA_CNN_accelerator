module cal_relu
(
	input clk,
	//input signed [7:0] zero_point,
	input signed [7:0] data_in,
	output reg signed [7:0] data_out
);
	always@(posedge clk) begin
		if(data_in>=0) begin
			data_out<=data_in;
		end else begin
			data_out<=0;
		end
	end
endmodule