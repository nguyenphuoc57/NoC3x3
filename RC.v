module RC #(parameter Addr=4'b0000 ) (
    input clk,
    input enable,
    input [31:0]flit_in,
    output [31:0] flit_out,
    output [2:0] flit_gate,
    output [1:0] flit_type
    );
wire [19:0] mark_trip;
wire [31:0] S2R;
Shifter #(.addr(Addr)) S(
                    .clk(clk),
                    .enable(enable), 
                    .flit_in(flit_in), 
                    .mark_trip(mark_trip), 
                    .flit_out(S2R)
                    );
                    
Route #(.addr(Addr)) R(
                    .clk(clk), 
                    .enable(enable), 
                    .flit_in(S2R), 
                    .mark_trip(mark_trip), 
                    .flit_out(flit_out), 
                    .flit_gate(flit_gate),
                    .flit_type(flit_type)
                    );               
endmodule


//end 
//endmodule
