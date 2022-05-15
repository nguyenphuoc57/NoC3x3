interface noc_io(input bit clock);
logic    reset, enable;
logic [31:0]   PE_00_in, 
               PE_01_in, 
               PE_02_in, 
               PE_10_in, 
               PE_11_in, 
               PE_12_in, 
               PE_20_in, 
               PE_21_in, 
               PE_22_in;
logic [31:0]   PE_00_out, 
                PE_01_out,
                PE_02_out,
                PE_10_out,
                PE_11_out,
                PE_12_out,
                PE_20_out,
                PE_21_out,
                PE_22_out ;

  clocking cb @(posedge clock);
output reset, enable;
output         PE_00_in, 
               PE_01_in, 
               PE_02_in, 
               PE_10_in, 
               PE_11_in, 
               PE_12_in, 
               PE_20_in, 
               PE_21_in, 
               PE_22_in;
input          PE_00_out, 
                PE_01_out,
                PE_02_out,
                PE_10_out,
                PE_11_out,
                PE_12_out,
                PE_20_out,
                PE_21_out,
                PE_22_out ;
  endclocking

  modport TB(clocking cb, output reset, output enable);
endinterface