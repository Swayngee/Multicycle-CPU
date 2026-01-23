// Drake Gonzales
// drgonzales@g.hmc.edu
// Below is a the top module connecting all of our modules
// 4/29/25
module top_dg(input  logic   clk, reset,
           output logic [31:0] WriteData, DataAdr,
           output logic        MemWrite);

  logic [31:0] ReadData;
 
  // instantiate processor and memories
  MemUnit Memu(clk, MemWrite, DataAdr, WriteData, ReadData);
  RISCVmulti multi(clk, reset, ReadData, MemWrite, DataAdr,
                          WriteData);
endmodule