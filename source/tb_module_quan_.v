`timescale 1ns/1ps
`define CLK_PERIOD 20//50MHZ
module tb_module_quan_(

   );


reg clk;
reg [17:0] din;
wire [7:0] dout;
reg [15:0]scale_M0;
reg [3:0]shift;
reg [7:0]zero_point;
module_quan tb_quan
    (
    .clk(clk),                // input
    .din(din),                // input[17:0]
    .scale_M0(scale_M0),      // input[15:0]
    .shift(shift),            // input[3:0]
    .zero_point(zero_point),  // input[7:0]
    .dout(dout)               // output[7:0]
);

 initial begin
    clk = 1;
    
   
    #(`CLK_PERIOD * 10);
    din = 18'b1011_1010_1111_0000_10;
    shift=3'b101;
    scale_M0=15'b0000_0000_0000_001;
    zero_point=8'b_0000_0001;
    #(`CLK_PERIOD*10);
    din = 18'b0001_1010_1111_0000_10;

    #(`CLK_PERIOD*20);
    $stop;
end

always #(`CLK_PERIOD/2) clk = ~clk;
endmodule