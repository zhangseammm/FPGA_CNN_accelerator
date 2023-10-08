`timescale 1ns/1ps
`define CLK_PERIOD 20//50MHZ

module tb_cal_max_pool(

   );
reg clk;
reg [7:0]a;
reg [7:0]b;
reg [7:0]c;
reg [7:0]d;
wire [7:0]dout;
parameter WIDTH=8;


cal_max_pool_2X2
    #(
    .WIDTH(WIDTH)
    ) tb_cal_max_pool_2X2
    (
    .clk(clk),      // input
    .a(a),          // input[7:0]
    .b(b),          // input[7:0]
    .c(c),          // input[7:0]
    .d(d),          // input[7:0]
    .dout(dout)     // output[7:0]
);

initial begin
    clk = 0;

    #(`CLK_PERIOD * 10);

    #(`CLK_PERIOD*10);

    #(`CLK_PERIOD*480*272);

    #(`CLK_PERIOD*20);
    $stop;
end
always #(`CLK_PERIOD/2) clk = ~clk;
always @ (posedge clk)begin
    a<=1;
    b<=2;
    c<=3;
    d<=3;
end
endmodule