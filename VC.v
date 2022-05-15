module VC ( clk,
            reset,
            enable, 
            stop,
            flit_in, 
            VC_src, 
            empty, 
            flit_out,
            i,j,
            Q1, Q2, Q3, Q4, Q5,
             D1, D2, D3, D4, D5);  //WIDTH-1

input clk,reset,enable,stop;
input [31:0]flit_in;
output [31:0]flit_out;
output reg empty;
output reg [3:0] VC_src;

output  [31:0] Q1, Q2, Q3,Q4, Q5;
output [31:0] D1, D2, D3,D4, D5;

// SIGNAL 
always @(posedge clk) begin
    if(~reset) 
        empty<=1;
    else if(enable) begin
        
        if (flit_in[31:30] == 2'b10 || flit_in[31:30] == 2'b11) begin  //Header in
            VC_src <= flit_in[29:26];
            empty <=0;
        end 
        if (flit_in[31:30] == 2'b01) begin  // tail in
            VC_src <=4'hf;
        end
        if(flit_out[31:30] == 2'b01 || flit_out[31:30] == 2'b11)  //tail out
            empty<=1;
        
     end
 end 
 
// counter write 
output reg [2:0] i,j;

always @(negedge clk) begin
    if(~reset) begin
      i<=0;
    end
  else begin
       i<=i+1;
      if(i==5) 
        i<=1;
  end 
  if(empty)
       i<=1;
end

//couter read
always @(negedge clk) begin
    if(~reset) begin
      j<=0;
    end
  else if (stop == 1'b0)begin
       j<=j+1;
      if(j==5) 
        j<=1;
   if (empty)
        j<=0;
  end 
  

end
//INPUT
demux5to1 dm5t1(  .clk(clk),
				  .S(i), 
                  .D1(D1), 
                  .D2(D2), 
                  .D3(D3), 
                  .D4(D4),
                  .D5(D5),
                  .In(flit_in)
                  );
//OUTPUT
mux5to1 m5t1(     .S(j), 
                  .stop(stop),
                  //.empty(empty),
                  .Q1(Q1), 
                  .Q2(Q2), 
                  .Q3(Q3), 
                  .Q4(Q4),
                  .Q5(Q5),
                  .Out(flit_out),
						.clk(clk)
                  );
dff_define #(.val_def(4'd0)) d1 (.Q(Q1), 
	    	.clk(clk), 
		.D(D1),
		.enable(enable)
		//.rstn(reset)
		);

dff_define #(.val_def(4'd0))d2(.Q(Q2), 
	    	.clk(clk), 
		.D(D2),
		.enable(enable)
		//.rstn(reset)
		);


dff_define #(.val_def(4'd0))d3(.Q(Q3), 
	    	.clk(clk), 
		.D(D3),
		.enable(enable)
		//.rstn(reset)
		);
dff_define #(.val_def(4'd0))d4(.Q(Q4), 
	    	.clk(clk), 
		.D(D4),
		.enable(enable)
		//.rstn(reset)
		);
dff_define #(.val_def(4'd0))d5(.Q(Q5), 
	    	.clk(clk), 
		.D(D5),
		.enable(enable)
		//.rstn(reset)
		);
endmodule

module demux5to1 (clk, S, D1, D2, D3,D4,D5, In);
  input clk;
  input [2:0] S;
  output reg [31:0] D1,D2,D3, D4, D5;
  input  [31:0] In;
always @(posedge clk) begin
	case(S)
		3'd1: begin D1 <= In; 
//						D2=32'dx; 
//						D3=32'dx;
//						D4=32'dx;
//						D5=32'dx;
						end
		3'd2: begin	
//		                  D1 = 32'dx;
						D2 <= In;
//						D3= 32'dx;
//						D4=32'dx;
//						D5=32'dx;
						end 
		3'd3: begin 
//		              D1=32'dx;
//					   D2=32'dx;
						D3 <= In;
//						D4=32'dx;
//					D5=32'dx;
						end
		3'd4: begin 
//	              D1=32'dx;
//				   D2=32'dx;
//						D3 = 32'dx;
						D4<=In;
//					D5=32'dx;
						end
	    3'd5: begin 
//                   D1=32'dx;
//				   D2=32'dx;
//						D3 = 32'dx;
//						D4=32'dx;
						D5<=In;
						end
	endcase
end
endmodule

module mux5to1 (S,clk,stop, Q1, Q2, Q3, Q4, Q5, Out);
  input clk;
  input [2:0] S;
  input stop;//empty;
  input [31:0] Q1,Q2,Q3,Q4, Q5;
  output reg [31:0] Out;
always @(posedge clk) begin
   if(stop == 1'b1) begin
        Out<=32'bx;
   end  
   else if(stop==0)begin
        
        case(S)       
           
            1: Out <= Q1; 
            2: Out <= Q2;
            3: Out <= Q3;
            4: Out <= Q4;
            5: Out <= Q5;
            default: Out <=32'bx;
        endcase  
    end
end

endmodule