/*
 
 The FSM Switches Between the following States:
 
 1- IDLE
 2- START
 3- DATA
 4- PARITY
 5- STOP
 
 */

`include "CONFIG_MACROS_Tx.v"

module Tx_FSM (input wire Data_Valid,
            input wire CLK,
            input wire parity_enable,
            input wire ser_done,
            input wire RST,

            output wire ser_en,
            output reg busy,
            output reg [1:0] mux_sel);
    
    /////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////// State Encoding ////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////
    
    localparam IDLE   = 3'd0;
    localparam START  = 3'd1;
    localparam DATA   = 3'd2;
    localparam PARITY = 3'd3;
    localparam STOP   = 3'd4;
    
    /////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////// States Registers ///////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////
    
    reg [2:0] NS, PS;
    
    always @(posedge CLK or negedge RST) begin
        if (!RST)
            PS <= IDLE;
        else
            PS <= NS;
    end
    
    /////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////// Next State Logic ///////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////
    
    always @(*) begin
        
        case (PS)
            IDLE : begin
                if (Data_Valid) 
                    NS     = START;
                else 
                    NS     = IDLE;
            end
            
            START : begin
                NS     = DATA;
            end
            
            DATA : begin
                if (!ser_done) 
                    NS     = DATA;
                else if (parity_enable) 
                    NS     = PARITY;
                else 
                    NS     = STOP;
            end
            
            PARITY : begin
                NS     = STOP;
            end
            
            STOP : begin
                if (Data_Valid) 
                    NS     = START;
                else 
                    NS     = IDLE;
            end
            
            default : NS = IDLE;
            
        endcase
        
    end
    
    assign ser_en = (PS == DATA);

    /////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////// mux_sel Logic /////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////
    
    always @(*) begin
        
        case (PS)

            IDLE :      mux_sel   = 0;
            START :     mux_sel   = 1;
            DATA :      mux_sel   = 2;
            PARITY :    mux_sel   = 3;

            default:    mux_sel   = 0;
            
        endcase

    end
    
    /////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////// Output Logic /////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////
    
    always @(posedge CLK or negedge RST) begin
        if (!RST)
            busy <= 1'b0;
        else if (PS == IDLE && NS == START)
            busy <= 1'b1;
        else if (PS == STOP && NS == IDLE)
            busy <= 1'b0;
    end
        
endmodule
