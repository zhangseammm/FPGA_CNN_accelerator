module module_conv_1x4x3x3(
    input clk,
    input rst_n,
//convolution
    input valid_in,
    input signed [7:0]    din1,
    input signed [7:0]    weight_111,
    input signed [7:0]    weight_112,
    input signed [7:0]    weight_113,
    input signed [7:0]    weight_121,
    input signed [7:0]    weight_122,
    input signed [7:0]    weight_123,
    input signed [7:0]    weight_131,
    input signed [7:0]    weight_132,
    input signed [7:0]    weight_133,
    //input signed [7:0]    zero_point1,   
    
    input signed [7:0]    din2,
    input signed [7:0]    weight_211,
    input signed [7:0]    weight_212,
    input signed [7:0]    weight_213,
    input signed [7:0]    weight_221,
    input signed [7:0]    weight_222,
    input signed [7:0]    weight_223,
    input signed [7:0]    weight_231,
    input signed [7:0]    weight_232,
    input signed [7:0]    weight_233,
    //input signed [7:0]    zero_point2,   
    
    input signed [7:0]    din3,
    input signed [7:0]    weight_311,
    input signed [7:0]    weight_312,
    input signed [7:0]    weight_313,
    input signed [7:0]    weight_321,
    input signed [7:0]    weight_322,
    input signed [7:0]    weight_323,
    input signed [7:0]    weight_331,
    input signed [7:0]    weight_332,
    input signed [7:0]    weight_333,
    //input signed [7:0]    zero_point3,   

    input signed [7:0]    din4,
    input signed [7:0]    weight_411,
    input signed [7:0]    weight_412,
    input signed [7:0]    weight_413,
    input signed [7:0]    weight_421,
    input signed [7:0]    weight_422,
    input signed [7:0]    weight_423,
    input signed [7:0]    weight_431,
    input signed [7:0]    weight_432,
    input signed [7:0]    weight_433,
    //input signed [7:0]    zero_point4,   
    //quantization
    //input [15:0]scale_M0,      // input[15:0]
    input [3:0] shift,            // input[3:0]
    //input [7:0]zero_point_Z3,  // input[7:0]
    //relu
    //input [7:0]relu_zero_point,
    //maxpool

    output valid_out,
    output signed[7:0] dout

/*
    output valid_in_conv,
    output valid_out_conv,

    output valid_in_accu,
    output reg signed[17:0] data_after_conv,
    //output valid_in_accu,
    output valid_out_accu,
    output signed[17:0] data_after_accu_show,

    //output valid_out_quan,
    output signed[7:0] data_after_quan,


    output signed[7:0] data_after_relu,

    output signed[7:0]data_after_pool,
    output valid_in_maxpool
    */
   );

wire signed[17:0]dout1;
wire signed[17:0]dout2;
wire signed[17:0]dout3;
wire signed[17:0]dout4;

generate_ctrl_signal
    u_generate_ctrl_signal
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


wire valid_out_conv;
wire valid_in_accu;
reg signed[17:0] data_after_conv;

wire valid_out_accu;


wire valid_out_quan;
wire signed[7:0] data_after_quan;


wire signed[7:0] data_after_relu;

wire signed[7:0]data_after_pool;

wire valid_in_maxpool;




wire signed[17:0] data_after_accu;
assign data_after_accu_show=data_after_accu;
reg signed[17:0]temp;
always@(posedge clk or negedge rst_n)
    if(!rst_n)begin
        data_after_conv<=0;
        
        end
    else begin
        data_after_conv<=dout1+dout2+dout3+dout4;
        
    end
        
/*
reg [1:0]shift_conv;


always@(posedge clk or negedge rst_n)
    if(!rst_n)begin
        shift_conv<=0;
        end
    else 
        shift_conv<={shift_conv[0],valid_out_conv};

assign valid_in_accu=shift_conv[1];
*/



module_accu_fifo u_module_accu_fifo
    (
    .clk(clk),                    // input
    .rst_n(rst_n),                // input
    .valid_in(valid_in_accu),          // input
    .din(data_after_conv),  // input
    .dout(data_after_accu),  // output
    .valid_out(valid_out_accu)         // output
);



module_quan u_module_quan
    (
    .clk(clk),                // input
    .din(data_after_accu),                // input[17:0]
    //.scale_M0(scale_M0),      // input[15:0]
    .shift(shift),            // input[3:0]
    //.zero_point(zero_point_Z3),  // input[7:0]
    .dout(data_after_quan)               // output[7:0]
);



cal_relu u_cal_relu
    (
    .clk(clk),                // input
    //.zero_point(relu_zero_point),  // input[7:0]
    .data_in(data_after_quan),        // input[7:0]
    .data_out(data_after_relu)       // output[7:0]
);
wire valid_out_relu;
reg [5:0]shift_temp;
always@(posedge clk or negedge rst_n)
    if(rst_n == 1'b0)
        shift_temp<=6'b000000;
    else
        shift_temp<={shift_temp[4:0],valid_out_accu};

assign valid_out_relu=shift_temp[5];


reg valid_in_maxpool_r;
always@(posedge clk or negedge rst_n)
    if(!rst_n)
        valid_in_maxpool_r<=0;
    else if(valid_out_relu)
        valid_in_maxpool_r<=1;


assign valid_in_maxpool=valid_in_maxpool_r;

module_max_pool
     u_module_max_pool
    (
    .clk(clk),                         // input
    .rst_n(rst_n),                     // input
    .valid_in(valid_in_maxpool),       // input
    .valid_out(valid_out),             // output
    .din(data_after_relu),             // input[7:0]
    .dout(data_after_pool)             // output[7:0]
);

assign dout=data_after_pool;


module_conv_same
     u1_module_conv_same
    (
    .clk(clk),                // input
    .rst_n(rst_n_conv&&rst_n),            // input
    .valid_in(valid_in_conv),      // input
    .valid_out(valid_out_conv),    // output
    .din(din1),                // input[7:0]
    .weight_11(weight_111),    // input[7:0]
    .weight_12(weight_112),    // input[7:0]
    .weight_13(weight_113),    // input[7:0]
    .weight_21(weight_121),    // input[7:0]
    .weight_22(weight_122),    // input[7:0]
    .weight_23(weight_123),    // input[7:0]
    .weight_31(weight_131),    // input[7:0]
    .weight_32(weight_132),    // input[7:0]
    .weight_33(weight_133),    // input[7:0]
    //.zero_point(zero_point1),  // input[7:0]
    .dout(dout1)               // output[17:0]
);

module_conv_same
     u2_module_conv_same
    (
    .clk(clk),                // input
    .rst_n(rst_n_conv&&rst_n),            // input
    .valid_in(valid_in_conv),      // input
    .valid_out(),    // output
    .din(din2),                // input[7:0]
    .weight_11(weight_211),    // input[7:0]
    .weight_12(weight_212),    // input[7:0]
    .weight_13(weight_213),    // input[7:0]
    .weight_21(weight_221),    // input[7:0]
    .weight_22(weight_222),    // input[7:0]
    .weight_23(weight_223),    // input[7:0]
    .weight_31(weight_231),    // input[7:0]
    .weight_32(weight_232),    // input[7:0]
    .weight_33(weight_233),    // input[7:0]
    //.zero_point(zero_point2),  // input[7:0]
    .dout(dout2)               // output[17:0]
);

module_conv_same
     u3_module_conv_same
    (
    .clk(clk),                // input
    .rst_n(rst_n_conv&&rst_n),            // input
    .valid_in(valid_in_conv),      // input
    .valid_out(),    // output
    .din(din3),                // input[7:0]
    .weight_11(weight_311),    // input[7:0]
    .weight_12(weight_312),    // input[7:0]
    .weight_13(weight_313),    // input[7:0]
    .weight_21(weight_321),    // input[7:0]
    .weight_22(weight_322),    // input[7:0]
    .weight_23(weight_323),    // input[7:0]
    .weight_31(weight_331),    // input[7:0]
    .weight_32(weight_332),    // input[7:0]
    .weight_33(weight_333),    // input[7:0]
    //.zero_point(zero_point3),  // input[7:0]
    .dout(dout3)               // output[17:0]
);

module_conv_same
     u4_module_conv_same
    (
    .clk(clk),                // input
    .rst_n(rst_n_conv&&rst_n),            // input
    .valid_in(valid_in_conv),      // input
    .valid_out(),    // output
    .din(din4),                // input[7:0]
    .weight_11(weight_411),    // input[7:0]
    .weight_12(weight_412),    // input[7:0]
    .weight_13(weight_413),    // input[7:0]
    .weight_21(weight_421),    // input[7:0]
    .weight_22(weight_422),    // input[7:0]
    .weight_23(weight_423),    // input[7:0]
    .weight_31(weight_431),    // input[7:0]
    .weight_32(weight_432),    // input[7:0]
    .weight_33(weight_433),    // input[7:0]
    //.zero_point(zero_point4),  // input[7:0]
    .dout(dout4)               // output[17:0]
);
endmodule