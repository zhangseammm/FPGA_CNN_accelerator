`timescale 1ns/1ps
`define CLK_PERIOD 20//50MHZ
module tb_module_max_pool(

   );
reg clk;
reg valid_in;
reg rst_n;
wire valid_out;
reg signed[7:0]din;
wire signed[7:0]dout;
module_max_pool
     u_tb_module_max_pool
    (
    .clk(clk),              // input
    .rst_n(rst_n),
    .valid_in(valid_in),    // input
    .valid_out(valid_out),  // output
    .din(din),              // input[7:0]
    .dout(dout)             // output[7:0]
);

initial begin
    clk = 1;
    rst_n = 0;
    valid_in = 0;
    #(`CLK_PERIOD * 10);
    rst_n=1;
    #(`CLK_PERIOD*10);
    valid_in = 1;
    #(`CLK_PERIOD*10*10);
    valid_in = 0;
    #(`CLK_PERIOD*20);
    $stop;
end

always #(`CLK_PERIOD/2) clk = ~clk;


always @ (posedge clk or negedge rst_n)begin
    if(!rst_n)
        din <= 1;
    else if(din == 10)
        din <= 1;
    else if (valid_in == 1'b1)
        din <= din + 1'b1;
end

endmodule