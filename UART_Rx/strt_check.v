module strt_check (
    input   wire    sampled_bit,
    input   wire    strt_check_en,
    output  reg     strt_err
);
always @(*) begin
    if(strt_check_en )
    if(!sampled_bit)
    strt_err = 1'b0;
    else
    strt_err = 1'b1;
    else
    strt_err = 1'b0;
end
    
endmodule