module vDFFE(clk, load, in, out);
  parameter n=1;
  input clk, load;
  input [n-1:0] in;
  output [n-1:0] out;
  reg [n-1:0] out;
  reg [n-1:0] vDFF_in;

  always@(*)
    vDFF_in = (load) ? in : out;

  always @(posedge clk)
    out = vDFF_in;

endmodule