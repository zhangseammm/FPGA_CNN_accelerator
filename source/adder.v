//Author: zym
//Date:2022.3.6


`timescale 1ns/1ps

module acc_multi_3(
    input clk,
    input rst_n,
    input ce,

    input signed[7:0]weight_111,
    input signed[7:0]weight_112,
    input signed[7:0]weight_113,
    input signed[7:0]din,

    output signed[15:0]dout_1,
    output signed[15:0]dout_2,
    output signed[15:0]dout_3


    
);


wire signed[15:0]result_1;
wire signed[15:0]result_2;
wire signed[15:0]result_3;

reg signed[7:0]din_reg1;
reg signed[7:0]din_reg2;
reg signed[7:0]din_reg3;

assign dout_1 = result_1;
assign dout_2 = result_2;
assign dout_3 = result_3;


always@(posedge clk or negedge rst_n) begin
    if(rst_n == 1'b0)begin
        din_reg1<=0;
        din_reg2<=0;
        din_reg3<=0;
    end
    else if(ce)begin
        din_reg1<=din;
        din_reg2<=din_reg1;
        din_reg3<=din_reg2;
        
    end

end
cal_mul u_cal_mul_1 (
  .a(din_reg3),        // input [7:0]
  .b(weight_113),        // input [7:0]
  .clk(clk),    // input
  .rst(!rst_n),    // input
  .ce(ce),      // input
  .p(result_1)         // output [15:0]
);


cal_mul u_cal_mul_2 (
  .a(din_reg2),        // input [7:0]
  .b(weight_112),        // input [7:0]
  .clk(clk),    // input
  .rst(!rst_n),    // input
  .ce(ce),      // input
  .p(result_2)         // output [15:0]
);


cal_mul u_cal_mul_3 (
  .a(din_reg1),        // input [7:0]
  .b(weight_111),        // input [7:0]
  .clk(clk),    // input
  .rst(!rst_n),    // input
  .ce(ce),      // input
  .p(result_3)         // output [15:0]
);

endmodule