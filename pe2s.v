module pe2s #(parameter addr=4'b0000)(clk, enable, flit_in, grant, start, flit_out, source, gate, handshake_check);


input clk, enable;
input [31:0] flit_in;           //flit_in
input grant;                    //grant or not
output reg start;               //start "signal" block
output reg [31:0] flit_out;     //flit_out
output reg [3:0] source;        //source of flit
output reg [2:0] gate;          //gate of flit
output reg [1:0] handshake_check;   //0=body header tail, 1=seding handshake, 2=returing handshake


reg [31:0] temp;


always @(posedge clk) begin
    if(~enable) begin
        start <=0;
        flit_out <=0;
        gate <=0;
        handshake_check <=0;
    end
    else if(enable) begin
        // GATE
        source <= flit_in[29:26];
        if (flit_in[25:24] > addr[3:2]) // EAST  
                gate <= 3'b001;  
        else if (flit_in[25:24]< addr[3:2]) // WEST
                gate <= 3'b011;
        else if (flit_in[25:24]==addr[3:2])begin
            if( flit_in[23:22]> addr[1:0])     // NORTH
                    gate <= 3'b000;
            else if (flit_in[23:22]< addr[1:0]) //SOUTH
                    gate <= 3'b010;   
            else if( flit_in[23:22] == addr[1:0]) //PE                  
                    gate <= 3'b100;
            end     
        end
        
        // II. start, handshake_check
        //type flit = seding handshake
        if(flit_in[31:30] == 2'b11 && flit_in[21] == 1'b0) begin
            start<=1'b1;
            handshake_check <= 2'd1;
        end
        if( flit_in[31:30] == 2'b01  ) begin
            start <=1'b0;
            handshake_check <= 2'd1;   
                
        end
       
            

        // III. flit_out
        temp <= flit_in;
        if (grant == 1'b1 ) begin
            flit_out <= temp;
        end
        else 
            flit_out <= 32'b0;
 end
endmodule
