module edge_bit_counter (
    input   wire    [4:0]   prescale,
    input   wire            en_counter,
    input   wire            data_valid,
    input   wire            clk,
    input   wire            rst,
    output  reg     [3:0]   bit_cnt,
    output  reg     [4:0]   edge_cnt
);

always @(posedge clk or negedge rst) begin
    if(!rst)
    begin
        bit_cnt <= 'b0;
        edge_cnt <= 'b0;
    end
    else if(data_valid)
    begin
        bit_cnt <= 'b0;
        edge_cnt <= 'b0;
    end
    else if(en_counter)
    begin
        edge_cnt <= edge_cnt+ 1'b1;
        if(edge_cnt==prescale-1)
        begin
           edge_cnt <= 'b0;
           bit_cnt  <= bit_cnt + 1'b1;
        end
    end

end

endmodule
