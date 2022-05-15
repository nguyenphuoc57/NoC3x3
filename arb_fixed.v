`timescale 1ns / 1ps
module arb_fixed #(parameter port=3'd0)(clk,rst, pe_gate, north_gate, south_gate, east_gate, west_gate, grant);
input clk, rst;
input [2:0] pe_gate, north_gate, south_gate, east_gate, west_gate;
output reg [2:0] grant;

always @(posedge clk) begin
   /* if(rst) 
        grant <= 3'd5;
    else*/
    if(pe_gate == port)
        grant <= 3'd4;
    else if(north_gate == port)
        grant <= 3'd0;
    else if(east_gate == port)
        grant <= 3'd1;
    else if(south_gate == port)
        grant <= 3'd2;
    else if(west_gate == port)
        grant <= 3'd3;
    else 
         grant <= 3'd5;

end 
endmodule 