// Drake Gonzales
// drgonzales@g.hmc.edu
// Below is the ALU for our Multicycle CPU
// 4/29/25

module alu(input  logic [31:0] SrcA, SrcB,
            input  logic [2:0]  ALUControl,
            output logic [31:0] Result,
            output logic        Zero);

  logic [31:0] condinvb, sum;
  logic        sub;
 
  assign sub = (ALUControl[1:0] == 2'b01);
  assign condinvb = sub ? ~SrcB : SrcB; // for subtraction or slt
  assign sum = SrcA + condinvb + sub;

  always_comb
    case (ALUControl)
      3'b000: Result = sum;          // addition
      3'b001: Result = sum;          // subtraction
      3'b010: Result = SrcA & SrcB;        // and
      3'b011: Result = SrcA | SrcB;        // or
      3'b101: Result = sum[31];      // slt
      default: Result = 0;
  endcase
  assign Zero = (Result == 32'b0);
endmodule