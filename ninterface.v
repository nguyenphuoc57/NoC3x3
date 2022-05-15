module ninterface #(parameter addr = 4'b0000) ( input [31:0] pe2s_flitin, s2pe_flitin,
                    input clk, enable,
                    input s2pe_grant,
                    output pe2s_grant,
                    output [3:0] source,
                    output [2:0] gate,
                    output [1:0] handshake_check,
                    output [31:0] pe2s_flitout, s2pe_flitout,
                    output ready, timeout, accept

    );

wire start, finish,result;
pe2s #(.addr(4'b0000)) pe2s(
            .clk(clk), 
            .enable(enable), 
            .flit_in(pe2s_flitin), 
            .grant(s2pe_grant), 
            .start(start), 
            .flit_out(pe2s_flitout), 
            .source(source), 
            .gate(gate), 
            .handshake_check(handshake_check)
            );
s2pe s2pe( 
            .clk(clk), 
            .enable(enable), 
            .flit_in(s2pe_flitin), 
            .finish(finish), 
            .flit_out(s2pe_flitout), 
            .result(result), 
            .grant(pe2s_grant)

            );
signal signal( 
            .clk(clk), 
            .enable(enable), 
            .start(start), 
            .finish(finish), 
            .ready(ready),
            .result(result),
            .accept(accept)
            );    
counter #( .NUM(10'd50)) counter (
            .clk(clk), 
            .reset(!finish),
            .enable(start), 
            .timeout (timeout)
            );            
endmodule
