`timescale 1ns/1ps
`define CLK_PERIOD 20//50MHZ


module tb_cal_shift(

   );
reg clk;
reg rst_n;
reg [3:0]shift;
reg signed[15:0] din;
wire signed[15:0] dout;


always #(`CLK_PERIOD/2) clk = ~clk;
initial begin
    clk = 1;
    rst_n = 0;
    //valid_in = 0;
    #(`CLK_PERIOD * 10);
    rst_n=1;
    #(`CLK_PERIOD*10);


    shift=4;
    din = 16'b0000_1111_1111_0000;
    #(`CLK_PERIOD*10);
    shift=4;
    din = 16'b1000_1111_1111_0000;
    #(`CLK_PERIOD*10);


    shift=4;
    din = 16'b0000_1111_1111_1001;
    #(`CLK_PERIOD*10);
    shift=4;
    din = 16'b1000_1111_1111_1001;



    #(`CLK_PERIOD*20);
    shift=4;
    din = 16'b0000_1111_1111_1000;
    #(`CLK_PERIOD*10);
    shift=4;
    din = 16'b1000_1111_1111_1000;
    #(`CLK_PERIOD*10);
    shift=4;
    din = 16'b1000_1111_1110_1000;


     #(`CLK_PERIOD*10);
    shift=0;
    din = 16'b0000_1111_1111_1000;
    #(`CLK_PERIOD*10);


    shift=1;
    din = 16'b1000_1111_1111_1001;


    #(`CLK_PERIOD*20);
    $stop;
end
/*
always @ (posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        din <= 16'b0000_1111_1111_0000;
        
    end
    else if(din == 100)begin
        din <= 1;
        
    end
    else
        din <= din; //+ 1'b1;
        
    end
end
*/
cal_scale tb_cal_scale
    (
    .clk(clk),            // input
    .din(din),            // input[15:0]
    //.scale_M0(0),  // input[15:0]
    .shift(shift),        // input[3:0]
    .dout(dout)           // output[15:0]
);
endmodule
