/*

Functionality:
    The FSM Switches Between:
    1- IDLE
    2- START
    3- PARITY
    4- DATA
    5- STOP

    and it controls other signals related to the other modules

 */
module FSM (
    input   wire    [4:0]   edge_cnt,
    input   wire    [3:0]   bit_cnt,
    input   wire            RX_in,
    input   wire            par_en,
    input   wire            par_err,
    input   wire            strt_err,
    input   wire            stp_err,
    input   wire    [4:0]   prescale,
    input   wire            clk,
    input   wire            rst,
    output  reg             data_samp_en,
    output  reg             deser_en,
    output  reg             data_valid,
    output  reg             stp_chk_en,
    output  reg             strt_chk_en,
    output  reg             par_chk_en,
    output  reg             counter_en
);
    /////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////// State Encoding ////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////
	
reg [2:0]   current_state,next_state ;

localparam [2:0]    idle  = 3'b000 ,
                    start  = 3'b001 ,
                    parity = 3'b011 ,
                    data   = 3'b010 ,
                    stop   = 3'b110 ;

always @(posedge clk or negedge rst) begin
    if(!rst)
    current_state <= idle;
    else
    current_state <= next_state;
end

    /////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////// Next State Logic ///////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////
	
always @(*) begin
    case(current_state)
    idle   : begin
                if(RX_in==1'b0)
                next_state = start;
                else
                next_state = idle;        
              end
    start   : begin
                if(bit_cnt== 'b1 && !strt_err && par_en )
                next_state = parity;
                else if (bit_cnt== 'b1 && !strt_err && !par_en)
                next_state = data;
                else
                next_state = start;
              end
    parity  : begin
                if(bit_cnt == 4'd10)
                next_state = stop;
                else
                next_state = parity;
              end
    data    : begin
                if(bit_cnt == 4'd9)
                next_state = stop;
                else
                next_state = data;
              end
    stop    : begin
                if(par_en && edge_cnt == (prescale-1) && RX_in==1'b0)
                next_state = start;
                else if (!par_en && edge_cnt == (prescale-1) && RX_in==1'b0)
                next_state = start;
                else if (par_en && edge_cnt == (prescale-1) && RX_in==1'b1)
                next_state = idle;
                else if (!par_en && edge_cnt == (prescale-1) && RX_in==1'b1)
                next_state = idle;
                else
                next_state = stop; 
              end
    default  : next_state = idle;
    endcase
end

    /////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////// Next State Logic ///////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////
	
always @(*) begin
    /////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////// initialize all output	/////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////
    data_samp_en = 1'b0;
    deser_en     = 1'b0;
    data_valid   = 1'b0;
    stp_chk_en   = 1'b0;
    strt_chk_en  = 1'b0;
    par_chk_en   = 1'b0;
    counter_en   = 1'b0;

    case(current_state)
    start   : begin
                data_samp_en = 1'b1;
                counter_en   = 1'b1;
                if(edge_cnt>((prescale/2)+2))
                begin
                    strt_chk_en =1'b1;
                end
              end
    parity    : begin
                data_samp_en = 1'b1;
                counter_en   = 1'b1;
                if(edge_cnt>((prescale/2)+2))
                    par_chk_en = 1'b1;
                if(edge_cnt == (prescale-1) && bit_cnt < 4'd9)
                    deser_en   = 1'b1;
              end
    data    : begin
                data_samp_en = 1'b1;
                counter_en = 1'b1;
                if(edge_cnt == (prescale-1))
                begin
                    deser_en = 1'b1;
                end
              end
    stop    : begin
                data_samp_en = 1'b1;
                counter_en = 1'b1;
                if(edge_cnt>((prescale/2)+2))
                begin
                    stp_chk_en = 1'b1;
                    if(!par_err && !stp_err)
                    data_valid = 1'b1;
                end
              end
endcase
end
    
endmodule
