`timescale 1ns/1ps
`define CLK_PERIOD 20//50MHZ
module tb_module_1x4x3x3(

   );
    
    reg clk;
    reg rst_n;
//coreg ion
    reg valid_in;
    reg signed [7:0]    din1;
    reg signed [7:0]    weight_111;
    reg signed [7:0]    weight_112;
    reg signed [7:0]    weight_113;
    reg signed [7:0]    weight_121;
    reg signed [7:0]    weight_122;
    reg signed [7:0]    weight_123;
    reg signed [7:0]    weight_131;
    reg signed [7:0]    weight_132;
    reg signed [7:0]    weight_133;
    reg signed [7:0]    zero_point1;   
     
    reg signed [7:0]    din2;
    reg signed [7:0]    weight_211;
    reg signed [7:0]    weight_212;
    reg signed [7:0]    weight_213;
    reg signed [7:0]    weight_221;
    reg signed [7:0]    weight_222;
    reg signed [7:0]    weight_223;
    reg signed [7:0]    weight_231;
    reg signed [7:0]    weight_232;
    reg signed [7:0]    weight_233;
    reg signed [7:0]    zero_point2;   
     
    reg signed [7:0]    din3;
    reg signed [7:0]    weight_311;
    reg signed [7:0]    weight_312;
    reg signed [7:0]    weight_313;
    reg signed [7:0]    weight_321;
    reg signed [7:0]    weight_322;
    reg signed [7:0]    weight_323;
    reg signed [7:0]    weight_331;
    reg signed [7:0]    weight_332;
    reg signed [7:0]    weight_333;
    reg signed [7:0]    zero_point3;   
     
    reg signed [7:0]    din4;
    reg signed [7:0]    weight_411;
    reg signed [7:0]    weight_412;
    reg signed [7:0]    weight_413;
    reg signed [7:0]    weight_421;
    reg signed [7:0]    weight_422;
    reg signed [7:0]    weight_423;
    reg signed [7:0]    weight_431;
    reg signed [7:0]    weight_432;
    reg signed [7:0]    weight_433;
    reg signed [7:0]    zero_point4;   
    
    //reg t [15:0]scale_M0,      // input[15:0]
    reg [3:0] shift;            // input[3:0]
    reg [7:0]zero_point_Z3;  // input[7:0]
     
    reg [7:0]relu_zero_point;
    
    wire  valid_out;
    wire  signed[7:0] dout;
    wire valid_in_conv;
    wire valid_out_conv;
wire valid_in_accu;
wire signed[17:0] data_after_conv;

wire valid_out_accu;
wire signed[17:0] data_after_accu;

//wire valid_out_quan;
wire signed[7:0] data_after_quan;


wire signed[7:0] data_after_relu;

wire signed[7:0]data_after_pool;

wire valid_in_maxpool;
reg [20:0]cnt;
GTP_GRS GRS_INST(
        .GRS_N(1'b1)
    );



   initial begin
    clk = 1;
    rst_n = 0;
    valid_in = 0;
    #(`CLK_PERIOD * 10);
    rst_n=1;
    #(`CLK_PERIOD*10);
    valid_in = 1;
    din1=1;       
    weight_111=1; 
    weight_112=1; 
    weight_113=1; 
    weight_121=1; 
    weight_122=1; 
    weight_123=1; 
    weight_131=1; 
    weight_132=1; 
    weight_133=1; 
    zero_point1=0;
                
    din2         =1;       
    weight_211=1; 
    weight_212=1; 
    weight_213=1; 
    weight_221=1; 
    weight_222=1; 
    weight_223=1; 
    weight_231=1; 
    weight_232=1; 
    weight_233=1; 
    zero_point2=0;
                
    din3=1;       
    weight_311=1; 
    weight_312=1; 
    weight_313=1; 
    weight_321=1; 
    weight_322=1; 
    weight_323=1; 
    weight_331=1; 
    weight_332=1; 
    weight_333=1; 
    zero_point3=0;
                
    din4=1;       
    weight_411=1; 
    weight_412=1; 
    weight_413=1; 
    weight_421=1; 
    weight_422=1; 
    weight_423=1; 
    weight_431=1; 
    weight_432=1; 
    weight_433=1; 
    zero_point4=0;
    shift=1;            // input[3:0]
    zero_point_Z3=0;  // input[7:0]
     
    relu_zero_point=0;


    #(`CLK_PERIOD*128*128*10);
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
module_conv_1x4x3x3 tb_conv_1x4x3x3
    (
    .clk(clk),                            // input
    .rst_n(rst_n),                        // input
    .valid_in(valid_in),                  // input
    .valid_out(valid_out),                // output
    .valid_in_conv(valid_in_conv),
    .valid_out_conv(valid_out_conv),      // output
    .valid_in_accu(valid_in_accu),
    .valid_out_accu(valid_out_accu),      // output
    //.valid_out_quan(valid_out_quan),      // output
    .valid_in_maxpool(valid_in_maxpool),  // output
    .din1(din1),                          // input[7:0]
    .weight_111(weight_111),              // input[7:0]
    .weight_112(weight_112),              // input[7:0]
    .weight_113(weight_113),              // input[7:0]
    .weight_121(weight_121),              // input[7:0]
    .weight_122(weight_122),              // input[7:0]
    .weight_123(weight_123),              // input[7:0]
    .weight_131(weight_131),              // input[7:0]
    .weight_132(weight_132),              // input[7:0]
    .weight_133(weight_133),              // input[7:0]
    .zero_point1(zero_point1),            // input[7:0]
    .din2(din2),                          // input[7:0]
    .weight_211(weight_211),              // input[7:0]
    .weight_212(weight_212),              // input[7:0]
    .weight_213(weight_213),              // input[7:0]
    .weight_221(weight_221),              // input[7:0]
    .weight_222(weight_222),              // input[7:0]
    .weight_223(weight_223),              // input[7:0]
    .weight_231(weight_231),              // input[7:0]
    .weight_232(weight_232),              // input[7:0]
    .weight_233(weight_233),              // input[7:0]
    .zero_point2(zero_point2),            // input[7:0]
    .din3(din3),                          // input[7:0]
    .weight_311(weight_311),              // input[7:0]
    .weight_312(weight_312),              // input[7:0]
    .weight_313(weight_313),              // input[7:0]
    .weight_321(weight_321),              // input[7:0]
    .weight_322(weight_322),              // input[7:0]
    .weight_323(weight_323),              // input[7:0]
    .weight_331(weight_331),              // input[7:0]
    .weight_332(weight_332),              // input[7:0]
    .weight_333(weight_333),              // input[7:0]
    .zero_point3(zero_point3),            // input[7:0]
    .din4(din4),                          // input[7:0]
    .weight_411(weight_411),              // input[7:0]
    .weight_412(weight_412),              // input[7:0]
    .weight_413(weight_413),              // input[7:0]
    .weight_421(weight_421),              // input[7:0]
    .weight_422(weight_422),              // input[7:0]
    .weight_423(weight_423),              // input[7:0]
    .weight_431(weight_431),              // input[7:0]
    .weight_432(weight_432),              // input[7:0]
    .weight_433(weight_433),              // input[7:0]
    .zero_point4(zero_point4),            // input[7:0]
    .shift(shift),                        // input[3:0]
    .zero_point_Z3(zero_point_Z3),        // input[7:0]
    .relu_zero_point(relu_zero_point),    // input[7:0]
    .dout(dout), 
    .data_after_conv(data_after_conv),                       // output[7:0]
    .data_after_accu_show(data_after_accu),    // output[17:0]
    .data_after_quan(data_after_quan),    // output[7:0]
    .data_after_relu(data_after_relu),    // output[7:0]
    .data_after_pool(data_after_pool)     // output[7:0]
);

endmodule