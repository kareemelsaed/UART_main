`include "CONFIG_MACROS_Tx.v"

module parity_calc (input wire [`WIDTH-1:0] P_DATA,
                    input wire parity_type,
                    input wire Data_Valid,
                    input wire CLK,

                    output reg par_bit);

    
    always @(posedge CLK) begin
        if ( (parity_type == `EVEN_PARITY_CONFIG) && Data_Valid) // Even Parity
            par_bit <= ^P_DATA;
        else if ((parity_type == `ODD_PARITY_CONFIG) && Data_Valid) // Odd Parity
            par_bit <= ~(^P_DATA);
    end
        
endmodule
