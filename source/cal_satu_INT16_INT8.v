module cal_satu_INT16_INT8(
    input clk,
	input [15:0] data_in,
	output reg [7:0] data_out
   );


    wire [15:0] data_in_d;
    assign data_in_d=data_in;


always@(posedge clk) begin
    if( data_in_d[15]==1'b0&&(data_in_d[14:7]!=2'b0000_000))

         data_out<=8'b0111_1111;
        
    else if(data_in_d[15]==1'b1&&(data_in_d[14:7]!=2'b1111_111))
         data_out<=8'b1000_0000;
    else
         data_out<=data_in_d[7:0];
        

end
endmodule