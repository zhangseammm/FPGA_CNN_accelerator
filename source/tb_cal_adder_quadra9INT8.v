`timescale 1ns/1ps
`define CLK_PERIOD 20//50MHZ
module tb_cal_adder_quadra9INT8(

   );
reg clk;
reg rst_n;
    reg signed[15:0]a0;
    reg signed[15:0]a1;
    reg signed[15:0]a2;
    reg signed[15:0]a3;
    reg signed[15:0]a4;
    reg signed[15:0]a5;
    reg signed[15:0]a6;
    reg signed[15:0]a7;
    reg signed[15:0]a8;
                      
    reg signed[15:0]b0;
    reg signed[15:0]b1;
    reg signed[15:0]b2;
    reg signed[15:0]b3;
    reg signed[15:0]b4;
    reg signed[15:0]b5;
    reg signed[15:0]b6;
    reg signed[15:0]b7;
    reg signed[15:0]b8;
                      
    reg signed[15:0]c0;
    reg signed[15:0]c1;
    reg signed[15:0]c2;
    reg signed[15:0]c3;
    reg signed[15:0]c4;
    reg signed[15:0]c5;
    reg signed[15:0]c6;
    reg signed[15:0]c7;
    reg signed[15:0]c8;
                      
    reg signed[15:0]d0;
    reg signed[15:0]d1;
    reg signed[15:0]d2;
    reg signed[15:0]d3;
    reg signed[15:0]d4;
    reg signed[15:0]d5;
    reg signed[15:0]d6;
    reg signed[15:0]d7;
    reg signed[15:0]d8;

    wire signed[17:0]dout;




cal_adder_quadra9INT8 tb_cal_adder_quadra9INT8
    (
    .clk(clk),    // input
    .a0(a0),      // input[15:0]
    .a1(a1),      // input[15:0]
    .a2(a2),      // input[15:0]
    .a3(a3),      // input[15:0]
    .a4(a4),      // input[15:0]
    .a5(a5),      // input[15:0]
    .a6(a6),      // input[15:0]
    .a7(a7),      // input[15:0]
    .a8(a8),      // input[15:0]
    .b0(b0),      // input[15:0]
    .b1(b1),      // input[15:0]
    .b2(b2),      // input[15:0]
    .b3(b3),      // input[15:0]
    .b4(b4),      // input[15:0]
    .b5(b5),      // input[15:0]
    .b6(b6),      // input[15:0]
    .b7(b7),      // input[15:0]
    .b8(b8),      // input[15:0]
    .c0(c0),      // input[15:0]
    .c1(c1),      // input[15:0]
    .c2(c2),      // input[15:0]
    .c3(c3),      // input[15:0]
    .c4(c4),      // input[15:0]
    .c5(c5),      // input[15:0]
    .c6(c6),      // input[15:0]
    .c7(c7),      // input[15:0]
    .c8(c8),      // input[15:0]
    .d0(d0),      // input[15:0]
    .d1(d1),      // input[15:0]
    .d2(d2),      // input[15:0]
    .d3(d3),      // input[15:0]
    .d4(d4),      // input[15:0]
    .d5(d5),      // input[15:0]
    .d6(d6),      // input[15:0]
    .d7(d7),      // input[15:0]
    .d8(d8),      // input[15:0]
    .dout(dout)   // output[17:0]
);

initial begin
    clk = 1;
    rst_n = 0;
    
    #(`CLK_PERIOD * 10);
    rst_n=1;
    #(`CLK_PERIOD*10);
    
    #(`CLK_PERIOD*10*10);
    
    #(`CLK_PERIOD*20);
    $stop;
end

always #(`CLK_PERIOD/2) clk = ~clk;


always @ (posedge clk or negedge rst_n)begin
    if(!rst_n)
        a0 <= 1;
    else begin
        a0<= 1;
a1<= 1;
a2<= 1;
a3<= 1;
a4<= 1;
a5<= 1;
a6<= 1;
a7<= 1;
a8<= 1;
  
b0<= 1;
b1<= 1;
b2<= 1;
b3<= 1;
b4<= 1;
b5<= 1;
b6<= 1;
b7<= 1;
b8<= 1;
  
c0<= 1;
c1<= 1;
c2<= 1;
c3<= 1;
c4<= 1;
c5<= 1;
c6<= 1;
c7<= 1;
c8<= 1;
  
d0<= 1;
d1<= 1;
d2<= 1;
d3<= 1;
d4<= 1;
d5<= 1;
d6<= 1;
d7<= 1;
d8 <= 1;
  end 
end

endmodule