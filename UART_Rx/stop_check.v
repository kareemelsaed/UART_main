module stop_check (
    input   wire    sampled_bit,
    input   wire    stop_check_en,
    output  reg     stop_err
);
always @(*) begin
    if(stop_check_en)
    if(sampled_bit)
    stop_err = 1'b0;
    else
    stop_err = 1'b1;
    else
    stop_err = 1'b0;
end
    
endmodule