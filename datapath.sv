// Drake Gonzales
// drgonzales@g.hmc.edu
// Below is the complete datapath for our processor
// 4/29/25
module datapath(input  logic        clk, reset,
                input  logic [1:0]  ResultSrc, ALUSrcA, ALUSrcB,
                input  logic        PCWrite, AdrSrc,
                input logic         IRWrite,
                input  logic        RegWrite,
                input  logic [1:0]  ImmSrc,
                input  logic [2:0]  ALUControl,
input  logic [31:0] ReadData,
                output logic        Zero,
                output logic [31:0] DataAdr, WriteData,
output logic [31:0] Instr);

  logic [31:0] PC;
  logic [31:0] ImmExt;
  logic [31:0] SrcA, SrcB;
  logic [31:0] Result;
  logic [31:0] A;
  logic [31:0] OldPC;
  logic [31:0] Data;
  logic [31:0] RD1, RD2;
  logic [31:0] ALUResult;
  logic [31:0] ALUOut ;
 

  // next PC logic
  flopr1 #(32) firstflop(clk, reset, PCWrite, Result, PC);
  mux1 #(32)  pcmux(PC, Result, AdrSrc, DataAdr);
  flopr2 #(32) flopr_oldpc(clk, reset, IRWrite, PC, OldPC);
  flopr2 #(32) flopr_instr(clk, reset, IRWrite, ReadData, Instr);
//Next clock
  flopr3 #(32) Rdclock(clk, reset, ReadData, Data);
 
  // register file logic
  RegFile     rf(clk, RegWrite, Instr[19:15], Instr[24:20],
                 Instr[11:7], Result, RD1, RD2);
  Extend      ext(Instr[31:7], ImmSrc, ImmExt);
  flopr4 #(32) fourthfloptop(clk, reset, RD1, A);
  flopr4 #(32) fourthflopbottomr(clk, reset, RD2, WriteData);
  // ALUlogic
  mux2 #(32)  SrcAmux(PC, OldPC, A, ALUSrcA, SrcA);
  mux3 #(32)  SrcBmux(WriteData, ImmExt, 32'd4, ALUSrcB, SrcB);
  alu        alU(SrcA, SrcB, ALUControl, ALUResult, Zero);
  flopr5 #(32) lastflop(clk, reset, ALUResult, ALUOut);
  mux4 #(32)  Resultmux(ALUOut, Data, ALUResult, ResultSrc, Result);
endmodule