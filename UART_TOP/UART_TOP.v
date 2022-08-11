`include "CONFIG_MACROS_TOP.v"
module UART_TOP (
    input   wire   [`WIDTH-1:0]     TX_IN_DATA,
    input   wire                    RX_IN_DATA,
    input   wire                    TX_IN_valid,
    input   wire                    CLK_RX,
    input   wire                    CLK_TX,
    input   wire                    parity_enable,
    input   wire                    RST,
    input   wire                    parity_type,
    input   wire    [4:0]           prescale,
    output   wire                   TX_out_valid,
    output  wire                    RX_out_valid,
    output  wire                    TX_out_DATA,
    output  wire   [`WIDTH-1:0]     RX_out_DATA
);

UART_TX TX_module (
    .Data_Valid(TX_IN_valid),
    .CLK(CLK_TX),
    .parity_enable(parity_enable),
    .P_DATA(TX_IN_DATA),
    .RST(RST),
    .parity_type(parity_type),
    .busy(TX_out_valid),
    .TX_OUT(TX_out_DATA)
);

UART_Rx RX_module (
    .prescale(prescale),
    .RX_IN(RX_IN_DATA),
    .PAR_EN(parity_enable),
    .PAR_TYP(parity_type),
    .CLK(CLK_RX),
    .RST(RST),
    .P_DATA(RX_out_DATA),
    .data_valid(RX_out_valid)

);

endmodule
