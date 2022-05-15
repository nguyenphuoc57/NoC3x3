module SA_mini(clk,

                RC0_flit,RC1_flit,VC0_gate,VC1_gate, VC0_type, VC1_type, VC0_stop, VC1_stop,SA_flit,SA_gate);

input clk;
//input reset;
input [2:0] VC0_gate,VC1_gate;
input [31:0] RC0_flit,RC1_flit;
input [1:0] VC0_type, VC1_type;
output reg VC0_stop, VC1_stop;
  

output reg [31:0] SA_flit;
output reg [2:0] SA_gate;
always @(negedge clk) begin
      if (VC0_type == VC1_type) begin
       // SA_Choose = 1'b0;
        VC0_stop=0;
        VC1_stop=1;
        //flat=4'd1;
        SA_flit = RC0_flit;
        SA_gate=VC0_gate;
       end 
       else if (VC0_type[1] == 0) begin
       // SA_Choose = 1'b0;
        VC0_stop = 0;
        VC1_stop=1;
       // flat=4'd2;
        SA_flit = RC0_flit;
        SA_gate=VC0_gate;
       end
       else if (VC1_type[1] == 0 )begin
       // SA_Choose = 1'b1;
        VC0_stop = 1;
        VC1_stop=0;
       // flat=4'd3;
        SA_flit = RC1_flit;
        SA_gate=VC1_gate;
       end
       
     else if (VC0_type != 2'b0 ) begin
      //  SA_Choose = 1'b0;
        VC0_stop = 0;
        VC1_stop=1;
       // flat=4'd4;
        SA_flit = RC0_flit;
        SA_gate=VC0_gate;
    end
    else if (VC1_type != 2'b0  ) begin
       // SA_Choose = 1'b1;
        VC0_stop = 1;
        VC1_stop=0;
        //flat=4'd5;
        SA_flit = RC1_flit;
        SA_gate=VC1_gate;
        end
       else begin
      //  SA_Choose = 1'bx;
        VC0_stop = 0;
        VC1_stop=0;
       // flat=4'd6;
        SA_flit = 32'bx;
        SA_gate=3'bx;
        end
end 
always @(posedge clk) begin
    if(RC0_flit == SA_flit)
        $display("SA_10_OK");
end
endmodule
