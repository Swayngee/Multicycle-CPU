 // Drake Gonzales
// drgonzales@g.hmc.edu
// Below is a helper top module connecting the datapath and controller
// 4/29/25
 
 module RISCVmulti(input  logic        clk, reset,
                   input  logic [31:0] ReadData,
                   output logic        MemWrite,
                   output logic [31:0] DataAdr, WriteData);

  logic       RegWrite, PCWrite, Zero, AdrSrc, IRWrite;
  logic [31:0] Instr;
  logic [1:0] ALUSrcA, ALUSrcB,ResultSrc, ImmSrc;
  logic [2:0] ALUControl;

  datapath dp(clk, reset, ResultSrc,
                ALUSrcA, ALUSrcB, PCWrite, AdrSrc, IRWrite,
                RegWrite, ImmSrc, ALUControl, ReadData, Zero,
                DataAdr, WriteData, Instr);
  controller con(clk, reset, Instr[6:0], Instr[14:12], Instr[30], Zero,
               ImmSrc, ALUSrcA, ALUSrcB, ResultSrc, AdrSrc, ALUControl, IRWrite,
               PCWrite, RegWrite, MemWrite);

endmodule