// Drake Gonzales
// drgonzales@g.hmc.edu
// Below is the Memory Unit
// 4/29/25
module MemUnit(input  logic           clk,
               input  logic           MemWrite,    
               input  logic [31:0]    DataAdr,    
               input  logic [31:0]    WriteData,    
               output logic [31:0]    ReadData    
              );

logic [31:0] RAM[63:0];
initial
begin
$readmemh("memfile.dat", RAM);
end
assign ReadData = RAM[DataAdr[31:2]];

always_ff @(posedge clk)
if (MemWrite)
RAM[DataAdr[31:2]] <= WriteData;
 
endmodule