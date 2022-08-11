`include "CONFIG_MACROS_Tx.v"

module Serializer (input wire CLK,
                   input wire [7:0] P_DATA,
                   input wire ser_en,
                   input wire Data_Valid,
                   input wire busy,
                   input wire RST,

                   output wire ser_done,
                   output wire ser_data);
    
    reg [2:0] Counter;
    reg [7:0] INT_REG;

    always @(posedge CLK or negedge RST ) begin
        if (!RST)
            INT_REG <= 0;
        else if (Data_Valid && !busy)
            INT_REG <= P_DATA;
        else if (ser_en)
            INT_REG <= INT_REG >> 1;
    end    
    
    always @(posedge CLK or negedge RST ) begin
        if (!RST)
            Counter <= 0;
        else if (ser_done)
            Counter <= 0;
        else if (ser_en)
            Counter <= Counter + 1;
    end
                
    assign ser_done = Counter == 3'd7;
    assign ser_data = INT_REG [0];
        
        
endmodule
