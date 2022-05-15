module signal(clk, enable, result,start, finish,accept, ready);

input clk, enable, result;
input start, finish;
output reg ready,accept;
//output timeout;

always @(posedge clk) begin
    if (~enable) begin
        ready <= 1;
        accept <=0;
    end
    else if (enable) begin
        if(start == 0 && finish == 0)  begin
            ready <= 1'b1;
            accept <= 1'b0;
        end
        if(start == 1 && finish == 0) begin
            ready <= 1'b0;
            accept <= result;
        end 
        if (start == 0 && finish == 1) begin     //khong xay ra
            ready <= 1'b1;  
            accept <= 0;
        end
        if (start == 1 && finish == 1) begin
            ready <= 1'b1;
            accept <= result;
        end
          
    end 
end 
endmodule
