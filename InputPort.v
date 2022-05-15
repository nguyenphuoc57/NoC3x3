    module InputPort #(parameter address=4'b0000 )(clk, reset, enable, handshake_check, gate_input, source_input,
                                                in_ip_source, in_north_source, in_south_source, in_east_source, in_west_source,
                                                flit_in,flit_out, flit_gate, error, grant
                   );
input [3:0] in_ip_source, in_north_source,  in_south_source,  in_east_source,  in_west_source;                                   
input [1:0] handshake_check;
input [2:0] gate_input;
input [3:0] source_input;
input clk,reset,enable;
input [31:0] flit_in;
output [31:0] flit_out;
output [2:0] flit_gate;
output error;
output grant;


wire VC0_empty, VC1_empty, SA_choose, VC0_stop, VC1_stop;
wire [1:0] RC0_type, RC1_type;
wire [2:0] RC0_gate, RC1_gate;
wire [3:0] VC0_src, VC1_src;
wire [31:0] VC0_flit, VC1_flit, VC0_out, VC1_out, RC0_out, RC1_out;
wire [31:0] VC0_Q1, VC0_Q2, VC0_Q3, VC0_Q4, VC0_Q5,
             VC0_D1, VC0_D2, VC0_D3, VC0_D4, VC0_D5;
wire [31:0] VC1_Q1, VC1_Q2, VC1_Q3, VC1_Q4, VC1_Q5,
             VC1_D1, VC1_D2, VC1_D3, VC1_D4, VC1_D5;
 wire [2:0] VC0_i, VC1_i, VC0_j, VC1_j;
Check check (  .handshake_check(handshake_check), 
               .source(source_input), 
               .gate(gate_input), 
               .grant(grant), 
               .clk(clk), 
               .enable(enable),
               .in_ip_source(in_ip_source),
               .in_south_source(in_south_source),
               .in_north_source(in_north_source),
               .in_east_source(in_east_source),
               .in_west_source(in_west_source)
//               .out_ip_source(out_ip_source),
//               .out_south_source(out_south_source),
//               .out_north_source(out_north_source),
//               .out_east_source(out_east_source),
//               .out_west_source(out_west_source)
               );
VA_DoAn2 VA(.data_flit_in(flit_in),
            .data_source_address_VC0(VC0_src),
            .data_source_address_VC1(VC1_src),
            .data_flit_out_VC0(VC0_flit),
            .data_flit_out_VC1(VC1_flit),
            .empty0(VC0_empty),
            .empty1(VC1_empty),
            .clk(clk),
            .error(error)
             );
 // VC0
 VC VC0(    .clk(clk),
            .reset(reset),
            .enable(enable), 
            .stop(VC0_stop),
            .flit_in(VC0_flit), 
            .VC_src(VC0_src), 
            .empty(VC0_empty), 
            .flit_out(VC0_out)
//            .i(VC0_i),
//            .j(VC0_j), 
//            .Q1(VC0_Q1), 
//            .Q2(VC0_Q2), 
//            .Q3(VC0_Q3), 
//            .Q4(VC0_Q4), 
//            .Q5(VC0_Q5),
//             .D1(VC0_D1), 
//             .D2(VC0_D2), 
//             .D3(VC0_D3), 
//             .D4(VC0_D4), 
//             .D5(VC0_D5)
            );
            
   // VC0
 VC VC1(    .clk(clk),
            .reset(reset),
            .enable(enable), 
            .stop(VC1_stop),
            .flit_in(VC1_flit), 
            .VC_src(VC1_src), 
            .empty(VC1_empty),
            
            .flit_out(VC1_out)
//            .i(VC1_i),
//            .j(VC1_j), 
//            .Q1(VC1_Q1), 
//            .Q2(VC1_Q2), 
//            .Q3(VC1_Q3), 
//            .Q4(VC1_Q4), 
//            .Q5(VC1_Q5),
//             .D1(VC1_D1), 
//             .D2(VC1_D2), 
//             .D3(VC1_D3), 
//             .D4(VC1_D4), 
//             .D5(VC1_D5)
            );
    // RC0
 RC #(.Addr(address)) RC0 (
    .clk(clk),
    .enable(enable),
    .flit_in(VC0_out),
    .flit_out(RC0_out),
    .flit_gate(RC0_gate),
    .flit_type(RC0_type)
     );
 // RC1
RC #(.Addr(address)) RC1 (
    .clk(clk),
    .enable(enable),
    .flit_in(VC1_out),
    .flit_out(RC1_out),
    .flit_gate(RC1_gate),
    .flit_type(RC1_type)
     );  
     
   // SA
 SA_mini SA( .clk(clk), 
             .RC0_flit(RC0_out),
             .RC1_flit(RC1_out),
             .VC0_gate(RC0_gate),
             .VC1_gate(RC1_gate),
             .VC0_type(RC0_type), 
             .VC1_type(RC1_type), 
             .VC0_stop(VC0_stop), 
             .VC1_stop(VC1_stop), 

             .SA_flit(flit_out),
             .SA_gate(flit_gate)
             ); 

endmodule
