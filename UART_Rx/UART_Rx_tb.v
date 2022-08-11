`include "CONFIG_MACROS_Rx.v"
`timescale 1ns/1ps
module UART_Rx_tb ();

    reg    [4:0]           prescale_tb;
    reg                    RX_IN_tb;
    reg                    PAR_EN_tb;
    reg                    PAR_TYP_tb;
    reg                    CLK_tb;
    reg                    RST_tb;
    wire     [`WIDTH-1:0]    P_DATA_tb;
    wire                    data_valid_tb;

  /*  reg    par_error;
    reg    strt_error;
    reg    stp_error;
    reg    data_samp_enable;
    reg    deser_enable;
    reg    stp_chk_enable;
    reg    strt_chk_enable;
    reg    par_chk_enable;
    reg    counter_enable;
    reg    sampled_bit; */
    
localparam clk_period = 5;
always #(clk_period *0.5)      CLK_tb = ~CLK_tb;
UART_Rx DUT (
    .prescale(prescale_tb),
    .RX_IN(RX_IN_tb),
    .PAR_EN(PAR_EN_tb),
    .PAR_TYP(PAR_TYP_tb),
    .CLK(CLK_tb),
    .RST(RST_tb),
    .P_DATA(P_DATA_tb),
    .data_valid(data_valid_tb)
);
initial begin
    // initialization
        prescale_tb = 5'd8 ;
        RX_IN_tb = 1'b1 ;
        PAR_EN_tb = 1'b0;
        PAR_TYP_tb = 1'b0;
        CLK_tb = 1'b0;
        //reset
        RST_tb = 1'b1;
        #(clk_period * 0.3)
        RST_tb = 1'b0;
        #(clk_period * 0.7)
        RST_tb = 1'b1;
        //$monitor("1-p_data = %b,data_valid_tb =%b",P_DATA_tb,data_valid_tb);
        // start
        RX_IN_tb = 1'b0;
        #(clk_period * 8)
        RX_IN_tb = 1'b1;
        #(clk_period * 8)
        RX_IN_tb = 1'b0;
        #(clk_period * 8)
        RX_IN_tb = 1'b1;
        #(clk_period * 8)
        RX_IN_tb = 1'b0;
        #(clk_period * 8)
        RX_IN_tb = 1'b1;
        #(clk_period * 8)
        RX_IN_tb = 1'b0;
        #(clk_period * 8)
        RX_IN_tb = 1'b1;
        #(clk_period * 8)
        RX_IN_tb = 1'b0;
        #(clk_period * 8)
        RX_IN_tb = 1'b1;
        #(clk_period * 8)
        $display("...............test case 1 with no parity............");
        $display("p_data = %b,data_valid_tb =%b",P_DATA_tb,data_valid_tb);
///////////////////////////////////////////////////////////////////////////////////
        RX_IN_tb = 1'b0;
        #(clk_period * 8)
        RX_IN_tb = 1'b1;
        #(clk_period * 8)
        RX_IN_tb = 1'b1;
        #(clk_period * 8)
        RX_IN_tb = 1'b1;
        #(clk_period * 8)
        RX_IN_tb = 1'b1;
        #(clk_period * 8)
        RX_IN_tb = 1'b0;
        #(clk_period * 8)
        RX_IN_tb = 1'b0;
        #(clk_period * 8)
        RX_IN_tb = 1'b0;
        #(clk_period * 8)
        RX_IN_tb = 1'b0;
        #(clk_period * 8)
        RX_IN_tb = 1'b1;
        #(clk_period * 8)
        $display("...............test case 2 with no parity............");
        $display("p_data = %b,data_valid_tb =%b",P_DATA_tb,data_valid_tb);
///////////////////////////////////////////////////////////////////////////////////
// parity
        PAR_EN_tb = 1'b1;
        PAR_TYP_tb = 1'b0;
        RX_IN_tb = 1'b0;
        #(clk_period * 8)
        RX_IN_tb = 1'b1;
        #(clk_period * 8)
        RX_IN_tb = 1'b0;
        #(clk_period * 8)
        RX_IN_tb = 1'b1;
        #(clk_period * 8)
        RX_IN_tb = 1'b0;
        #(clk_period * 8)
        RX_IN_tb = 1'b1;
        #(clk_period * 8)
        RX_IN_tb = 1'b0;
        #(clk_period * 8)
        RX_IN_tb = 1'b1;
        #(clk_period * 8)
        RX_IN_tb = 1'b0;
        #(clk_period * 8)
        RX_IN_tb = 1'b0;
        #(clk_period * 8)
        RX_IN_tb = 1'b1;
        #(clk_period * 8)
        $display("...............test case with even parity............");
        $display("p_data = %b,data_valid_tb =%b",P_DATA_tb,data_valid_tb);
///////////////////////////////////////////////////////////////////////////////////
// parity
        PAR_EN_tb = 1'b1;
        PAR_TYP_tb = 1'b1;
        RX_IN_tb = 1'b0;
        #(clk_period * 8)
        RX_IN_tb = 1'b1;
        #(clk_period * 8)
        RX_IN_tb = 1'b0;
        #(clk_period * 8)
        RX_IN_tb = 1'b1;
        #(clk_period * 8)
        RX_IN_tb = 1'b0;
        #(clk_period * 8)
        RX_IN_tb = 1'b1;
        #(clk_period * 8)
        RX_IN_tb = 1'b0;
        #(clk_period * 8)
        RX_IN_tb = 1'b1;
        #(clk_period * 8)
        RX_IN_tb = 1'b0;
        #(clk_period * 8)
        RX_IN_tb = 1'b1;
        #(clk_period * 8)
        RX_IN_tb = 1'b1;
        #(clk_period * 8)
        $display("...............test case with odd parity............");
        $display("p_data = %b,data_valid_tb =%b",P_DATA_tb,data_valid_tb);
end
    
endmodule