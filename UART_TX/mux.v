module mux (input wire [1:0] mux_sel,
            input wire ser_data,
            input wire par_bit,
            output reg TX_OUT);
    
    always @(*) begin
        
        case (mux_sel)
            
            2'd0 : TX_OUT = 1'b1;
            2'd1 : TX_OUT = 1'b0;
            2'd2 : TX_OUT = ser_data;
            2'd3 : TX_OUT = par_bit;
            
        endcase
        
    end
    
endmodule
