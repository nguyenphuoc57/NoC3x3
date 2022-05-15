module Noc3x3( input           clk, reset, enable, 
input [31:0]    PE_00_in, 
                PE_01_in, 
               PE_02_in, 
               PE_10_in, 
               PE_11_in, 
               PE_12_in, 
               PE_20_in, 
               PE_21_in, 
               PE_22_in,
output [31:0]   PE_00_out, 
                PE_01_out,
                PE_02_out,
                PE_10_out,
                PE_11_out,
                PE_12_out,
                PE_20_out,
                PE_21_out,
                PE_22_out ,
output   NI00_ready,NI00_timeout,NI00_accept,
        NI01_ready,NI01_timeout,NI01_accept,
        NI02_ready,NI02_timeout,NI02_accept,
        NI10_ready,NI10_timeout,NI10_accept,
        NI11_ready,NI11_timeout,NI11_accept,
        NI12_ready,NI12_timeout,NI12_accept,
        NI20_ready,NI20_timeout,NI20_accept,
        NI21_ready,NI21_timeout,NI21_accept,
        NI22_ready,NI22_timeout,NI22_accept
        );
//ila_0 ILA_NoC3x3(
//.clk(clk), 
//        .probe0(PE_00_in), 
//                .probe1(PE_10_in), 
//               .probe2(PE_20_in), 
//               .probe3(PE_01_in), 
//               .probe4(PE_11_in), 
//               .probe5(PE_21_in), 
//               .probe6(PE_02_in), 
//               .probe7(PE_12_in), 
//               .probe8(PE_22_in),
//               .probe9(PE_00_out), 
//                .probe10(PE_10_out),
//                .probe11(PE_20_out),
//                .probe12(PE_01_out),
//                .probe13(PE_11_out),
//                .probe14(PE_21_out),
//                .probe15(PE_02_out),
//                .probe16(PE_12_out),
//                .probe17(PE_22_out)
//);
wire [31:0] flit_00_01, 
            flit_00_10,
            flit_00_so,
            flit_so_00,
            
            flit_01_00,
            flit_01_11,
            flit_01_02,
            
            flit_02_12,
            flit_02_01,
            flit_02_no,
            flit_no_02,
            
            flit_10_00,
            flit_10_11,
            flit_10_20,
            flit_so_10,
            flit_10_so,
            
            flit_11_10,
            flit_11_01,
            flit_11_12,
            flit_11_21,
            
            flit_12_02,
            flit_12_22,
            flit_12_11,
            flit_no_12,
            flit_12_no,
            
            flit_20_10,
            flit_20_21,
            
            flit_21_20,
            flit_21_11,
            flit_21_22,
            
            flit_22_no,
            flit_no_22,
            flit_22_21,
            flit_22_12;
wire [1:0] handshake_00_01, 
            handshake_00_10,
            handshake_00_so,
            handshake_so_00,
            
            handshake_01_00,
            handshake_01_11,
            handshake_01_02,
            
            handshake_02_12,
            handshake_02_01,
            handshake_02_no,
            handshake_no_02,
            
            handshake_10_00,
            handshake_10_11,
            handshake_10_20,
            handshake_10_so,
            handshake_so_10,
            
            handshake_11_10,
            handshake_11_01,
            handshake_11_12,
            handshake_11_21,
            
            handshake_12_02,
            handshake_12_22,
            handshake_12_11,
             handshake_12_no,
              handshake_no_12,
            
            handshake_20_10,
            handshake_20_21,
            
            handshake_21_20,
            handshake_21_11,
            handshake_21_22,
            
             handshake_22_no,
             handshake_no_22,
            handshake_22_21,
            handshake_22_12;
wire grant_00_01, 
            grant_00_10,
            grant_00_so,
            grant_so_00,
            
            grant_01_00,
            grant_01_11,
            grant_01_02,
            
            grant_02_12,
            grant_02_01,
            grant_02_no,
            grant_no_02,
            
            grant_10_00,
            grant_10_11,
            grant_10_20,
            grant_10_so,
            grant_so_10,
            
            grant_11_10,
            grant_11_01,
            grant_11_12,
            grant_11_21,
            
            grant_12_02,
            grant_12_22,
            grant_12_11,
            grant_12_no,
            grant_no_12,
            
            grant_20_10,
            grant_20_21,
            
            grant_21_20,
            grant_21_11,
            grant_21_22,
            
            grant_so_22,
            grant_22_no,
            grant_22_21,
            grant_22_12;    
wire [3:0] source_00_01, 
            source_00_10,
            source_so_00,
            source_00_so,
            
            source_01_00,
            source_01_11,
            source_01_02,
            
            source_02_12,
            source_02_01,
            source_02_no,
            source_no_02,
            
            source_10_00,
            source_10_11,
            source_10_20,
            source_10_so,
            source_so_10,
            
            source_11_10,
            source_11_01,
            source_11_12,
            source_11_21,
            
            source_12_02,
            source_12_22,
            source_12_11,
            source_12_no,
            source_no_12,
            
            source_20_10,
            source_20_21,
            
            source_21_20,
            source_21_11,
            source_21_22,
            
            source_22_no,
            source_no_22,
            source_22_21,
            source_22_12; 
            
wire [2:0]  gate_00_01, 
            gate_00_10,
            gate_00_so,
            gate_so_00,    
                
            gate_01_00,
            gate_01_11,
            gate_01_02,
            
            gate_02_12,
            gate_02_01,
            gate_02_no,
            gate_no_02,
            
            gate_10_00,
            gate_10_11,
            gate_10_20,
            gate_10_so,
            gate_so_10,
            
            gate_11_10,
            gate_11_01,
            gate_11_12,
            gate_11_21,
            
            gate_12_02,
            gate_12_22,
            gate_12_11,
            gate_12_no,
            gate_no_12,
            
            gate_20_10,
            gate_20_21,
            
            gate_21_20,
            gate_21_11,
            gate_21_22,
            
            gate_22_no,
            gate_no_22,
            gate_22_21,
            gate_22_12;  
            
wire [31:0] NI00_s2pe_flitin,
            NI00_pe2s_flitout,
            NI01_s2pe_flitin,
            NI01_pe2s_flitout,
            NI02_s2pe_flitin,
            NI02_pe2s_flitout,
            NI10_s2pe_flitin,
            NI10_pe2s_flitout,
            NI11_s2pe_flitin,
            NI11_pe2s_flitout,
            NI12_s2pe_flitin,
            NI12_pe2s_flitout,
            NI20_s2pe_flitin,
            NI20_pe2s_flitout,
            NI21_s2pe_flitin,
            NI21_pe2s_flitout,
            NI22_s2pe_flitin,
            NI22_pe2s_flitout
            ;
 wire   NI00_s2pe_grant,
        NI00_pe2s_grant, 
        NI01_s2pe_grant,
        NI01_pe2s_grant, 
        NI02_s2pe_grant,
        NI02_pe2s_grant, 
        NI10_s2pe_grant,
        NI10_pe2s_grant, 
        NI11_s2pe_grant,
        NI11_pe2s_grant, 
        NI12_s2pe_grant,
        NI12_pe2s_grant, 
        NI20_s2pe_grant,
        NI20_pe2s_grant, 
        NI21_s2pe_grant,
        NI21_pe2s_grant, 
        NI22_s2pe_grant,
        NI22_pe2s_grant;
 wire [3:0] NI00_sourcein, 
            NI01_sourcein, 
            NI02_sourcein, 
            NI10_sourcein, 
            NI11_sourcein, 
            NI12_sourcein, 
            NI20_sourcein, 
            NI21_sourcein, 
            NI22_sourcein;
  wire [2:0] NI00_gatein, 
             NI01_gatein, 
             NI02_gatein, 
             NI10_gatein, 
             NI11_gatein, 
             NI12_gatein, 
             NI20_gatein, 
             NI21_gatein, 
             NI22_gatein;
  wire [1:0] NI00_handshake_check, 
        NI01_handshake_check, 
        NI02_handshake_check, 
        NI10_handshake_check, 
        NI11_handshake_check, 
        NI12_handshake_check, 
        NI20_handshake_check, 
        NI21_handshake_check, 
        NI22_handshake_check;     
                   
//ila_0 ila(.clk(clk),


//.probe0(PE_00_out),
//.probe1(PE_01_out),
//.probe2(PE_02_out),
//.probe3(PE_10_out),
//.probe4(PE_11_out),
//.probe5(PE_12_out),
//.probe6(PE_20_out),
//.probe7(PE_21_out),
//.probe8(PE_22_out)
//);        
                  
wire a;            
                                                  
//////////////////////////////////// 
ninterface #(.addr(4'b0000)) NI_00 ( 
                    .pe2s_flitin(PE_00_in), 
                    .s2pe_flitin(NI00_s2pe_flitin),
                    .clk(clk), 
                    .enable(enable),
                    .s2pe_grant(NI00_s2pe_grant),
                    .pe2s_grant(NI00_pe2s_grant),
                    .source(NI00_sourcein),
                    .gate(NI00_gatein),
                    .handshake_check(NI00_handshake_check),
                    .pe2s_flitout(NI00_pe2s_flitout), 
                    .s2pe_flitout(  PE_00_out),
                    .ready(  NI00_ready), 
                    .timeout(  NI00_timeout), 
                    .accept(  NI00_accept)

    );  
switch #(.address(4'b0000)) NODE_00(
                .clk(  clk), .reset(  reset), .enable(  enable), 
                
                .p_PE_in(NI00_pe2s_flitout), .p_PE_out(NI00_s2pe_flitin), 
                .grant_PE_in(NI00_pe2s_grant), .grant_PE_out(NI00_s2pe_grant),
                .in_PE_handshake_check(NI00_handshake_check), //.out_PE_handshake_check(out_PE_hs_00),
                .PE_gatein(NI00_gatein), .PE_sourcein(NI00_sourcein),// .PE_gateout(NI00_gateout), .PE_sourceout(NI00_sourceout),
                
                .p_north_in(flit_01_00), .p_north_out(flit_00_01), 
                .grant_NORTH_in(grant_01_00), .grant_NORTH_out(grant_00_01), 
                .in_NORTH_handshake_check(handshake_01_00), .out_NORTH_handshake_check(handshake_00_01),
                .north_gatein(gate_01_00), .north_sourcein(source_01_00), .north_gateout(gate_00_01), .north_sourceout(source_00_01),
                
                .p_east_in(flit_10_00), .p_east_out(flit_00_10), 
                .grant_EAST_in(grant_10_00), .grant_EAST_out(grant_00_10),
                .in_EAST_handshake_check(handshake_10_00), .out_EAST_handshake_check(handshake_00_10),
                .east_gatein(gate_10_00), .east_sourcein(source_10_00), .east_gateout(gate_00_10), .east_sourceout(source_00_10),
            
                .p_south_in(flit_so_00), .p_south_out(flit_00_so), 
                .grant_SOUTH_in(grant_so_00), .grant_SOUTH_out(grant_00_so),
                .in_SOUTH_handshake_check(handshake_so_00), .out_SOUTH_handshake_check(handshake_00_so),
                .south_gatein(gate_so_00), .south_sourcein(source_so_00), .south_gateout(gate_00_so), .south_sourceout(source_00_so)

    );  
//  NI NI_01 (.clk(clk),
//           .ready(ready_01), 
//           .enable(enable),
//           .flit_in_IP(PE_01_in), 
//           .flit_out_IP(PE_01_out), 
//           .flit_out_sw(sw_01_out), 
//           .flit_in_sw(sw_01_in), 
//           .timeout(timeout_01),
//           .accept(accept_01)
//           );  
ninterface #(.addr(4'b0001)) NI_01 ( 
                    .pe2s_flitin(  PE_01_in), 
                    .s2pe_flitin(NI01_s2pe_flitin),
                    .clk(  clk), 
                    .enable(  enable),
                    .s2pe_grant(NI01_s2pe_grant),
                    .pe2s_grant(NI01_pe2s_grant),
                    .source(NI01_sourcein),
                    .gate(NI01_gatein),
                    .handshake_check(NI01_handshake_check),
                    .pe2s_flitout(NI01_pe2s_flitout), 
                    .s2pe_flitout(  PE_01_out),
                    .ready(  NI01_ready), 
                    .timeout(  NI01_timeout), 
                    .accept(  NI01_accept)

    ); 
switch #(.address(4'b0001)) NODE_01(
                .clk(  clk), .reset(  reset), .enable(  enable), 
                
                .p_PE_in(NI01_pe2s_flitout), .p_PE_out(NI01_s2pe_flitin), 
                .grant_PE_in(NI01_pe2s_grant), .grant_PE_out(NI01_s2pe_grant),
                .in_PE_handshake_check(NI01_handshake_check), //.out_PE_handshake_check(out_PE_hs_00),
                .PE_gatein(NI01_gatein), .PE_sourcein(NI01_sourcein), //.PE_gateout(NI01_gateout), .PE_sourceout(NI01_sourceout),
                
                .p_north_in(flit_02_01), .p_north_out(flit_01_02), 
                .grant_NORTH_in(grant_02_01), .grant_NORTH_out(grant_01_02), 
                .in_NORTH_handshake_check(handshake_02_01), .out_NORTH_handshake_check(handshake_01_02),
                .north_gatein(gate_02_01), .north_sourcein(source_02_01), .north_gateout(gate_01_02), .north_sourceout(source_01_02),
                
                .p_east_in(flit_11_01), .p_east_out(flit_01_11), 
                .grant_EAST_in(grant_11_01), .grant_EAST_out(grant_01_11),
                .in_EAST_handshake_check(handshake_11_01), .out_EAST_handshake_check(handshake_01_11),
                .east_gatein(gate_11_01), .east_sourcein(source_11_01), .east_gateout(gate_01_11), .east_sourceout(source_01_11),
                
                .p_south_in(flit_00_01), .p_south_out(flit_01_00), 
                .grant_SOUTH_in(grant_00_01), .grant_SOUTH_out(grant_01_00),
                .in_SOUTH_handshake_check(handshake_00_01), .out_SOUTH_handshake_check(handshake_01_00),
                .south_gatein(gate_00_01), .south_sourcein(source_00_01), .south_gateout(gate_01_00), .south_sourceout(source_01_00)
                
//                .p_west_in(we_00_in), .p_west_out(we_00_out), .grant_WEST(grant_WEST_00),
//                .in_WEST_handshake_check(in_WEST_hs_00), .out_WEST_handshake_check(out_WEST_hs_00),
                //.north_error, south_error, PE_error, west_error, east_error
    );  
//   NI NI_02 (.clk(clk),
//           .ready(ready_02), 
//           .enable(enable),
//           .flit_in_IP(PE_02_in), 
//           .flit_out_IP(PE_02_out), 
//           .flit_out_sw(sw_02_out), 
//           .flit_in_sw(sw_02_in), 
//           .timeout(timeout_02),
//           .accept(accept_02)
//           ); 
ninterface #(.addr(4'b0010)) NI_02 ( 
                    .pe2s_flitin(  PE_02_in), 
                    .s2pe_flitin(NI02_s2pe_flitin),
                    .clk(  clk), 
                    .enable(  enable),
                    .s2pe_grant(NI02_s2pe_grant),
                    .pe2s_grant(NI02_pe2s_grant),
                    .source(NI02_sourcein),
                    .gate(NI02_gatein),
                    .handshake_check(NI02_handshake_check),
                    .pe2s_flitout(NI02_pe2s_flitout), 
                    .s2pe_flitout(  PE_02_out),
                    .ready(  NI02_ready), 
                    .timeout(  NI02_timeout), 
                    .accept(  NI02_accept)

    );      
switch #(.address(4'b0010)) NODE_02(
                .clk(  clk), .reset(  reset), .enable(  enable), 
                
                .p_PE_in(NI02_pe2s_flitout), .p_PE_out(NI02_s2pe_flitin), 
                .grant_PE_in(NI02_pe2s_grant), .grant_PE_out(NI02_s2pe_grant),
                .in_PE_handshake_check(NI02_handshake_check), //.out_PE_handshake_check(out_PE_hs_00),
                .PE_gatein(NI02_gatein), .PE_sourcein(NI02_sourcein),// .PE_gateout(NI02_gateout), .PE_sourceout(NI01_sourceout),
                
                .p_north_in(flit_no_02), .p_north_out(flit_02_no), 
                .grant_NORTH_in(grant_no_02), .grant_NORTH_out(grant_02_no), 
                .in_NORTH_handshake_check(handshake_no_02), .out_NORTH_handshake_check(handshake_02_no),
               .north_gatein(gate_no_02), .north_sourcein(source_no_02), .north_gateout(gate_02_no), .north_sourceout(source_02_no),
                            
                .p_east_in(flit_12_02), .p_east_out(flit_02_12), 
                .grant_EAST_in(grant_12_02), .grant_EAST_out(grant_02_12),
                .in_EAST_handshake_check(handshake_12_02), .out_EAST_handshake_check(handshake_02_12),
                .east_gatein(gate_12_02), .east_sourcein(source_12_02), .east_gateout(gate_02_12), .east_sourceout(source_02_12),
                
                .p_south_in(flit_01_02), .p_south_out(flit_02_01), 
                .grant_SOUTH_in(grant_01_02), .grant_SOUTH_out(grant_02_01),
                .in_SOUTH_handshake_check(handshake_01_02), .out_SOUTH_handshake_check(handshake_02_01),
                .south_gatein(gate_01_02), .south_sourcein(source_01_02), .south_gateout(gate_02_01), .south_sourceout(source_02_01)
                
//                .p_west_in(we_00_in), .p_west_out(we_00_out), .grant_WEST(grant_WEST_00),
//                .in_WEST_handshake_check(in_WEST_hs_00), .out_WEST_handshake_check(out_WEST_hs_00),
                //.north_error, south_error, PE_error, west_error, east_error
    ); 
//   NI NI_10 (.clk(clk),
//           .ready(ready_10), 
//           .enable(enable),
//           .flit_in_IP(PE_10_in), 
//           .flit_out_IP(PE_10_out), 
//           .flit_out_sw(sw_10_out), 
//           .flit_in_sw(sw_10_in), 
//           .timeout(timeout_10),
//           .accept(accept_10)
//           );  
ninterface #(.addr(4'b0100)) NI_10 ( 
                    .pe2s_flitin(  PE_10_in), 
                    .s2pe_flitin(NI10_s2pe_flitin),
                    .clk(  clk), 
                    .enable(  enable),
                    .s2pe_grant(NI10_s2pe_grant),
                    .pe2s_grant(NI10_pe2s_grant),
                    .source(NI10_sourcein),
                    .gate(NI10_gatein),
                    .handshake_check(NI10_handshake_check),
                    .pe2s_flitout(NI10_pe2s_flitout), 
                    .s2pe_flitout(  PE_10_out),
                    .ready(  NI10_ready), 
                    .timeout(  NI10_timeout), 
                    .accept(  NI10_accept)

    );  
switch #(.address(4'b0100)) NODE_10(
                .clk(  clk), .reset(  reset), .enable(  enable), 
                
                .p_PE_in(NI10_pe2s_flitout), .p_PE_out(NI10_s2pe_flitin), 
                .grant_PE_in(NI10_pe2s_grant), .grant_PE_out(NI10_s2pe_grant),
                .in_PE_handshake_check(NI10_handshake_check), //.out_PE_handshake_check(out_PE_hs_00),
                .PE_gatein(NI10_gatein), .PE_sourcein(NI10_sourcein), //.PE_gateout(NI10_gateout), .PE_sourceout(NI10_sourceout),
                
                .p_north_in(flit_11_10), .p_north_out(flit_10_11), 
                .grant_NORTH_in(grant_11_10), .grant_NORTH_out(grant_10_11), 
                .in_NORTH_handshake_check(handshake_11_10), .out_NORTH_handshake_check(handshake_10_11),
                .north_gatein(gate_11_10), .north_sourcein(source_11_10), .north_gateout(gate_10_11), .north_sourceout(source_10_11),
                
                .p_east_in(flit_20_10), .p_east_out(flit_10_20), 
                .grant_EAST_in(grant_20_10), .grant_EAST_out(grant_10_20),
                .in_EAST_handshake_check(handshake_20_10), .out_EAST_handshake_check(handshake_10_20),
                .east_gatein(gate_20_10), .east_sourcein(source_20_10), .east_gateout(gate_10_20), .east_sourceout(source_10_20),
                
                .p_south_in(flit_so_10), .p_south_out(flit_10_so), 
                .grant_SOUTH_in(grant_so_10), .grant_SOUTH_out(grant_10_so),
                .in_SOUTH_handshake_check(handshake_so_10), .out_SOUTH_handshake_check(handshake_10_so),
                .south_gatein(gate_so_10), .south_sourcein(source_so_10), .south_gateout(gate_10_so), .south_sourceout(source_10_so),
               
                .p_west_in(flit_00_10), .p_west_out(flit_10_00), 
                .grant_WEST_in(grant_00_10), .grant_WEST_out(grant_10_00),
                .in_WEST_handshake_check(handshake_00_10), .out_WEST_handshake_check(handshake_10_00),
                .west_gatein(gate_00_10), .west_sourcein(source_00_10), .west_gateout(gate_10_00), .west_sourceout(source_10_00)
                //.north_error, south_error, PE_error, west_error, east_error
    );  
    
//  NI NI_11 (.clk(clk),
//           .ready(ready_11), 
//           .enable(enable),
//           .flit_in_IP(PE_11_in), 
//           .flit_out_IP(PE_11_out), 
//           .flit_out_sw(sw_11_out), 
//           .flit_in_sw(sw_11_in), 
//           .timeout(timeout_11),
//           .accept(accept_11)
//           );  
ninterface #(.addr(4'b0101)) NI_11 ( 
                    .pe2s_flitin(  PE_11_in), 
                    .s2pe_flitin(NI11_s2pe_flitin),
                    .clk(  clk), 
                    .enable(  enable),
                    .s2pe_grant(NI11_s2pe_grant),
                    .pe2s_grant(NI11_pe2s_grant),
                    .source(NI11_sourcein),
                    .gate(NI11_gatein),
                    .handshake_check(NI11_handshake_check),
                    .pe2s_flitout(NI11_pe2s_flitout), 
                    .s2pe_flitout(  PE_11_out),
                    .ready(  NI11_ready), 
                    .timeout(  NI11_timeout), 
                    .accept(  NI11_accept)

    );  
switch #(.address(4'b0101)) NODE_11(
                .clk(  clk), .reset(  reset), .enable(  enable), 
                
                .p_PE_in(NI11_pe2s_flitout), .p_PE_out(NI11_s2pe_flitin), 
                .grant_PE_in(NI11_pe2s_grant), .grant_PE_out(NI11_s2pe_grant),
                .in_PE_handshake_check(NI11_handshake_check), //.out_PE_handshake_check(out_PE_hs_00),
                .PE_gatein(NI11_gatein), .PE_sourcein(NI11_sourcein), //.PE_gateout(NI11_gateout), .PE_sourceout(NI11_sourceout),
                
                .p_north_in(flit_12_11), .p_north_out(flit_11_12), 
                .grant_NORTH_in(grant_12_11), .grant_NORTH_out(grant_11_12), 
                .in_NORTH_handshake_check(handshake_12_11), .out_NORTH_handshake_check(handshake_11_12),
                .north_gatein(gate_12_11), .north_sourcein(source_12_11), .north_gateout(gate_11_12), .north_sourceout(source_11_12),
                
                .p_east_in(flit_21_11), .p_east_out(flit_11_21), 
                .grant_EAST_in(grant_21_11), .grant_EAST_out(grant_11_21),
                .in_EAST_handshake_check(handshake_21_11), .out_EAST_handshake_check(handshake_11_21),
                .east_gatein(gate_21_11), .east_sourcein(source_21_11), .east_gateout(gate_11_21), .east_sourceout(source_11_21),
                
                .p_south_in(flit_10_11), .p_south_out(flit_11_10), 
                .grant_SOUTH_in(grant_10_11), .grant_SOUTH_out(grant_11_10),
                .in_SOUTH_handshake_check(handshake_10_11), .out_SOUTH_handshake_check(handshake_11_10),
                .south_gatein(gate_10_11), .south_sourcein(source_10_11), .south_gateout(gate_11_10), .south_sourceout(source_11_10),
                
                .p_west_in(flit_01_11), .p_west_out(flit_11_01), 
                .grant_WEST_in(grant_01_11), .grant_WEST_out(grant_11_01),
                .in_WEST_handshake_check(handshake_01_11), .out_WEST_handshake_check(handshake_11_01),
                .west_gatein(gate_01_11), .west_sourcein(source_01_11), .west_gateout(gate_11_01), .west_sourceout(source_11_01)  
  );
//   NI NI_12 (.clk(clk),
//           .ready(ready_12), 
//           .enable(enable),
//           .flit_in_IP(PE_12_in), 
//           .flit_out_IP(PE_12_out), 
//           .flit_out_sw(sw_12_out), 
//           .flit_in_sw(sw_12_in), 
//           .timeout(timeout_12),
//           .accept(accept_12)
//           );  
ninterface #(.addr(4'b0110)) NI_12 ( 
                    .pe2s_flitin(  PE_12_in), 
                    .s2pe_flitin(NI12_s2pe_flitin),
                    .clk(  clk), 
                    .enable(  enable),
                    .s2pe_grant(NI12_s2pe_grant),
                    .pe2s_grant(NI12_pe2s_grant),
                    .source(NI12_sourcein),
                    .gate(NI12_gatein),
                    .handshake_check(NI12_handshake_check),
                    .pe2s_flitout(NI12_pe2s_flitout), 
                    .s2pe_flitout(  PE_12_out),
                    .ready(  NI12_ready), 
                    .timeout(  NI12_timeout), 
                    .accept(  NI12_accept)

    );  
switch #(.address(4'b0110)) NODE_12(
                .clk(  clk), .reset(  reset), .enable(  enable), 
                
                .p_PE_in(NI12_pe2s_flitout), .p_PE_out(NI12_s2pe_flitin), 
                .grant_PE_in(NI12_pe2s_grant), .grant_PE_out(NI12_s2pe_grant),
                .in_PE_handshake_check(NI12_handshake_check), //.out_PE_handshake_check(out_PE_hs_00),
                .PE_gatein(NI12_gatein), .PE_sourcein(NI12_sourcein),// .PE_gateout(NI12_gateout), .PE_sourceout(NI12_sourceout),
                
               .p_north_in(flit_no_12), .p_north_out(flit_12_no), 
                .grant_NORTH_in(grant_no_12), .grant_NORTH_out(grant_12_no), 
                .in_NORTH_handshake_check(handshake_no_12), .out_NORTH_handshake_check(handshake_12_no),
               .north_gatein(gate_no_12), .north_sourcein(source_no_12), .north_gateout(gate_12_no), .north_sourceout(source_12_no),
                
                .p_east_in(flit_22_12), .p_east_out(flit_12_22), 
                .grant_EAST_in(grant_22_12), .grant_EAST_out(grant_12_22),
                .in_EAST_handshake_check(handshake_22_12), .out_EAST_handshake_check(handshake_12_22),
                .east_gatein(gate_22_12), .east_sourcein(source_22_12), .east_gateout(gate_12_22), .east_sourceout(source_12_22),
                
                .p_south_in(flit_11_12), .p_south_out(flit_12_11), 
                .grant_SOUTH_in(grant_11_12), .grant_SOUTH_out(grant_12_11),
                .in_SOUTH_handshake_check(handshake_11_12), .out_SOUTH_handshake_check(handshake_12_11),
                .south_gatein(gate_11_12), .south_sourcein(source_11_12), .south_gateout(gate_12_11), .south_sourceout(source_12_11),
                
                .p_west_in(flit_02_12), .p_west_out(flit_12_02), 
                .grant_WEST_in(grant_02_12), .grant_WEST_out(grant_12_02),
                .in_WEST_handshake_check(handshake_02_12), .out_WEST_handshake_check(handshake_12_02),
                .west_gatein(gate_02_12), .west_sourcein(source_02_12), .west_gateout(gate_12_02), .west_sourceout(source_12_02)  
  );
//    NI NI_20 (.clk(clk),
//           .ready(ready_20), 
//           .enable(enable),
//           .flit_in_IP(PE_20_in), 
//           .flit_out_IP(PE_20_out), 
//           .flit_out_sw(sw_20_out), 
//           .flit_in_sw(sw_20_in), 
//           .timeout(timeout_20),
//           .accept(accept_20)
//           ); 
ninterface #(.addr(4'b1000)) NI_20 ( 
                    .pe2s_flitin(  PE_20_in), 
                    .s2pe_flitin(NI20_s2pe_flitin),
                    .clk(  clk), 
                    .enable(  enable),
                    .s2pe_grant(NI20_s2pe_grant),
                    .pe2s_grant(NI20_pe2s_grant),
                    .source(NI20_sourcein),
                    .gate(NI20_gatein),
                    .handshake_check(NI20_handshake_check),
                    .pe2s_flitout(NI20_pe2s_flitout), 
                    .s2pe_flitout(  PE_20_out),
                    .ready(  NI20_ready), 
                    .timeout(  NI20_timeout), 
                    .accept(  NI20_accept)

    );  
switch #(.address(4'b1000)) NODE_20(
                .clk(  clk), .reset(  reset), .enable(  enable), 
                
                .p_PE_in(NI20_pe2s_flitout), .p_PE_out(NI20_s2pe_flitin), 
                .grant_PE_in(NI20_pe2s_grant), .grant_PE_out(NI20_s2pe_grant),
                .in_PE_handshake_check(NI20_handshake_check), //.out_PE_handshake_check(out_PE_hs_00),
                .PE_gatein(NI20_gatein), .PE_sourcein(NI20_sourcein), //.PE_gateout(NI20_gateout), .PE_sourceout(NI20_sourceout),
                
                .p_north_in(flit_21_20), .p_north_out(flit_20_21), 
                .grant_NORTH_in(grant_21_20), .grant_NORTH_out(grant_20_21), 
                .in_NORTH_handshake_check(handshake_21_20), .out_NORTH_handshake_check(handshake_20_21),
                .north_gatein(gate_21_20), .north_sourcein(source_21_20), .north_gateout(gate_20_21), .north_sourceout(source_20_21),
                
//                .p_east_in(flit_21_11), .p_east_out(flit_11_21), 
//                .grant_EAST_in(grant_21_11), .grant_EAST_out(grant_11_21),
//                .in_EAST_handshake_check(handshake_21_11), .out_EAST_handshake_check(handshake_11_21),
//                .east_gatein(gate_21_11), .east_sourcein(source_21_11), .east_gateout(gate_11_21), .east_sourceout(source_11_21),
                
//                .p_south_in(flit_10_11), .p_south_out(flit_11_10), 
//                .grant_SOUTH_in(grant_10_11), .grant_SOUTH_out(grant_11_10),
//                .in_SOUTH_handshake_check(handshake_10_11), .out_SOUTH_handshake_check(handshake_11_10),
//                .south_gatein(gate_10_11), .south_sourcein(source_10_11), .south_gateout(gate_11_10), .south_sourceout(source_11_10),
                
                .p_west_in(flit_10_20), .p_west_out(flit_20_10), 
                .grant_WEST_in(grant_10_20), .grant_WEST_out(grant_20_10),
                .in_WEST_handshake_check(handshake_10_20), .out_WEST_handshake_check(handshake_20_10),
                .west_gatein(gate_10_20), .west_sourcein(source_10_20), .west_gateout(gate_20_10), .west_sourceout(source_20_10)  
  ); 
// NI NI_21 (.clk(clk),
//           .ready(ready_21),
//           .enable(enable), 
//           .flit_in_IP(PE_21_in), 
//           .flit_out_IP(PE_21_out), 
//           .flit_out_sw(sw_21_out), 
//           .flit_in_sw(sw_21_in), 
//           .timeout(timeout_21),
//           .accept(accept_21)
//           );  
ninterface #(.addr(4'b1001)) NI_21 ( 
                    .pe2s_flitin(  PE_21_in), 
                    .s2pe_flitin(NI21_s2pe_flitin),
                    .clk(  clk), 
                    .enable(  enable),
                    .s2pe_grant(NI21_s2pe_grant),
                    .pe2s_grant(NI21_pe2s_grant),
                    .source(NI21_sourcein),
                    .gate(NI21_gatein),
                    .handshake_check(NI21_handshake_check),
                    .pe2s_flitout(NI21_pe2s_flitout), 
                    .s2pe_flitout(  PE_21_out),
                    .ready(  NI21_ready), 
                    .timeout(  NI21_timeout), 
                    .accept(  NI21_accept)

    );    
switch #(.address(4'b1001)) NODE_21(
                .clk(  clk), .reset(  reset), .enable(  enable), 
                
                .p_PE_in(NI21_pe2s_flitout), .p_PE_out(NI21_s2pe_flitin), 
                .grant_PE_in(NI21_pe2s_grant), .grant_PE_out(NI21_s2pe_grant),
                .in_PE_handshake_check(NI21_handshake_check), //.out_PE_handshake_check(out_PE_hs_00),
                .PE_gatein(NI21_gatein), .PE_sourcein(NI21_sourcein), //.PE_gateout(NI21_gateout), .PE_sourceout(NI21_sourceout),
                
                .p_north_in(flit_22_21), .p_north_out(flit_21_22), 
                .grant_NORTH_in(grant_22_21), .grant_NORTH_out(grant_21_22), 
                .in_NORTH_handshake_check(handshake_22_21), .out_NORTH_handshake_check(handshake_21_22),
                .north_gatein(gate_22_21), .north_sourcein(source_22_21), .north_gateout(gate_21_22), .north_sourceout(source_21_22),
                
//                .p_east_in(flit_21_11), .p_east_out(flit_11_21), 
//                .grant_EAST_in(grant_21_11), .grant_EAST_out(grant_11_21),
//                .in_EAST_handshake_check(handshake_21_11), .out_EAST_handshake_check(handshake_11_21),
//                .east_gatein(gate_21_11), .east_sourcein(source_21_11), .east_gateout(gate_11_21), .east_sourceout(source_11_21),
                
                .p_south_in(flit_20_21), .p_south_out(flit_21_20), 
                .grant_SOUTH_in(grant_20_21), .grant_SOUTH_out(grant_21_20),
                .in_SOUTH_handshake_check(handshake_20_21), .out_SOUTH_handshake_check(handshake_21_20),
                .south_gatein(gate_20_21), .south_sourcein(source_20_21), .south_gateout(gate_21_20), .south_sourceout(source_21_20),
                
                .p_west_in(flit_11_21), .p_west_out(flit_21_11), 
                .grant_WEST_in(grant_11_21), .grant_WEST_out(grant_21_11),
                .in_WEST_handshake_check(handshake_11_21), .out_WEST_handshake_check(handshake_21_11),
                .west_gatein(gate_11_21), .west_sourcein(source_11_21), .west_gateout(gate_21_11), .west_sourceout(source_21_11)  
  );
ninterface #(.addr(4'b1010)) NI_22 ( 
                    .pe2s_flitin(  PE_22_in), 
                    .s2pe_flitin(NI22_s2pe_flitin),
                    .clk(  clk), 
                    .enable(  enable),
                    .s2pe_grant(NI22_s2pe_grant),
                    .pe2s_grant(NI22_pe2s_grant),
                    .source(NI22_sourcein),
                    .gate(NI22_gatein),
                    .handshake_check(NI22_handshake_check),
                    .pe2s_flitout(NI22_pe2s_flitout), 
                    .s2pe_flitout(  PE_22_out),
                    .ready(  NI22_ready), 
                    .timeout(  NI22_timeout), 
                    .accept(  NI22_accept)

    );     
switch #(.address(4'b1010)) NODE_22(
                .clk(  clk), .reset(  reset), .enable(  enable), 
                
                .p_PE_in(NI22_pe2s_flitout), .p_PE_out(NI22_s2pe_flitin), 
                .grant_PE_in(NI22_pe2s_grant), .grant_PE_out(NI22_s2pe_grant),
                .in_PE_handshake_check(NI22_handshake_check), //.out_PE_handshake_check(out_PE_hs_00),
                .PE_gatein(NI22_gatein), .PE_sourcein(NI22_sourcein), //.PE_gateout(NI22_gateout), .PE_sourceout(NI22_sourceout),
                
                .p_north_in(flit_no_22), .p_north_out(flit_22_no), 
                .grant_NORTH_in(grant_no_22), .grant_NORTH_out(grant_22_no), 
                .in_NORTH_handshake_check(handshake_no_22), .out_NORTH_handshake_check(handshake_22_no),
               .north_gatein(gate_no_22), .north_sourcein(source_no_22), .north_gateout(gate_22_no), .north_sourceout(source_22_no),
                              
//                .p_east_in(flit_21_11), .p_east_out(flit_11_21), 
//                .grant_EAST_in(grant_21_11), .grant_EAST_out(grant_11_21),
//                .in_EAST_handshake_check(handshake_21_11), .out_EAST_handshake_check(handshake_11_21),
//                .east_gatein(gate_21_11), .east_sourcein(source_21_11), .east_gateout(gate_11_21), .east_sourceout(source_11_21),
                
                .p_south_in(flit_21_22), .p_south_out(flit_22_21), 
                .grant_SOUTH_in(grant_21_22), .grant_SOUTH_out(grant_22_21),
                .in_SOUTH_handshake_check(handshake_21_22), .out_SOUTH_handshake_check(handshake_22_21),
                .south_gatein(gate_21_22), .south_sourcein(source_21_22), .south_gateout(gate_22_21), .south_sourceout(source_22_21),
                
                .p_west_in(flit_12_22), .p_west_out(flit_22_12), 
                .grant_WEST_in(grant_12_22), .grant_WEST_out(grant_22_12),
                .in_WEST_handshake_check(handshake_12_22), .out_WEST_handshake_check(handshake_22_12),
                .west_gatein(gate_12_22), .west_sourcein(source_12_22), .west_gateout(gate_22_12), .west_sourceout(source_22_12)  
  );   
endmodule