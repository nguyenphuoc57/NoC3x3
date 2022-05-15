module FSM( flit_in_IP, enable,flit_in_sw, state, ready,accept,clk, flit_out_IP, flit_out_sw);
input clk, enable;
input [31:0] flit_in_IP, flit_out_sw;
output reg [1:0] state;
output reg ready,accept;
output reg [31:0] flit_out_IP, flit_in_sw;
parameter S0=2'd0,
          S1= 2'd1,
          S2=2'd2,
          S3=2'd3; 
reg [1:0] current, next;
always @(posedge clk) begin
    current <= next;
end

always @(flit_in_IP or flit_out_sw or enable) begin
    case(current)
    
    //wait state
    S0: begin
        ready = 1'b1;
        accept = flit_out_sw[20];
        state= 2'd0;
        flit_out_IP = flit_out_sw;
        flit_in_sw = flit_in_IP;
        
       if(flit_in_IP[31:30] == 2'b11) //handshake
            next=S1;
        else 
            next=S0;    
    end
    
    //sending state
    S1: begin
        ready = 1'd0;
        state=2'd1;   
        accept = 0;       
        flit_out_IP = flit_out_sw;
        flit_in_sw = 32'dx;
        if(flit_out_sw[31:30] ==2'b11) begin
            next=S0;
            accept=flit_out_sw[21];
        end    
        else 
            next=S1;
    end 
    default: next=S0;
    endcase 
end 
endmodule
