`timescale 1ns / 100ps

module noc_test_top();
    parameter cycle = 10;
    bit clk;
//noc_io top_io (clk);
//test_program t(top_io);       // 1 port in to 1 port out
//noc_test1 t(top_io);            // 2 port in to same 1 port out
//noc_test2 t(top_io);             // 2 port in random to same 1 port out
Noc3x3 DUT (   .clk(top_io.clock), 
               .reset(top_io.reset), 
               .enable(top_io.enable),
               .PE_00_in(top_io.PE_00_in), 
               .PE_00_out(top_io.PE_00_out),
               .PE_01_in(top_io.PE_01_in), 
               .PE_01_out(top_io.PE_01_out),
               .PE_02_in(top_io.PE_02_in), 
               .PE_02_out(top_io.PE_02_out),
               .PE_10_in(top_io.PE_10_in), 
               .PE_10_out(top_io.PE_10_out),
               .PE_11_in(top_io.PE_11_in), 
               .PE_11_out(top_io.PE_11_out),
               .PE_12_in(top_io.PE_12_in), 
               .PE_12_out(top_io.PE_12_out),
               .PE_20_in(top_io.PE_20_in), 
               .PE_20_out(top_io.PE_20_out),
               .PE_21_in(top_io.PE_21_in), 
               .PE_21_out(top_io.PE_21_out),
               .PE_22_in(top_io.PE_22_in), 
               .PE_22_out(top_io.PE_22_out)
);

initial begin
    clk =0 ;
    forever #(cycle/2) clk = ~clk;
  
  end   
endmodule
