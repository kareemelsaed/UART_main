module parity_check #(
    parameter width=9
) (
    input   wire     sampled_bit,
    input   wire     par_typ,
    input   wire     clk,
    input   wire     rst,
    input   wire     par_check_en,
    output  reg      par_err
);
reg [width-1:0]     register;

    always @(posedge clk or negedge rst) begin
        if(!rst)
        begin
            register <= 'b0;
        end
        else
        register <= {register,sampled_bit};
        
    end
    always @(*) begin
	par_err = 1'b0;
        if(par_check_en)
        if(!par_typ) //even parity
        if(^register[width-1:1]==register[0])
        par_err=1'b0;
        else 
        par_err=1'b1;
        else if(par_typ)    //odd parity
        if(~^register[width-1:1]==register[0])
        par_err=1'b0;
        else 
        par_err=1'b1;
        else 
        par_err=1'b0;
    end 
endmodule
