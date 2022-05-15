module Check(  handshake_check, source, gate, grant, 
               clk, enable,
               in_ip_source,
               in_south_source,
               in_north_source,
               in_east_source,
               in_west_source
//               out_ip_source,
//               out_south_source,
//               out_north_source,
//               out_east_source,
//               out_west_source
               );
input clk,enable;
input [1:0] handshake_check;
input [3:0] source;
input [2:0] gate;
input [3:0]    in_ip_source,
               in_south_source,
               in_north_source,
               in_east_source,
               in_west_source;
output grant;
wire [3:0]   out_ip_source,
               out_south_source,
               out_north_source,
               out_east_source,
               out_west_source;
 Compare compare (
        .clk(clk),
        .enable(enable),
        .handshake_check(handshake_check),
        .source(source),
        .gate(gate),
        .grant(grant),
        .ip_source(out_ip_source),
        .north_source(out_north_source),
        .south_source(out_south_source),
        .west_source(out_west_source),
        .east_source (out_east_source)
        ); 
 dff_define #(.WIDTH(4'd4), .val_def(4'hf)) ip_src(
        .Q(out_ip_source), 
        .clk(clk), 
        .D(in_ip_source),
        .enable(enable)
        );
 dff_define #(.WIDTH(4'd4), .val_def(4'hf))south_src(
        .Q(out_south_source), 
        .clk(clk), 
        .D(in_south_source),
        .enable(enable)
        );
  dff_define #(.WIDTH(4'd4), .val_def(4'hf))north_src(
        .Q(out_north_source), 
        .clk(clk), 
        .D(in_north_source),
        .enable(enable)
        );
  dff_define #(.WIDTH(4'd4), .val_def(4'hf)) east_src(
        .Q(out_east_source), 
        .clk(clk), 
        .D(in_east_source),
        .enable(enable)
        ); 
  dff_define #(.WIDTH(4'd4), .val_def(4'hf)) west_src(
        .Q(out_west_source), 
        .clk(clk), 
        .D(in_west_source),
        .enable(enable)
        );                  
endmodule
