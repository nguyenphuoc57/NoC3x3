module counter #(parameter NUM=0) (clk, reset,enable,timeout );

input clk, reset, enable;
reg [9:0] count_current;
output reg timeout;
always @(posedge clk) begin
    if(!reset) begin
        count_current <=10'd0;
        timeout <=1'd0;
    end 
    else if(enable) begin
        if(count_current <NUM) begin
            count_current <= count_current+ 1'd1;
        end 
        else if (count_current >=NUM)
            timeout <=1'd1;
     end       
end 
endmodule
