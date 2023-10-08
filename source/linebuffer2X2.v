module linebuffer2X2(

 clk,
    rst_n,
    valid_in,//����������Ч�ź�
    din,//�����ͼ�����ݣ���һ֡�����ݴ����ң�Ȼ����ϵ�����������
    
    dout_r0,//��һ�е��������
    dout_r1,//�ڶ��е��������
    mat_flag
);

parameter WIDTH = 8;//����λ��
parameter           COL_NUM     =   10    ;
parameter           ROW_NUM     =   10     ;
parameter LINE_NUM = 1;//�л��������

input clk;
input rst_n;
input valid_in;
input [WIDTH-1:0] din;

output[WIDTH-1:0] dout_r0;
output[WIDTH-1:0] dout_r1;
output mat_flag;

reg   [WIDTH-1:0] line[LINE_NUM-1:0];//����ÿ��line_buffer����������
reg   valid_in_r  [LINE_NUM-1:0];
wire  valid_out_r [LINE_NUM-1:0];
wire  [WIDTH-1:0] dout_r[LINE_NUM-1:0];//����ÿ��line_buffer���������

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
                    valid_in_r[i]<= valid_in;//��һ��line_fifo��din��valid_in�ɶ���ֱ���ṩ
                end
            end
            // line 2 3 ...
            if(~(i == 0)) begin: MAP1
                always @(*) begin
                	//����һ��line_fifo��������ӵ���һ��line_fifo������
                    line[i] <= dout_r[i-1];
                    //����һ��line_fifoд��480������֮������rd_en����ʾ��ʼ�������ݣ�
                    //valid_out��rd_enͬ����valid_out��ֵ����һ��line_fifo��
                    //valid_in,��ʾ���Կ�ʼд����
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