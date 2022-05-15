
module Shifter #(parameter addr=4'd0000) (clk,enable, flit_in, mark_trip, flit_out);

input clk, enable ;
input [31:0] flit_in;
output reg [19:0] mark_trip;
output reg [31:0] flit_out;

always @(posedge clk) begin
     if(~enable) begin
      
     
     end
     else if(enable) begin
        //
        //FLIT HANDSHAKE 
        flit_out <= flit_in;
        if(flit_in[31:30] == 2'b11) begin       
            //type of flit handshake 
            case(flit_in[21]) 
                //
                //flit sending handshake
                1'b0: begin     
                   if(flit_in[25:22] == addr)  //DEST
                    mark_trip <= flit_in[19:0];
                   else                         //NOT DEST
                    mark_trip <= flit_in[19:0] << 4;
                end
                //
                //flit receiving handshake
                1'b1: begin
                    if(flit_in[29:26]==addr)    //source
                        mark_trip <= 19'b0;     //reset mark_trip
                    else 
                        mark_trip <= flit_in[19:0] >> 4;
                end
            endcase
        end
        //
    end
end 
endmodule
