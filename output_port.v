
module OutputPort#(parameter addr_sw=4'b0000, parameter stt = 3'd5 )(   
    input clk,
    input enable,
    input [31:0]flit_in,
    input grant,

    output  [2:0] flit_gate,
    output [3:0] source,
    output [3:0] src2in,
    output [1:0] handshake_check,
    output [31:0]out
    );

wire [31:0] dff1;
reg [31:0] out_temp;
Gate_point #(.addr_sw(addr_sw),.stt(stt)) GatePoint(
             .clk(clk),
             .enable(enable), 
             .grant(grant),
             .flit_in(flit_in),
             .flit_out(dff1),
             .flit_gate(flit_gate),
             .source(source),
             .src2in(src2in),
             .handshake_check(handshake_check)
);

dff_enable DFF1(
             .clk(clk),
             .in_data(dff1),
            .out_data(out),
             .enable(grant)
             );
endmodule
