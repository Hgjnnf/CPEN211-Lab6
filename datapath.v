module datapath(clk,readnum,vsel,loada,loadb,shift,asel,bsel,ALUop,loadc,loads,writenum,write,mdata,PC,sximm5,sximm8,Z_out,datapath_out);
  //clk input
  input clk;
  //read,write addresses
  input [2:0] readnum, writenum;
  //operation selecters
  input [1:0] ALUop, shift;
  //selecter and load enable signals
  input write, loada, loadb, asel, bsel, loadc, loads;
  input [1:0] vsel;
  //data input
  input [15:0] sximm5, sximm8, mdata;
  input [7:0] PC;

  //outputs
  output [15:0] datapath_out;
  output [2:0] Z_out;

  //instantiation variables
  wire [15:0] data_out;
  wire [15:0] out;
  wire [15:0] sout;
  wire Z;
  wire [15:0] in;
  wire [15:0] in_loadA;
  wire [15:0] datapath_out;
  wire [2:0] Z_out;

  //additional mux variables
  reg [15:0] data_in;
  reg [15:0] Ain;
  reg [15:0] Bin;
  
  //module instantiations
  regfile REGFILE(.data_in(data_in),.writenum(writenum),.write(write),.readnum(readnum),.clk(clk),.data_out(data_out));
  ALU U2(.Ain(Ain),.Bin(Bin),.ALUop(ALUop),.out(out),.Z(Z));
  shifter U1(.in(in),.shift(shift),.sout(sout));

  //additional muxes
  always@(*)begin  //regfile input mux
    case(vsel)
      2'b00: data_in = datapath_out;
      2'b01: data_in = {8'b0, PC};
      2'b10: data_in = sximm8;
      2'b11: data_in = mdata;
      default: data_in = 16'b0;
    endcase
  end

  always@(*)begin
    if(asel == 1'b1) //asel for Ain
      Ain = 16'b0000000000000000;
    else
      Ain = in_loadA;
  end

  always@(*)begin
    if(bsel == 1'b1) //bsel for Bin
      Bin = sximm5;
    else
      Bin = sout;
  end

  //load enable registers A,B,C,STATUS
  vDFFE #(16) A(clk, loada, data_out, in_loadA);
  vDFFE #(16) B(clk, loadb, data_out, in);
  vDFFE #(16) C(clk, loadc, out, datapath_out);
  vDFFE #(3) STATUS(clk, loads, {(Ain[15]^Bin[15]) ? 0 : (out[15]^Ain[15]), out[15], Z}, Z_out);
  
endmodule
  
  
