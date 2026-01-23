// Drake Gonzales
// drgonzales@g.hmc.edu
// Below is the controller top module
// 4/29/25

module controller(input logic clk,
 input logic reset,
 input logic [6:0] op,
 input logic [2:0] funct3,
 input logic funct7b5,
 input logic Zero,
 output logic [1:0] ImmSrc,
 output logic [1:0] ALUSrcA, ALUSrcB,
 output logic [1:0] ResultSrc,
 output logic AdrSrc,
 output logic [2:0] ALUControl,
 output logic IRWrite, PCWrite,
 output logic RegWrite, MemWrite);
 
 logic PCUpdate, branch;
 logic [1:0] ALUop;

  fsm f1(clk, reset, op, ALUSrcA, ALUSrcB, ResultSrc, ALUop, AdrSrc, IRWrite, PCUpdate, branch, RegWrite, MemWrite);
  ALUDecoder a1(ALUop, funct3, funct7b5, op[5], ALUControl);
  InstrDecoder f3(op, ImmSrc);
  logic a0;
  and f4(a0, branch, Zero);
  or f5(PCWrite, a0, PCUpdate);
endmodule
