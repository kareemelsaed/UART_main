module data_sampling (
    input   wire                data_in,
    input   wire    [4:0]       prescale,
    input   wire    [4:0]       edge_cnt,
    input   wire                en_sampler,
    input   wire                clk,
    input   wire                rst,
    output  wire                sampled_bit
);
reg     [2:0]     register;
always @(posedge clk or negedge rst) begin
    if (!rst)
    begin
        register <= 'b0;
    end
    else if (en_sampler)
    begin
        if (edge_cnt==((prescale/2)-1))
        register[0] <= data_in;
        else if (edge_cnt==(prescale/2))
        register[1] <= data_in;
        else if (edge_cnt==((prescale/2)+1))
        register[2] <= data_in;
    end
end
assign sampled_bit = ((register[2] & (register[1] | register [0])) | (register[0] & register[1]));
    
endmodule