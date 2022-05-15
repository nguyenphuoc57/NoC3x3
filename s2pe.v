module s2pe( clk, enable, flit_in, finish, flit_out,  result, grant);

input clk, enable;
input [31:0] flit_in;

output reg finish;
output reg [31:0] flit_out; 
output reg result;
output grant; 

always @(posedge clk) begin
    if(~enable) begin
        finish <=0;
    end 
    else if(enable) begin
         flit_out <= flit_in;       
        //flit returning handshake
        if(flit_in[31:30] == 2'b11 && flit_in [21] == 1'b1 ) begin
            finish <=1'b1;
            result <= flit_in[20];
        end 
        else 
            result <= 1'b0;
        if (flit_in [31:30] != 2'b10) begin 
            finish <= 1'b0;           
        end
//        if (flit_in [31:30] == 2'b01) begin
            
//        end 
    end
end 
assign grant = 1'd1;
endmodule
