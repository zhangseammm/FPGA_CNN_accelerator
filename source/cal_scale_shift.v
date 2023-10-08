module cal_scale_shift(
    input clk,
    input signed[15:0]din,
    input [3:0]shift,
    output signed[15:0]dout
   );
    wire zero_flag;
    wire after_flag;
    wire pn_flag;
    reg signed[15:0]dout_temp;
    
    assign even_odd_flag=din[shift];
    assign after_flag=din[shift-1];
    
    assign zero_flag=(((din<<(17-shift))==0)?0:1);
    assign pn_flag=din[15];

    always@(posedge clk) begin
        dout_temp<=(din>>>shift);
    end
    assign dout= (((!after_flag)&&pn_flag)||(after_flag&&zero_flag&&!pn_flag)||(after_flag&&(!zero_flag)&&even_odd_flag&&pn_flag))?(dout_temp+1):dout_temp;

/*
    wire trunc;
	reg trunc_reg;
    wire [15:0] din_h;
	reg signed [15:0] dout_tmp;
	assign din_h=din[29:14];
	assign trunc=din_h[shift];
    always@(posedge clk) begin
		dout_tmp<=(din>>>(15+shift));
		trunc_reg<=trunc;
	end
	assign dout=(trunc_reg==1'b1)?(dout_tmp+1):(dout_tmp);

*/
endmodule