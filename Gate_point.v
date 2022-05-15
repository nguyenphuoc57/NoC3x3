
module Gate_point#(parameter addr_sw=4'b0000, parameter stt = 3'd0 ) (
    input clk,
    input enable, grant,
    input [31:0]flit_in,
    output reg[31:0] flit_out,
    output reg [2:0] flit_gate,
  //  output [3:0] addr_temp, // For test
    output reg [3:0] source,
    output reg [3:0] src2in,
    output reg [1:0] handshake_check,
    output reg [1:0] Cx,Cy
    
    );
reg [31:0] save;
wire [3:0] temp;

assign temp =addr_sw;



always @(posedge clk) begin
    if(~enable) begin 
        src2in <= 4'hf; 
    end    
    else if (enable) begin 
          flit_out <= flit_in;
        // ADDRESS
        if(stt== 3'd0) begin//north
            Cy <= addr_sw[1:0] + 2'd1;
            Cx <= addr_sw[3:2];
        end    
        else if (stt== 3'd1) begin//east 
            Cx <= addr_sw[3:2] + 2'd1;
            Cy <= addr_sw[1:0];
        end    
        if(stt== 3'd2) begin//south
            Cy <= addr_sw[1:0] - 2'd1;
            Cx <= addr_sw [3:2];
        end    
        else if (stt== 3'd3) begin//west
            Cx <= addr_sw[3:2] - 2'd1;
            Cy <= addr_sw [1:0];
        end    
        else if (stt == 3'd4) begin
            Cx <= addr_sw [3:2];
            Cy <= addr_sw [1:0];
        end   
        
        ////// GATE AFFTER ADDRESS 
             
        if (flit_in[25:24] > Cx)  // EAST
            flit_gate <= 3'b001;
        else if (flit_in[25:24] < Cx) // WEST
            flit_gate <= 3'b011;
        else if (flit_in[25:24]==Cx)begin
            if( save[23:22]> Cy)     // NORTH
                flit_gate <= 3'b000;
            else if (flit_in[23:22] < Cy) //SOUTH
                flit_gate <= 3'b010;
            else if (flit_in[23:22]== Cy)  //PE
                flit_gate <= 3'b100;
         end         
         
            
              
     ///// TYPE
        //tail
        if(flit_in[31:30] == 2'b01) begin                    
            src2in <= 4'hf;

            source <= 4'hf;     // source default    
            handshake_check <= 2'd0;   
        end
        
        //header || body
        else if (flit_in[31:30] == 2'b10 || flit_in[31:30] == 2'b00) begin
            if(grant)
                src2in <= flit_in[29:26];
            else 
                src2in <= 4'hf;
            handshake_check <= 2'd0;
            source <= flit_in[29:26];
        end
        
        //handshake
        else if (flit_in[31:30] == 2'b11) begin  //return handshake same destination
            source <= flit_in[29:26]; 
//            if(grant & flit_in[29:26] == addr_sw & flit_in[25:22] != addr_sw)
//                src2in <= 4'hf;
//            else if(grant & flit_in[29:26] == addr_sw & flit_in[25:22] == addr_sw)
//                src2in <= flit_in[29:26];    
            if(grant & flit_in[21] != 1) 
                src2in <= flit_in[29:26];
            else  
                src2in <= 4'hf;
            if (flit_in[21]==0) begin               
                handshake_check <= 2'b01;                           
            end
            else if (flit_in[21]==1) begin  //return
                handshake_check <= 2'b10;             
            end
        
        end
       
        
        end

end
endmodule

