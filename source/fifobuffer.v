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

parameter WIDTH = 8;//����λ��
parameter IMG_WIDTH = 10;//ͼ����

input  rst_n;
input  clk;
input  [WIDTH-1:0] din;
output [WIDTH-1:0] dout;
input  valid_in;//����������Ч��дʹ��
output valid_out;//�������һ����valid_in��Ҳ����һ����ʼ����ͬʱ��һ���Ϳ��Կ�ʼд��

output   rd_en;//��ʹ��
reg    [8:0] cnt;//����Ŀ��ע��Ҫ����IMG_WIDTH��ֵ�����ã���Ҫ����cnt�ķ�Χ��ͼ����

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