module datapath(clk,readnum,vsel,loada,loadb,shift,asel,bsel,ALUop,loadc,loads,writenum,write,datapath_in,Z_out,datapath_out);
  //clk input
  input clk;
  //read,write addresses
  input [2:0] readnum, writenum;
  //operation selecters
  input [1:0] ALUop, shift;
  //selecter and load enable signals
  input write, vsel, loada, loadb, asel, bsel, loadc, loads;
  //data input
  input [15:0] datapath_in; 

  //outputs
  output [15:0] datapath_out;
  output Z_out;

  //instantiation variables
  wire [15:0] data_out;
  wire [15:0] out;
  wire [15:0] sout;
  wire Z;
  wire [15:0] in;
  wire [15:0] in_loadA;
  wire [15:0] datapath_out;
  wire Z_out;

  //additional mux variables
  reg [15:0] data_in;
  reg [15:0] Ain;
  reg [15:0] Bin;
  
  //module instantiations
  regfile REGFILE(.data_in(data_in),.writenum(writenum),.write(write),.readnum(readnum),.clk(clk),.data_out(data_out));
  ALU U2(.Ain(Ain),.Bin(Bin),.ALUop(ALUop),.out(out),.Z(Z));
  shifter U1(.in(in),.shift(shift),.sout(sout));

  //additional muxes
  always@(*)begin  //writeback mux
    if(vsel == 1'b1)
      data_in = datapath_in;
    else
      data_in = datapath_out;
  end

  always@(*)begin
    if(asel == 1'b1) //asel for Ain
      Ain = 16'b0000000000000000;
    else
      Ain = in_loadA;
  end

  always@(*)begin
    if(bsel == 1'b1) //bsel for Bin
      Bin = {11'b00000000000,datapath_in[4:0]};
    else
      Bin = sout;
  end

  //load enable registers A,B,C,STATUS
  vDFFE #(16) A(clk, loada, data_out, in_loadA);
  vDFFE #(16) B(clk, loadb, data_out, in);
  vDFFE #(16) C(clk, loadc, out, datapath_out);
  vDFFE #(1) STATUS(clk, loads, Z, Z_out);
  
endmodule
  
  
