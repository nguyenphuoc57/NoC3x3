
module Route #(parameter addr=4'b0000) (clk, enable, flit_in, mark_trip, flit_out, flit_gate,flit_type );

input clk;
input enable;
input [31:0]flit_in;
input [19:0] mark_trip;
output reg[31:0] flit_out;
output reg [2:0] flit_gate;
output reg [1:0] flit_type;
reg [1:0]  Cx, Cy;
always @(posedge clk) begin
    if(enable) begin
     Cx=addr[3:2];
     Cy=addr[1:0];
     //
     flit_type <= flit_in[31:30];
     if(flit_in[31:30] == 2'b10) begin        //FLIT HEADER
            flit_out = flit_in;
            if (flit_in[25:24] > Cx)  // EAST
                flit_gate <= 3'b001;
            else if (flit_in[25:24] < Cx) // WEST
                flit_gate <= 3'b011;
            else if (flit_in[25:24]==Cx)begin
                if( flit_in[23:22]> Cy)     // NORTH
                    flit_gate <= 3'b000;
                else if (flit_in[23:22] < Cy) //SOUTH
                    flit_gate <= 3'b010;
                else if (flit_in[23:22]== Cy)  //PE
                    flit_gate <= 3'b100;               
            end
     end
     else if (flit_in[31:30] == 2'b11) begin     //FLIT HANDSHAKE
            //
            //type of handshake
           case(flit_in[21])
            1'b0: begin
    
                if(flit_in[25:22]==addr) begin        
                   flit_out <= {flit_in[31:22],1'b1,1'b1, mark_trip};
                   if(flit_in[29:26]== addr)
                        flit_gate <= 3'b100;
                   else begin
                       if (flit_in[3:2] > Cx) // EAST  
                            flit_gate <= 3'b001;  
                       else if (flit_in[3:2]< Cx) // WEST
                            flit_gate <= 3'b011;
                       else if (flit_in[3:2]==Cx)begin
                            if( flit_in[1:0]> Cy)     // NORTH
                                flit_gate <= 3'b000;
                            else if (flit_in[1:0]< Cy) //SOUTH
                                flit_gate <= 3'b010;                                           
                       end 
                    end
                   end     
                    //not dest
                else if(flit_in[25:22]!=addr)begin
                    flit_out <= {flit_in[31:20], mark_trip[19:4], addr};
                    if (flit_in[25:24] > Cx) // EAST  
                        flit_gate <= 3'b001;  
                    else if (flit_in[25:24] < Cx) // WEST
                        flit_gate <= 3'b011;
                    else if (flit_in[25:24]==Cx)begin
                        if( flit_in[23:22]> Cy)     // NORTH
                            flit_gate <= 3'b000;
                        else if (flit_in[23:22] < Cy) //SOUTH
                            flit_gate <= 3'b010;      
                         else if (flit_in[23:22]== Cy)  //PE
                        flit_gate <= 3'b100;                    
                    end
                end
            end
            1'b1: begin
                //source     
                flit_out <= {flit_in[31:20], mark_trip};
                if(flit_in[29:26]==addr) begin        
                    flit_gate =3'b100;
                end
                //not source
                else if(flit_in[29:26]!=addr)begin
                    if (mark_trip[3:2] > Cx) // EAST  
                        flit_gate <= 3'b001;  
                    else if (mark_trip[3:2]< Cx) // WEST
                        flit_gate <= 3'b011;
                    else if (mark_trip[3:2]==Cx)begin
                        if( mark_trip[1:0]> Cy)     // NORTH
                            flit_gate <= 3'b000;
                        else if (mark_trip[1:0]< Cy) //SOUTH
                            flit_gate <= 3'b010; 
                        else if (flit_in[23:22]== Cy)  //PE
                            flit_gate <= 3'b100;    
                        else 
                            flit_gate <= 3'b101;                            
                    end 
                    else
                    flit_gate <= 3'b111; 
                end
//                else 
//                     
                
            end
            endcase
     end
    else 
        flit_out <= flit_in;
//        flit_gate <= flit_gate;
    end
end
endmodule
