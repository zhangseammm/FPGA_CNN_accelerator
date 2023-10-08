`timescale 1ns/1ps
`define CLK_PERIOD 20//50MHZ

module tb_test(

   );
reg clk;
reg rst;
reg ce;
reg signed[7:0] din;
reg signed[7:0] in_w0;
reg signed[7:0] in_w1;
reg signed[7:0] in_w2;

wire signed[15:0] dout_1;
wire signed[15:0] dout_2;
wire signed[15:0] dout_3;

GTP_GRS GRS_INST(
        .GRS_N(1'b1)
    );

acc_multi_3 tb_acc_multi_3
    (
    .ce(ce),                                        // input
    .clk(clk),                                      // input
    .rst(rst),                                      // input
    .dout_1(dout_1),        // output
    .dout_2(dout_2),        // output
    .dout_3(dout_3),        // output
    .din(din),                // input
    .weight_111(in_w0),  // input
    .weight_112(in_w1),  // input
    .weight_113(in_w2)   // input
);


initial begin
    clk = 1;
    rst = 0;
    ce = 1;
    #(`CLK_PERIOD * 10);
    rst = 1;
    #(`CLK_PERIOD * 1);
    rst = 0;
    #(`CLK_PERIOD * 10);
    ce = 1;
    #(`CLK_PERIOD*480*5);
    ce = 0;
    #(`CLK_PERIOD*20);
    $stop;
end

always #(`CLK_PERIOD/2) clk = ~clk;
always @ (posedge clk or posedge rst)begin
    if(rst == 1'b1)begin
        din <= 1;
        in_w0<=1;
        in_w1<=2;
        in_w2<=3;
    end
    else if(din == 480)begin
        din <= 1;
        in_w0<=1;
        in_w1<=1;
        in_w2<=1;
    end
    else if (ce==1)begin
        din <= din+1 ;
        in_w0 <= in_w0 ;
        in_w1 <= in_w1 ;
        in_w2 <= in_w2 ;
    end
end



endmodule