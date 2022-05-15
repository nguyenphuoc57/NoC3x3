
module dff_enable(in_data,enable,out_data,clk);
parameter Width=32;
input [Width-1:0] in_data;
input enable,clk;
output reg [Width-1:0] out_data;

always @(posedge clk)begin
      
      if(in_data[31:30] == 2'b11 ||in_data[31:30] == 2'b10 ||in_data[31:30] == 2'b00 ||in_data[31:30] == 2'b01 )
      out_data <= in_data;
      else if(enable)
        out_data <= out_data;
end

endmodule
