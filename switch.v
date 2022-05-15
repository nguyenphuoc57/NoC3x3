
module switch #(parameter address=4'b1111)(
               
input clk, reset, enable,
input [31:0]  p_PE_in,
              p_north_in,
              p_east_in,
              p_south_in,
              p_west_in,
input [2:0] south_gatein, north_gatein, west_gatein, east_gatein, PE_gatein,
input [3:0] south_sourcein, north_sourcein, west_sourcein, east_sourcein, PE_sourcein,
input [1:0] in_PE_handshake_check,
      in_SOUTH_handshake_check,
      in_EAST_handshake_check,
      in_NORTH_handshake_check,
      in_WEST_handshake_check,
input grant_PE_in,
      grant_NORTH_in,
      grant_SOUTH_in,
      grant_EAST_in,
      grant_WEST_in,
output grant_PE_out,
      grant_NORTH_out,
      grant_SOUTH_out,
      grant_EAST_out,
      grant_WEST_out,
output [2:0] south_gateout, north_gateout, west_gateout, east_gateout, PE_gateout,
output [3:0] south_sourceout, north_sourceout, west_sourceout, east_sourceout, PE_sourceout,    
//output grant_PE_out,
//      grant_NORTH_out,
//      grant_SOUTH_out,
//      grant_EAST_out,
//      grant_WEST_out,    
output [1:0] out_PE_handshake_check,
      out_SOUTH_handshake_check,
      out_EAST_handshake_check,
      out_NORTH_handshake_check,
      out_WEST_handshake_check,    
output [31:0] p_PE_out,
              p_north_out,
              p_east_out,
              p_south_out,
              p_west_out,

output north_error, south_error, PE_error, west_error, east_error
);
//ila_0 ila_NODE(.clk(clk),


//.probe0(p_PE_in),
//.probe1(p_north_in),
//.probe2(p_south_in),
//.probe3(p_west_in),
//.probe4(p_east_in),
//.probe5(p_PE_out),
//.probe6(p_north_out),
//.probe7(p_south_out),
//.probe8(p_east_out),
//.probe9(p_west_out)
//);     
wire [3:0] PE_src2in, north_src2in, south_src2in, east_src2in, west_src2in;
wire [31:0] cb_north_out, cb_south_out, cb_west_out, cb_east_out, cb_PE_out;
wire [2:0] PE_gate,north_gate, east_gate, south_gate, west_gate;   
wire [31:0] north_out, south_out,west_out, east_out, PE_out;
InputPort #(.address(address) ) Input_NORTH (  .clk(clk), 
                                    .reset(reset), 
                                    .enable(enable), 
                                    .handshake_check(in_NORTH_handshake_check),                               
                                    .gate_input(north_gatein),
                                    .source_input(north_sourcein),
                                    .in_ip_source(PE_src2in), 
                                    .in_north_source(north_src2in), 
                                    .in_south_source(south_src2in),
                                    .in_east_source(east_src2in),
                                    .in_west_source(west_src2in),
                                    .flit_in(p_north_in),
                                    .flit_out(north_out), 
                                    .flit_gate(north_gate),
                                    .error(north_error),
                                    .grant(grant_NORTH_out)
                                  );
OutputPort #(.addr_sw(address), .stt(3'd0)) Output_NORTH(   
    .clk(clk),
    .enable(enable),
    .flit_in(cb_north_out),
    .grant(grant_NORTH_in),
    .out(p_north_out),
    .flit_gate(north_gateout),
    .source(north_sourceout),
    .src2in(north_src2in),
    .handshake_check(out_NORTH_handshake_check)
    );

InputPort #(.address(address) ) Input_SOUTH (  .clk(clk), 
                                    .reset(reset), 
                                    .enable(enable),
                                    .handshake_check(in_SOUTH_handshake_check),
                                    .gate_input(south_gatein),
                                    .source_input(south_sourcein),
                                    .in_ip_source(PE_src2in), 
                                    .in_north_source(north_src2in), 
                                    .in_south_source(south_src2in),
                                    .in_east_source(east_src2in),
                                    .in_west_source(west_src2in),
                                    .flit_in(p_south_in),
                                    .flit_out(south_out), 
                                    .flit_gate(south_gate), 
                                    .error(south_error),
                                    .grant (grant_SOUTH_out)
                                  );
OutputPort #(.addr_sw(address), .stt(3'd2)) Output_SOUTH(   
    .clk(clk),
    .enable(enable),
    .flit_in(cb_south_out),
    .grant(grant_SOUTH_in),
    .out(p_south_out),
    .flit_gate(south_gateout),
    .source(south_sourceout),
    .src2in(south_src2in),
    .handshake_check(out_SOUTH_handshake_check)
    );
InputPort #(.address(address) ) Input_WEST (   .clk(clk), 
                                    .reset(reset), 
                                    .enable(enable), 
                                    .handshake_check(in_WEST_handshake_check),
                                    .gate_input(west_gatein),
                                    .source_input(west_sourcein),
                                    .in_ip_source(PE_src2in), 
                                    .in_north_source(north_src2in), 
                                    .in_south_source(south_src2in),
                                    .in_east_source(east_src2in),
                                    .in_west_source(west_src2in),
                                    .flit_in(p_west_in),
                                    .flit_out(west_out), 
                                    .flit_gate(west_gate), 
                                    .error(west_error),
                                    .grant (grant_WEST_out)
                                  );
OutputPort #(.addr_sw(address), .stt(3'd3)) Output_WEST(   
    .clk(clk),
    .enable(enable),
    .flit_in(cb_west_out),
    .grant(grant_WEST_in),
    .out(p_west_out),
    .flit_gate(west_gateout),
    .source(west_sourceout),
    .src2in(west_src2in),
    .handshake_check(out_WEST_handshake_check)
    );
InputPort #(.address(address) ) Input_EAST (   .clk(clk), 
                                    .reset(reset), 
                                    .enable(enable), 
                                    .handshake_check(in_EAST_handshake_check),
                                    .gate_input(east_gatein),
                                    .source_input(east_sourcein),
                                    .in_ip_source(PE_src2in), 
                                    .in_north_source(north_src2in), 
                                    .in_south_source(south_src2in),
                                    .in_east_source(east_src2in),
                                    .in_west_source(west_src2in),
                                    .flit_in(p_east_in),
                                    .flit_out(east_out), 
                                    .flit_gate(east_gate), 
                                    .error(east_error),
                                    .grant (grant_EAST_out)
                                  );
OutputPort #(.addr_sw(address), .stt(3'd1)) Output_EAST(   
    .clk(clk),
    .enable(enable),
    .flit_in(cb_east_out),
    .grant(grant_EAST_in),
    .out(p_east_out),
    .flit_gate(east_gateout),
    .source(east_sourceout),
    .src2in(east_src2in),
    .handshake_check(out_EAST_handshake_check)
    );
InputPort #(.address(address) ) Input_PE (  .clk(clk), 
                                    .reset(reset), 
                                    .enable(enable), 
                                    .handshake_check(in_PE_handshake_check),
                                    .gate_input(PE_gatein),
                                    .source_input(PE_sourcein),
                                    .in_ip_source(PE_src2in), 
                                    .in_north_source(north_src2in), 
                                    .in_south_source(south_src2in),
                                    .in_east_source(east_src2in),
                                    .in_west_source(west_src2in),
                                    .flit_in(p_PE_in),
                                    .flit_out(PE_out), 
                                    .flit_gate(PE_gate), 
                                    .error(PE_error),
                                    .grant (grant_PE_out)
                                    );
 OutputPort #(.addr_sw(address), .stt(3'd4)) Output_PE(   
    .clk(clk),
    .enable(enable),
    .flit_in(cb_PE_out),
    .grant(grant_PE_in),
    .out(p_PE_out),
    .flit_gate(PE_gateout),
    .source(PE_sourceout),
    .src2in(PE_src2in),
    .handshake_check(out_PE_handshake_check)
    );                                
 Crossbar crossbar(   
                        .clk(clk), 
                       .enable(enable),
						.PE_out(cb_PE_out), 		.PE_gate(PE_gate), 	.PE_data(PE_out), 
						.west_out(cb_west_out),	.west_gate(west_gate),	.west_data(west_out), 
						.north_out(cb_north_out),	.north_gate(north_gate), .north_data(north_out), 
						.east_out(cb_east_out), 	.east_gate(east_gate), 	.east_data(east_out), 
						.south_out(cb_south_out), 	.south_gate(south_gate), 	.south_data(south_out)
						);
                               
endmodule
