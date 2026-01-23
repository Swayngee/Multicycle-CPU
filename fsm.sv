module fsm(input logic clk,
 input logic reset,
 input logic [6:0] op,
 output logic [1:0] ALUSrcA, ALUSrcB,
 output logic [1:0] ResultSrc,
 output logic [1:0] ALUop,
 output logic AdrSrc,
 output logic IRWrite,
 output logic PCUpdate, branch,
 output logic RegWrite, MemWrite);

 typedef enum logic [4:0] {s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11} statetype;
 statetype state, nextstate;
 // clock register

 always_ff @(posedge clk or posedge reset)
 if (reset) state <= s0;
 else state <= nextstate;
 
 // nextstate logic
always_comb begin
  nextstate = state;
  case (state)
    s0: nextstate = s1;
    s1: case (op)
          7'b0000011: nextstate = s2;
          7'b0100011: nextstate = s2;
          7'b0110011: nextstate = s6;
          7'b0010011: nextstate = s8;
          7'b1101111: nextstate = s9;
          7'b1100011: nextstate = s10;
			 7'b1100111: nextstate = s11; //Added
          default:    nextstate = s0;
        endcase
    s2: case (op)
          7'b0000011: nextstate = s3;
          7'b0100011: nextstate = s5;
          default:    nextstate = s0;
        endcase
    s3: nextstate = s4;
    s4: nextstate = s0;
    s5: nextstate = s0;
    s6: nextstate = s7;
    s7: nextstate = s0;
    s8: nextstate = s7;
    s9: nextstate = s7;
    s10: nextstate = s0;
	 s11: nextstate = s8; // Added
    default: nextstate = s0;
  endcase
end

// output logic
always_comb begin
  // Default values
  AdrSrc = 0;
  IRWrite = 0;
  ALUSrcA = 2'b00;
  ALUSrcB = 2'b00;
  ALUop = 2'b00;
  ResultSrc = 2'b00;
  PCUpdate = 0;
  branch = 0;
  RegWrite = 0;
  MemWrite = 0;

  case(state)
    s0: begin
      AdrSrc = 1'b0;
      IRWrite = 1'b1;
      ALUSrcA = 2'b00;
      ALUSrcB = 2'b10;
      ALUop = 2'b00;
      ResultSrc = 2'b10;
      PCUpdate = 1'b1;
    end
    s1: begin
      ALUSrcA = 2'b01;
      ALUSrcB = 2'b01;
      ALUop = 2'b00;
    end
    s2: begin
      ALUSrcA = 2'b10;
      ALUSrcB = 2'b01;
      ALUop = 2'b00;
    end
    s3: begin
      AdrSrc = 1'b1;
    end
    s4: begin
      ResultSrc = 2'b01;
      RegWrite = 1'b1;
    end
    s5: begin
      AdrSrc = 1'b1;
      MemWrite = 1'b1;
    end
    s6: begin
      ALUSrcA = 2'b10;
      ALUSrcB = 2'b00;
      ALUop = 2'b10;
    end
    s7: begin
      ResultSrc = 2'b00;
      RegWrite = 1'b1;
    end
    s8: begin
      ALUSrcA = 2'b10;
      ALUSrcB = 2'b01;
      ALUop = 2'b10;
    end
    s9: begin
      ALUSrcA = 2'b01;
      ALUSrcB = 2'b10;
      PCUpdate = 1'b1;
    end
    s10: begin
      ALUSrcA = 2'b10;
      ALUSrcB = 2'b00;
      ALUop = 2'b01;
      branch = 1'b1;
		end
	s11: begin  //Added
      ALUSrcA = 2'b01;
      ALUSrcB = 2'b10;
      PCUpdate = 1'b1;
    end
  endcase
end
endmodule