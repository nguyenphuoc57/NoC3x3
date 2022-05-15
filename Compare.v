module Compare ( 
input clk,
input enable,
input [1:0] handshake_check,
input [3:0] source,
input [2:0] gate,
input [3:0] ip_source,
input [3:0] north_source,
input [3:0] south_source,
input [3:0] west_source,
input [3:0] east_source,
output reg grant
);
always @(negedge clk) begin
    if(~enable)
        grant <=0;
    else if(enable) begin
    ////// ARBITER WITH TYPE
    case(handshake_check)
        //not flit handshake || flit sending handshake 
        2'b00 | 2'b01: begin
            case(gate)
                3'd0: begin
                    if (north_source == source )
                        grant <= 1;
                    else if(north_source != 4'hf)
                        grant <=0;
                    else 
                        grant <= 1;
                end 
                3'd1: begin
                    if (east_source == source )
                        grant <= 1;
                    else if(east_source != 4'hf)
                        grant<=0;
                    else 
                        grant <= 1;
                end 
                //grant = (east_source == source )? 1'b1:(east_source != 4'bz) ? 1'b0:1'b1;
                3'd2: begin
                    if (south_source == source )
                        grant <= 1;
                    else if(south_source != 4'hf)
                        grant <=0;
                    else 
                        grant <= 1;
                end 
                3'd3: begin
                    if (west_source == source )
                        grant <= 1;
                    else if(west_source != 4'hf)
                        grant <=0;
                    else 
                        grant <= 1;
                end 
                3'd4: begin
                    if (ip_source == source )
                        grant <= 1;
                    else if(ip_source != 4'hf)
                        grant <=0;
                    else 
                        grant <= 1;
                end 
                default: grant <=0;
//                3'd0: grant = (north_source == 4'bz) ? 1:(north_source == source )? 1:0;
//                3'd1: grant = (east_source == source )? 1:(east_source != 4'bz) ? 0:1;
//                3'd2: grant = (south_source == 4'bz) ? 1:(south_source == source )? 1:0;
//                3'd3: grant = (west_source == 4'bz) ? 1:(west_source == source )? 1:0;
//                3'd4: grant = (ip_source == 4'bz) ? 1:(ip_source == source )? 1:0;
            endcase
        end
        
        //flit receiving handshake 
        2'b10: begin
            grant <= 1'b1;
        end
        default: grant <= 1'b0;
    endcase
  //////////////
end
end
endmodule