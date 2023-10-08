`timescale 1ns/1ps
module fifobuffer(
        rst_n,
        clk,
        din,
        dout,
        valid_in,
        valid_out,
        rd_en
    );

parameter WIDTH = 8;//数据位宽
parameter IMG_WIDTH = 10;//图像宽度

input  rst_n;
input  clk;
input  [WIDTH-1:0] din;
output [WIDTH-1:0] dout;
input  valid_in;//输入数据有效，写使能
output valid_out;//输出给下一级的valid_in，也即上一级开始读的同时下一级就可以开始写入

output   rd_en;//读使能
reg    [8:0] cnt;//这里的宽度注意要根据IMG_WIDTH的值来设置，需要满足cnt的范围≥图像宽度

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        cnt <= {9{1'b0}};
    else if(valid_in)
        if(cnt == IMG_WIDTH)
            cnt <= IMG_WIDTH;
        else
            cnt <= cnt +1'b1;
    else
        cnt <= cnt;
end

assign rd_en = ((cnt == IMG_WIDTH) && (valid_in)) ? 1'b1:1'b0;
assign valid_out = rd_en;
/*
line_fifo u_line_fifo(
    .clk (clk),
    .rst (rst),
    .din (din),
    .wr_en (valid_in),
    .rd_en (rd_en),
    .dout(dout),

    .empty(),
    .full(),
    .data_count(),    
    .wr_rst_busy(),  
    .rd_rst_busy()
);
*/
fifo_buffer u_line_fifo (
  .wr_data(din),              // input [7:0]
  .wr_en(valid_in),                  // input
  .full(),                    // output
  .almost_full(),      // output
  .rd_data(dout),              // output [7:0]
  .rd_en(rd_en),                  // input
  .empty(),                  // output
  .almost_empty(),    // output
  .clk(clk),                      // input
  .rst(!rst_n)                       // input
);



endmodule