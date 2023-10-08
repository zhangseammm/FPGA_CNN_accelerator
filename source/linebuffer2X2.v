module linebuffer2X2(

 clk,
    rst_n,
    valid_in,//输入数据有效信号
    din,//输入的图像数据，将一帧的数据从左到右，然后从上到下依次输入
    
    dout_r0,//第一行的输出数据
    dout_r1,//第二行的输出数据
    mat_flag
);

parameter WIDTH = 8;//数据位宽
parameter           COL_NUM     =   10    ;
parameter           ROW_NUM     =   10     ;
parameter LINE_NUM = 1;//行缓存的行数

input clk;
input rst_n;
input valid_in;
input [WIDTH-1:0] din;

output[WIDTH-1:0] dout_r0;
output[WIDTH-1:0] dout_r1;
output mat_flag;

reg   [WIDTH-1:0] line[LINE_NUM-1:0];//保存每个line_buffer的输入数据
reg   valid_in_r  [LINE_NUM-1:0];
wire  valid_out_r [LINE_NUM-1:0];
wire  [WIDTH-1:0] dout_r[LINE_NUM-1:0];//保存每个line_buffer的输出数据

assign dout_r0 = dout_r[0];

assign dout_r1=din;

genvar i;
generate
    begin:HDL1
    for (i = 0;i < LINE_NUM;i = i +1)
        begin : buffer_inst
            // line 1
            if(i == 0) begin: MAPO
                always @(*)begin
                    line[i]<=din;
                    valid_in_r[i]<= valid_in;//第一个line_fifo的din和valid_in由顶层直接提供
                end
            end
            // line 2 3 ...
            if(~(i == 0)) begin: MAP1
                always @(*) begin
                	//将上一个line_fifo的输出连接到下一个line_fifo的输入
                    line[i] <= dout_r[i-1];
                    //当上一个line_fifo写入480个数据之后拉高rd_en，表示开始读出数据；
                    //valid_out和rd_en同步，valid_out赋值给下一个line_fifo的
                    //valid_in,表示可以开始写入了
                    valid_in_r[i] <= valid_out_r[i-1];
                end
            end
        fifobuffer #(WIDTH,COL_NUM)
            fifo_buffer_inst(
                .rst_n (rst_n),
                .clk (clk),
                .din (line[i]),
                .dout (dout_r[i]),
                .valid_in(valid_in_r[i]),
                .valid_out (valid_out_r[i])
                );
        end
    end
endgenerate
reg                 [10:0]  col_cnt         ;
reg                 [10:0]  row_cnt         ;

assign      mat_flag        =       row_cnt >= LINE_NUM ? valid_in : 1'b0;

always @(posedge clk or negedge rst_n)
    if(rst_n == 1'b0)
        col_cnt             <=          11'd0;
    else if(col_cnt == COL_NUM-1 && valid_in == 1'b1)
        col_cnt             <=          11'd0;
    else if(valid_in == 1'b1)
        col_cnt             <=          col_cnt + 1'b1;
    else
        col_cnt             <=          col_cnt;

always @(posedge clk or negedge rst_n)
    if(rst_n == 1'b0)
        row_cnt             <=          11'd0;
    else if(row_cnt == ROW_NUM-1 && col_cnt == COL_NUM-1 && valid_in == 1'b1)
        row_cnt             <=          11'd0;
    else if(col_cnt == COL_NUM-1 && valid_in == 1'b1) 
        row_cnt             <=          row_cnt + 1'b1;
endmodule