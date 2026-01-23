// Drake Gonzales
// drgonzales@g.hmc.edu
// Below is a helper mux module
// 4/29/25
module mux1 #(parameter WIDTH = 8)
             (input  logic [WIDTH-1:0] d0, d1,
              input  logic             s,
              output logic [WIDTH-1:0] y);

  assign y = s ? d1 : d0;
endmodule