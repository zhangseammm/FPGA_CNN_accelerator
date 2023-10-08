
`timescale 1ns/1ps
`define CLK_PERIOD 20//50MHZ
module tb_cal_satu_18_16(

   );


reg clk;
reg [17:0] data_in;
wire [15:0] data_out;

cal_satu_INT18_INT16 u_cal_sat_int18_int16
    (
    .clk(clk),            // input
    .data_in(data_in),    // input[17:0]
    .data_out(data_out)   // output[15:0]
);

 initial begin
    clk = 0;
    
   
    #(`CLK_PERIOD * 10);
    data_in = 18'b1011_1010_1111_0000_10;

    #(`CLK_PERIOD*10);
    data_in = 18'b0001_1010_1111_0000_10;

    #(`CLK_PERIOD*20);
    $stop;
end

always #(`CLK_PERIOD/2) clk = ~clk;
endmodule