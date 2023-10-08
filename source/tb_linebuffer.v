`timescale 1ns/1ps
`define CLK_PERIOD 20//50MHZ

module matrix_3x3_tb ();
reg clk;
reg [7:0] din;
reg rst_n;
reg valid_in;
//wires
wire [7:0] dout_r0;
wire [7:0] dout_r1;
wire [7:0] dout_r2;
wire mat_flag;
/*
matrix_3x3 matrix_3x3_inst(
    .clk (clk),
    .din (din),
    .dout_r0(dout_r0),
    .dout_r1(dout_r1),
    .dout_r2(dout_r2),
    .rst_n(rst_n),
    .valid_in(valid_in),
    .mat_flag(mat_flag)
);
*/
linebuffer2X2
    u_tb_linebuffer2X2
    (
    .clk(clk),            // input
    .rst_n(rst_n),        // input
    .valid_in(valid_in),  // input
    .mat_flag(mat_flag),  // output
    .din(din),            // input[7:0]
    .dout_r0(dout_r0),    // output[7:0]
    .dout_r1(dout_r1)     // output[7:0]
);
/*
linebuffer
    
     u_linebuffer
    (
    .clk(clk),            // input
    .rst_n(rst_n),        // input
    .valid_in(valid_in),  // input
    .mat_flag(mat_flag),  // output
    .din(din),            // input[7:0]
    .dout_r0(dout_r0),    // output[7:0]
    .dout_r1(dout_r1),    // output[7:0]
    .dout_r2(dout_r2)     // output[7:0]
);
*/
initial begin
    clk = 0;
    rst_n = 0;
    valid_in = 0;
    #(`CLK_PERIOD * 10);
    rst_n=1;
    #(`CLK_PERIOD*10);
    valid_in = 1;
    #(`CLK_PERIOD*480*5);
    valid_in = 0;
    #(`CLK_PERIOD*20);
    $stop;
end

always #(`CLK_PERIOD/2) clk = ~clk;

/*
    ����din����0-479֮�󣬷���0���ٴδ�0-479��
    ���ԣ�ģ���ÿһ�����ݶ��Ǵ�0-479������ڷ���ʱ�������ݶ���ʱ���ǵ����ݲŻ���һ���ġ�

    ��������din����ʵ��ͼ�����ݣ���ô����һ֡ͼ������ÿһ���ǲ�һ���ģ����Զ������������Ҳ����ͬ��
*/
always @ (posedge clk or negedge rst_n)begin
    if(!rst_n)
        din <= 1;
    else if(din == 10)
        din <= 1;
    else if (valid_in == 1'b1)
        din <= din + 1'b1;
end

endmodule

