module dff_define #(parameter WIDTH = 32, parameter val_def = 4'hf )(Q, clk, D,enable);
  //parameter WIDTH=32;

   output reg [WIDTH-1:0] Q;
   input  clk;
   input [WIDTH-1:0]  D;
	input enable;
	
always @(posedge clk) begin
    
	if(~enable)
			Q<=val_def;
	else if (enable)
			Q<=D;
    

end


endmodule