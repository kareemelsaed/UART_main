`include "CONFIG_MACROS_Rx.v"
module deserializer 
(
    input   wire                    sampled_bit,
    input   wire                    data_valid,
    input   wire                    deser_en,
    input   wire                    clk,
    input   wire                    rst,
    output  wire     [`WIDTH-1:0]     p_data
);
reg     [`WIDTH-1:0]     register;

always @(posedge clk or negedge rst) begin
    if(!rst)
    begin
            register <= 'b0;
    end
    else if(deser_en)
    register <= {sampled_bit,register[`WIDTH-1:1]};
end
assign p_data = (data_valid) ? register : 'b0 ;
    
endmodule
