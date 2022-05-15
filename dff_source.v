
module dff_source(in_data,enable,out_data,clk);
parameter Width=4;
input [Width-1:0] in_data;
input enable,clk;
output reg [Width-1:0] out_data;

always @(posedge clk)begin
      if(enable)
      out_data <= in_data;
      else out_data <= 32'bx;
end

endmodule
