module cal_satu_INT18_INT16(
    input clk,
	input [17:0] data_in,
	output reg [15:0] data_out
   );


    wire [17:0] data_in_d;
    assign data_in_d=data_in;


always@(posedge clk) begin
    if( data_in_d[17]==1'b0&&(data_in_d[16:15]!=2'b00))begin

            data_out<=16'b0111_1111_1111_1111;
     
    end
        
    
    else if(data_in_d[17]==1'b1&&(data_in_d[16:15]!=2'b11))
            data_out<=16'b1000_0000_0000_0000;
    else
         data_out<=data_in_d[15:0];
        

end
endmodule