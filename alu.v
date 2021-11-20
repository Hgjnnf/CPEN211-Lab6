module ALU(Ain, Bin, ALUop, out, Z);
	input [15:0] Ain, Bin;
	input [1:0] ALUop;
	output reg Z;
	output reg [15:0] out;
	
	always@(*) begin
		casex(ALUop)
			2'b00: out = Ain + Bin;
			2'b01: out = Ain - Bin;
			2'b10: out = Ain & Bin;
			2'b11: out = ~Bin;
			default: out = 16'bxxxxxxxxxxxxxxxx;
		endcase
		Z = (out == 16'b0) ? 1'b1 : 1'b0;
	end
endmodule
	