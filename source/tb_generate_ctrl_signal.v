`timescale 1ns/1ps
`define CLK_PERIOD 20//50MHZ

module tb_generate_ctrl_signal(

   );

reg clk;
reg rst_n;
reg valid_in;
wire rst_n_conv;
wire valid_in_conv;
wire valid_in_accu;
reg [20:0]cnt;
initial begin
    clk = 1;
    rst_n = 0;
    valid_in = 0;
    #(`CLK_PERIOD * 10);
    rst_n=1;
    #(`CLK_PERIOD*10);
    valid_in = 1;
    #(`CLK_PERIOD*50*100);
    valid_in = 0;
    #(`CLK_PERIOD*20);
    $stop;
end

always #(`CLK_PERIOD/2) clk = ~clk;
always @ (posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt <= 0;
        
    end
    else if(cnt == 1000000)begin
        cnt <= 1;
        
    end
    else if(valid_in)
        cnt <= cnt+ 1'b1;
        
    
end
generate_ctrl_signal
    tb_ctrl_signal
    (
    .clk(clk),                            // input
    .rst_n(rst_n),                        // input
    .valid_in(valid_in),                  // input
    .rst_n_conv(rst_n_conv),              // output
    .valid_in_conv(valid_in_conv),        // output
    .valid_in_accu(valid_in_accu),        // output
    .valid_in_maxpool(),  // output
    .task_over()                 // output
);
endmodule