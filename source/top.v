/*
module top(
    input clk,
    input rst_n,
    input valid_in

);

    wire signed [7:0]    din1;
    wire signed [7:0]    weight_111;
    wire signed [7:0]    weight_112;
    wire signed [7:0]    weight_113;
    wire signed [7:0]    weight_121;
    wire signed [7:0]    weight_122;
    wire signed [7:0]    weight_123;
    wire signed [7:0]    weight_131;
    wire signed [7:0]    weight_132;
    wire signed [7:0]    weight_133;
    wire signed [7:0]    din2     ;
    wire signed [7:0]    weight_211;
    wire signed [7:0]    weight_212;
    wire signed [7:0]    weight_213;
    wire signed [7:0]    weight_221;
    wire signed [7:0]    weight_222;
    wire signed [7:0]    weight_223;
    wire signed [7:0]    weight_231;
    wire signed [7:0]    weight_232;
    wire signed [7:0]    weight_233;
                                   
                                   
    wire signed [7:0]    din3     ;
    wire signed [7:0]    weight_311;
    wire signed [7:0]    weight_312;
    wire signed [7:0]    weight_313;
    wire signed [7:0]    weight_321;
    wire signed [7:0]    weight_322;
    wire signed [7:0]    weight_323;
    wire signed [7:0]    weight_331;
    wire signed [7:0]    weight_332;
    wire signed [7:0]    weight_333;
                                   
    wire signed [7:0]    din4     ;
    wire signed [7:0]    weight_411;
    wire signed [7:0]    weight_412;
    wire signed [7:0]    weight_413;
    wire signed [7:0]    weight_421;
    wire signed [7:0]    weight_422;
    wire signed [7:0]    weight_423;
    wire signed [7:0]    weight_431;
    wire signed [7:0]    weight_432;
    wire signed [7:0]    weight_433;
    
    wire [3:0] shift;           // input[3:0]


   wire valid_out;
    wire signed[7:0] dout;



module_conv_1x4x3x3 u_module_conv_1x4x3x3
    (
    .clk(clk),                // input
    .rst_n(rst_n),            // input
    .valid_in(valid_in),      // input
    .valid_out(valid_out),    // output
    .din1(din1),              // input[7:0]
    .weight_111(weight_111),  // input[7:0]
    .weight_112(weight_112),  // input[7:0]
    .weight_113(weight_113),  // input[7:0]
    .weight_121(weight_121),  // input[7:0]
    .weight_122(weight_122),  // input[7:0]
    .weight_123(weight_123),  // input[7:0]
    .weight_131(weight_131),  // input[7:0]
    .weight_132(weight_132),  // input[7:0]
    .weight_133(weight_133),  // input[7:0]
    .din2(din2),              // input[7:0]
    .weight_211(weight_211),  // input[7:0]
    .weight_212(weight_212),  // input[7:0]
    .weight_213(weight_213),  // input[7:0]
    .weight_221(weight_221),  // input[7:0]
    .weight_222(weight_222),  // input[7:0]
    .weight_223(weight_223),  // input[7:0]
    .weight_231(weight_231),  // input[7:0]
    .weight_232(weight_232),  // input[7:0]
    .weight_233(weight_233),  // input[7:0]
    .din3(din3),              // input[7:0]
    .weight_311(weight_311),  // input[7:0]
    .weight_312(weight_312),  // input[7:0]
    .weight_313(weight_313),  // input[7:0]
    .weight_321(weight_321),  // input[7:0]
    .weight_322(weight_322),  // input[7:0]
    .weight_323(weight_323),  // input[7:0]
    .weight_331(weight_331),  // input[7:0]
    .weight_332(weight_332),  // input[7:0]
    .weight_333(weight_333),  // input[7:0]
    .din4(din4),              // input[7:0]
    .weight_411(weight_411),  // input[7:0]
    .weight_412(weight_412),  // input[7:0]
    .weight_413(weight_413),  // input[7:0]
    .weight_421(weight_421),  // input[7:0]
    .weight_422(weight_422),  // input[7:0]
    .weight_423(weight_423),  // input[7:0]
    .weight_431(weight_431),  // input[7:0]
    .weight_432(weight_432),  // input[7:0]
    .weight_433(weight_433),  // input[7:0]
    .shift(shift),            // input[3:0]
    .dout(dout)               // output[7:0]
);


endmodule
*/