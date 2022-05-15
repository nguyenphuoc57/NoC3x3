`timescale 1ns / 1ps
module Crossbar (clk, enable,
						PE_out, 	PE_gate, 	PE_data, 
						west_out,	west_gate,	west_data, 
						north_out,	north_gate, north_data, 
						east_out, 	east_gate, 	east_data, 
						south_out, 	south_gate, 	south_data);
input clk, enable;
input [31:0] PE_data,
				 west_data,      //DATA INPUT
				 north_data,
				 east_data,
				 south_data;
input [2:0]     PE_gate,
				 west_gate,		//GATE OUTPUT
				 north_gate,
				 east_gate,
				 south_gate;
output [31:0]	  PE_out,
					west_out,		//DATA OUTPUT
					north_out,
					east_out,
					south_out;
wire [31:0] PE_flit, north_flit, east_flit, south_flit, west_flit;
wire [2:0] grant_PE, grant_north, grant_east ,grant_south, grant_west;

dff_enable dff_PE(
            .in_data(PE_data),
            .enable(enable),
            .out_data(PE_flit),
            .clk(clk)
            );
dff_enable dff_north(
            .in_data(north_data),
            .enable(enable),
            .out_data(north_flit),
            .clk(clk)
            );
dff_enable dff_east(
            .in_data(east_data),
            .enable(enable),
            .out_data(east_flit),
            .clk(clk)
            );     
dff_enable dff_south(
            .in_data(south_data),
            .enable(enable),
            .out_data(south_flit),
            .clk(clk)
            );
dff_enable dff_west(
            .in_data(west_data),
            .enable(enable),
            .out_data(west_flit),
            .clk(clk)
            );                               
// PE
// arbiter and mux 
mux_5to1 mux_PE (
            .clk(clk), 
            .enable(enable), 
            .grant(grant_PE), 
            .pe_flit(PE_flit), 
            .north_flit(north_flit), 
            .south_flit(south_flit), 
            .east_flit(east_flit), 
            .west_flit(west_flit), 
            .flit_out(PE_out)
            );
arb_fixed #(.port(3'd4)) arb_fixed_PE(
            .clk(clk),
       //     .rst(rst), 
            .pe_gate(PE_gate), 
            .north_gate(north_gate), 
            .south_gate(south_gate), 
            .east_gate(east_gate), 
            .west_gate(west_gate), 
            .grant(grant_PE)
            );

// north
// arbiter and mux 
mux_5to1 mux_north (
            .clk(clk), 
            .enable(enable), 
            .grant(grant_north), 
            .pe_flit(PE_flit), 
            .north_flit(north_flit), 
            .south_flit(south_flit), 
            .east_flit(east_flit), 
            .west_flit(west_flit), 
            .flit_out(north_out)
            );
arb_fixed #(.port(3'd0)) arb_fixed_north(
            .clk(clk),
       //     .rst(rst), 
            .pe_gate(PE_gate), 
            .north_gate(north_gate), 
            .south_gate(south_gate), 
            .east_gate(east_gate), 
            .west_gate(west_gate), 
            .grant(grant_north)
            );
// west
// arbiter and mux 
mux_5to1 mux_west (
            .clk(clk), 
            .enable(enable), 
            .grant(grant_west), 
            .pe_flit(PE_flit), 
            .north_flit(north_flit), 
            .south_flit(south_flit), 
            .east_flit(east_flit), 
            .west_flit(west_flit), 
            .flit_out(west_out)
            );
arb_fixed #(.port(3'd3)) arb_fixed_west(
            .clk(clk),
        //    .rst(rst), 
            .pe_gate(PE_gate), 
            .north_gate(north_gate), 
            .south_gate(south_gate), 
            .east_gate(east_gate), 
            .west_gate(west_gate), 
            .grant(grant_west)
            );
// east
// arbiter and mux 
mux_5to1 mux_east (
            .clk(clk), 
            .enable(enable), 
            .grant(grant_east), 
            .pe_flit(PE_flit), 
            .north_flit(north_flit), 
            .south_flit(south_flit), 
            .east_flit(east_flit), 
            .west_flit(west_flit), 
            .flit_out(east_out)
            );
arb_fixed #(.port(3'd1)) arb_fixed_east(
            .clk(clk),
        //    .rst(rst), 
            .pe_gate(PE_gate), 
            .north_gate(north_gate), 
            .south_gate(south_gate), 
            .east_gate(east_gate), 
            .west_gate(west_gate), 
            .grant(grant_east)
            );          
// south
// arbiter and mux 
mux_5to1 mux_south (
            .clk(clk), 
            .enable(enable), 
            .grant(grant_south), 
            .pe_flit(PE_flit), 
            .north_flit(north_flit), 
            .south_flit(south_flit), 
            .east_flit(east_flit), 
            .west_flit(west_flit), 
            .flit_out(south_out)
            );
arb_fixed #(.port(3'd2)) arb_fixed_south(
            .clk(clk),
        //    .rst(rst), 
            .pe_gate(PE_gate), 
            .north_gate(north_gate), 
            .south_gate(south_gate), 
            .east_gate(east_gate), 
            .west_gate(west_gate), 
            .grant(grant_south)
            );
endmodule
//reg n_busy,s_busy,e_busy, w_busy, PE_busy;
//reg [2:0] n_gate, s_gate, e_gate, w_gate, PEs_gate;
//always @(posedge clk) begin
//    if(!enable) begin
//    n_busy<=0;
//    s_busy<=0;
//    e_busy<=0;
//    w_busy<=0; 
//    PE_busy<=0;
//    end
//    if(enable) begin
//        case(north_out[31:30])
//           2'b10: n_busy<=1;
//           2'b01: n_busy<=0;
//           2'b11: n_busy<=0;
//        endcase
//        case(east_out[31:30])
//           2'b10: e_busy<=1;
//           2'b01: e_busy<=0;
//           2'b11: e_busy<=0;
//        endcase
//        case(south_out[31:30])
//           2'b10: s_busy<=1;
//           2'b01: s_busy<=0;
//           2'b11: s_busy<=0;
//        endcase
//        case(west_out[31:30])
//           2'b10: w_busy<=1;
//           2'b01: w_busy<=0;
//           2'b11: w_busy<=0;
//        endcase
//        case(PE_out[31:30])
//           2'b10: PE_busy<=1;
//           2'b01: PE_busy<=0;
//           2'b11: PE_busy<=0;
//        endcase
//    end

//end
/*always @(posedge clk) begin
		if (enable) begin
		      
		    //------------------------NORTH OUT ---------------------//  
		     case(n_busy)
		      1'd0: begin         //DO UU TIEN THEO DONG HO
				//North
				if(PE_gate == 3'd0) begin
					north_out<=PE_data;
					n_gate <=3'd4;					
				end	
				else if(north_gate == 3'd0) begin
					north_out<=north_data;
					n_gate <=3'd0;
				end	
				else if(east_gate == 3'd0) begin
					north_out<=east_data;
					n_gate <= 3'd1;
			     end
				else if(south_gate == 3'd0) begin
					north_out<=south_data;
					n_gate <= 3'd2;
				end	
				else if(west_gate == 3'd0) begin
					north_out<=west_data;
					n_gate <= 3'd3;
			    end
			     else begin 
			        north_out <= 32'dx;
			        n_gate <= 3'dx;
			       end
			  end	
			  1'd1: begin
			     case(n_gate)
			     3'd0: north_out <= north_data;
			     3'd1: north_out <= east_data;
			     3'd2: north_out <= south_data;
			     3'd3: north_out <= west_data;
			     3'd4: north_out <= PE_data;
			     3'd5: north_out <= 32'bx;
			     endcase     
			  end
			  endcase
			  //------------------------EAST OUT ---------------------//
			  case(e_busy)
                1'b0: begin  
                        if(PE_gate == 3'd1) begin
                            east_out <=PE_data;
                            e_gate <=3'd4;
                        end
                        else if(north_gate == 3'd1) begin
                            east_out<=north_data;
                            e_gate <=3'd0;
                        end
                        else if(east_gate == 3'd1) begin
                            east_out<=east_data;
                            e_gate<=3'd1;
                        end
                        else if(south_gate == 3'd1) begin
                            east_out <=south_data;
                            e_gate <=3'd2;
                         end
                        else if(west_gate == 3'd1) begin
                            east_out<=west_data;
                            e_gate <=3'd3;
                         end
                        else begin
                            east_out <=  32'dx;
                            e_gate <=3'dx;
                         end
                      end	
		        1'b1: begin
		              case(e_gate)
                     3'd0: east_out <= north_data;
                     3'd1: east_out <= east_data;
                     3'd2: east_out <= south_data;
                     3'd3: east_out <= west_data;
                     3'd4: east_out <= PE_data;
                     3'd5: east_out <= 32'bx;
                     endcase  
		        end
		        endcase
  
		    //------------------------SOUTH OUT ---------------------//   
			case(s_busy)		
			  1'b0: begin  
                        if(PE_gate == 3'd2) begin
                            south_out <=PE_data;
                            s_gate <=3'd4;
                        end
                        else if(north_gate == 3'd2) begin
                            south_out<=north_data;
                            s_gate<=3'd0;
                        end
                        else if(east_gate == 3'd2) begin
                            south_out<=east_data;
                            s_gate <=3'd1;
                        end
                        else if(south_gate == 3'd2) begin
                            south_out <=south_data;
                            s_gate <=3'd2;
                         end
                        else if(west_gate == 3'd2) begin
                            south_out<=west_data;
                            s_gate <=3'd3;
                         end
                        else begin
                            south_out <=  32'dx;
                            s_gate <=3'd5;
                         end
			         end			
			     1'b1: begin
		              case(s_gate)
                         3'd0: south_out <= north_data;
                         3'd1: south_out <= east_data;
                         3'd2: south_out <= south_data;
                         3'd3: south_out <= west_data;
                         3'd4: south_out <= PE_data;
                         3'd5: south_out <= 32'bx;
                     endcase  
		        end
		        endcase
		     //------------------------WEST OUT ---------------------//    
			case(w_busy)
			  1'b0:	begin  
                        if(PE_gate == 3'd3) begin
                            west_out <=PE_data;
                            w_gate <=3'd4;
                        end
                        else if(north_gate == 3'd3) begin
                            west_out<=north_data;
                            w_gate <=3'd0;
                        end
                        else if(east_gate == 3'd3) begin
                            west_out<=east_data;
                            w_gate <=3'd1;
                        end
                        else if(south_gate == 3'd3) begin
                            west_out <=south_data;
                            w_gate <=3'd2;
                         end
                        else if(west_gate == 3'd3) begin
                            west_out<=west_data;
                            w_gate <=3'd3;
                         end
                        else begin
                            west_out <=  32'dx;
                            w_gate <=3'dx;
                         end
			         end
			    1'b1: begin
			         case(w_gate)
                         3'd0: west_out <= north_data;
                         3'd1: west_out <= east_data;
                         3'd2: west_out <= south_data;
                         3'd3: west_out <= west_data;
                         3'd4: west_out <= PE_data;
                         3'd5: west_out <= 32'bx;
                     endcase 
			    end	
			   endcase 
			 //------------------------PE OUT ---------------------//   
		      case(PE_busy)
		       1'b0: begin  
                        if(PE_gate == 3'd4) begin
                            PE_out <=PE_data;
                            PEs_gate <=3'd4;
                        end
                        else if(north_gate == 3'd4) begin
                            PE_out<=north_data;
                            PEs_gate <=3'd0;
                        end
                        else if(east_gate == 3'd4) begin
                            PE_out<=east_data;
                            PEs_gate <=3'd1;
                        end
                        else if(south_gate == 3'd4) begin
                            PE_out <=south_data;
                            PEs_gate=3'd2;
                         end
                        else if(west_gate == 3'd4) begin
                            PE_out<=west_data;
                            PEs_gate <=3'd3;
                         end
                        else begin
                            PE_out <=  32'dx;
                            PEs_gate <=3'dx;
                         end
			         end	
			     1'b1: begin
			         case(PEs_gate)
                         3'd0: PE_out <= north_data;
                         3'd1: PE_out <= east_data;
                         3'd2: PE_out <= south_data;
                         3'd3: PE_out <= west_data;
                         3'd4: PE_out <= PE_data;
                         3'd5: PE_out <= 32'bx;
                     endcase 
			    end	
			    endcase
        end 
end						
endmodule
*/
