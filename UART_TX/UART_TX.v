`include "CONFIG_MACROS_Tx.v"

module UART_TX (input wire Data_Valid,
                input wire CLK,
                input wire parity_enable,
                input wire [`WIDTH-1:0] P_DATA,
                input wire RST,
                input wire parity_type,
                output wire busy,
                output wire TX_OUT);
    
    wire ser_data_int;
    wire ser_en_int;
    wire ser_done_int;
    wire par_bit_int;
    wire [1:0] mux_sel_int;
    
    Tx_FSM FSM_Module (
    
    .Data_Valid(Data_Valid),
    .CLK(CLK),
    .parity_enable(parity_enable),
    .ser_done(ser_done_int),
    .RST(RST),
    
    .ser_en(ser_en_int),
    .busy(busy),
    .mux_sel(mux_sel_int)
    
    );
    
    mux MUX_Module (
    
    .mux_sel(mux_sel_int),
    .ser_data(ser_data_int),
    .par_bit(par_bit_int),
    
    .TX_OUT(TX_OUT)
    
    );
    
    Serializer serializer_Module (
    
    .CLK(CLK),
    .P_DATA(P_DATA),
    .ser_en(ser_en_int),
    .RST(RST),
    .Data_Valid(Data_Valid),
    .busy(busy),
    
    
    .ser_done(ser_done_int),
    .ser_data(ser_data_int)
    
    );
    
    parity_calc Parity_Calc_Module (
    
    .P_DATA(P_DATA),
    .parity_type(parity_type),
    .Data_Valid(Data_Valid),
    .CLK(CLK),
    
    .par_bit(par_bit_int)
    
    );
endmodule
