module generate_ctrl_signal(
    input clk,
    input rst_n,
    input valid_in,
    //input [3:0]task_number,
    output rst_n_conv,
    output valid_in_conv,
    output valid_in_accu,
    output valid_in_rd_en,
    output valid_in_maxpool,
    output task_over
   );


parameter           COL_NUM     =   128    ;
parameter           ROW_NUM     =   128   ;

parameter           START1_ =   2*COL_NUM;
parameter           END1_ =   START1_+COL_NUM*ROW_NUM;


parameter           START2_ =   2*COL_NUM-2+END1_+2;//rst_n
parameter           END2_ =   START2_+COL_NUM*ROW_NUM;


parameter           START3_ =   2*COL_NUM-2+END2_+2;
parameter           END3_ =   START3_+COL_NUM*ROW_NUM;

parameter           START4_ =   2*COL_NUM-2+END3_+2;
parameter           END4_ =   START4_+COL_NUM*ROW_NUM;

parameter           START5_ =   2*COL_NUM-2+END4_+2;
parameter           END5_ =   START5_+COL_NUM*ROW_NUM;

parameter           START6_ =   2*COL_NUM-2+END5_+2;
parameter           END6_ =   START6_+COL_NUM*ROW_NUM;

parameter           START7_ =   2*COL_NUM-2+END6_+2;
parameter           END7_ =   START7_+COL_NUM*ROW_NUM;

parameter           START8_ =   2*COL_NUM-2+END7_+2;
parameter           END8_ =   START8_+COL_NUM*ROW_NUM;

//parameter           MAXPOOL_START =;

reg [63:0]cnt;




reg valid_in_conv_r;
reg valid_in_accu_r;
reg valid_in_maxpool_r;
reg rst_n_conv_r;

assign valid_in_conv=valid_in_conv_r;
assign valid_in_accu=valid_in_accu_r;
assign rst_n_conv=rst_n_conv_r;

always @(posedge clk or negedge rst_n)begin
    if(!rst_n)
        cnt<=0;
    else if(valid_in)
        cnt<=cnt+1;
    else 
        cnt<=cnt;
    end
             
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        rst_n_conv_r<=1;
        valid_in_conv_r<=0;
        valid_in_accu_r<=0;  
    end
    else if(cnt==1)
        valid_in_conv_r<=1;


    else if(cnt==START1_)//第一个特征图卷积
        valid_in_accu_r<=1;
    else if(cnt==END1_)begin
        //valid_in_accu_r<=0;
        valid_in_conv_r<=0;
        rst_n_conv_r<=0;

    end
    else if(cnt==END1_+1)begin
        valid_in_conv_r<=1;
        rst_n_conv_r<=1;
    end


    else if(cnt==START2_)//第2个特征图卷积
        valid_in_accu_r<=1;
    else if(cnt==END2_)begin
        //valid_in_accu_r<=0;
        valid_in_conv_r<=0;
        rst_n_conv_r<=0;
    end

    else if(cnt==END2_+1)begin
        valid_in_conv_r<=1;
        rst_n_conv_r<=1;
    end

    else if(cnt==START3_)//第3个特征图卷积
        valid_in_accu_r<=1;
    else if(cnt==END3_)begin
        //valid_in_accu_r<=0;
        valid_in_conv_r<=0;
        rst_n_conv_r<=0;
    end
    else if(cnt==END3_+1)begin
        valid_in_conv_r<=1;
        rst_n_conv_r<=1;
    end

    else if(cnt==START4_)//第4个特征图卷积
        valid_in_accu_r<=1;
    else if(cnt==END4_)begin
        //valid_in_accu_r<=0;
        valid_in_conv_r<=0;
        rst_n_conv_r<=0;
    end
    else if(cnt==END4_+1)begin
        valid_in_conv_r<=1;
        rst_n_conv_r<=1;
    end

    else if(cnt==START5_)//第5个特征图卷积
        valid_in_accu_r<=1;
    else if(cnt==END5_)begin
        //valid_in_accu_r<=0;
        valid_in_conv_r<=0;
        rst_n_conv_r<=0;
    end
    else if(cnt==END5_+1)begin
        valid_in_conv_r<=1;
        rst_n_conv_r<=1;
    end

    else if(cnt==START6_)//第6个特征图卷积
        valid_in_accu_r<=1;
    else if(cnt==END6_)begin
        //valid_in_accu_r<=0;
        valid_in_conv_r<=0;
        rst_n_conv_r<=0;
    end
    else if(cnt==END6_+1)begin
        valid_in_conv_r<=1;
        rst_n_conv_r<=1;
    end

    else if(cnt==START7_)//第7个特征图卷积
        valid_in_accu_r<=1;
    else if(cnt==END7_)begin
        //valid_in_accu_r<=0;
        valid_in_conv_r<=0;
        rst_n_conv_r<=0;
    end
    else if(cnt==END7_+1)begin
        valid_in_conv_r<=1;
        rst_n_conv_r<=1;
    end

    else if(cnt==START8_)//第8个特征图卷积
        valid_in_accu_r<=1;
    else if(cnt==END8_)
        valid_in_accu_r<=1;
    else begin
        valid_in_accu_r<=valid_in_accu_r;
        valid_in_conv_r<=valid_in_conv_r;
        rst_n_conv_r<=rst_n_conv_r;
    end





end
    
endmodule