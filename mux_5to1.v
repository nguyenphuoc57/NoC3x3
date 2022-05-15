`timescale 1ns / 1ps
module mux_5to1(clk, enable, grant, pe_flit, north_flit, south_flit, east_flit, west_flit, flit_out);

input clk, enable;
input [2:0] grant;
input [31:0] pe_flit, north_flit, south_flit, east_flit, west_flit;
output reg [31:0] flit_out;

always @(posedge clk) begin
    if(~enable) begin
        flit_out <= 32'bx;    
    end
    else if(enable) begin
        case(grant)
            0: flit_out <= north_flit;
            1: flit_out <= east_flit;    
            2: flit_out <= south_flit;
            3: flit_out <= west_flit;
            4: flit_out <= pe_flit;
            5: flit_out <= 32'bx;
            default: flit_out <= 32'dx;
        endcase
        
    end
end

endmodule
