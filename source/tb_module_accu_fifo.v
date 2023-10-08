`timescale 1ns/1ps
`define CLK_PERIOD 20//50MHZ

module tb_module_accu_fifo(

   );
reg clk;
reg rst_n;
reg valid_in;
reg valid_in_rd_en;
reg signed[17:0] din;
wire signed[17:0] dout;
wire valid_out;
wire signed[17:0]rd_data;
wire signed[17:0]wr_data;
initial begin
    clk = 1;
    rst_n = 0;
    valid_in = 0;
    #(`CLK_PERIOD * 10);
    rst_n=1;
    #(`CLK_PERIOD*10);
    valid_in = 1;
    #(`CLK_PERIOD*100*1);
    //valid_in = 0;
    #(`CLK_PERIOD*100*1);
    valid_in = 1;
    #(`CLK_PERIOD*100*8);
    valid_in = 0;
    #(`CLK_PERIOD*20);
    $stop;
end

always #(`CLK_PERIOD/2) clk = ~clk;
GTP_GRS GRS_INST(
        .GRS_N(1'b1)
    );

always @ (posedge clk or negedge rst_n)begin
    if(!rst_n||valid_in == 1'b0)begin
        din <= 0;
        
    end
    else if(din == 120)begin
        din <= 1;
        
    end
    else if (valid_in == 1'b1)begin
        din <= din+1; //+ 1'b1;
        
    end
    else
        din<=din;
end


module_accu_fifo
     u_module_accu_fifo
    (
    .clk(clk),                  // input
    .rst_n(rst_n),              // input
    .valid_in(valid_in),        // input
    .valid_in_rd_en(valid_in_rd_en),
    .din(din),                  // input[15:0]
    .valid_out(valid_out),
    .dout(dout),                 // output[15:0]
    .rd_data(rd_data),
    .wr_data(wr_data)
);
endmodule