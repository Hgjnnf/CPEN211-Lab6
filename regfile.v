module regfile(data_in, writenum, write, readnum, clk, data_out);
	input [15:0] data_in;
	input [2:0] writenum, readnum;
	input write, clk;
	output reg [15:0] data_out;
	
	reg [7:0] writenum_out, readnum_out;
	reg [15:0] R0, R1, R2, R3, R4, R5, R6, R7;
	
	
	//writenum decoder
	always@(*) begin
		writenum_out = 8'b0;
		case(writenum)
			3'b000: writenum_out[0] = 1'b1;
			3'b001: writenum_out[1] = 1'b1;
			3'b010: writenum_out[2] = 1'b1;
			3'b011: writenum_out[3] = 1'b1;
			3'b100: writenum_out[4] = 1'b1;
			3'b101: writenum_out[5] = 1'b1;
			3'b110: writenum_out[6] = 1'b1;
			3'b111: writenum_out[7] = 1'b1;
			default: writenum_out = 8'b0;
		endcase
	end
	
	//load register
	always@(posedge clk) begin
		if(write) begin
			case(writenum_out)
				8'b00000001: R0 = data_in;
				8'b00000010: R1 = data_in;
				8'b00000100: R2 = data_in;
				8'b00001000: R3 = data_in;
				8'b00010000: R4 = data_in;
				8'b00100000: R5 = data_in;
				8'b01000000: R6 = data_in;
				8'b10000000: R7 = data_in;
				default: {R0, R1, R2, R3, R4, R5, R6, R7} = {8'b0, 8'b0, 8'b0, 8'b0, 8'b0, 8'b0, 8'b0, 8'b0};
			endcase
		end
	end
	
	//readnum decoder
	always@(*) begin
		readnum_out = 8'b0;
		case(readnum)
			3'b000: readnum_out[0] = 1'b1;
			3'b001: readnum_out[1] = 1'b1;
			3'b010: readnum_out[2] = 1'b1;
			3'b011: readnum_out[3] = 1'b1;
			3'b100: readnum_out[4] = 1'b1;
			3'b101: readnum_out[5] = 1'b1;
			3'b110: readnum_out[6] = 1'b1;
			3'b111: readnum_out[7] = 1'b1;
			default: readnum_out = 8'b0;
		endcase
	end
	
	//data_out selector
	always@(*) begin
		case(readnum_out)
			8'b00000001: data_out = R0;
			8'b00000010: data_out = R1;
			8'b00000100: data_out = R2;
			8'b00001000: data_out = R3;
			8'b00010000: data_out = R4;
			8'b00100000: data_out = R5;
			8'b01000000: data_out = R6;
			8'b10000000: data_out = R7;
			default: data_out = 16'b0;
		endcase
	end
	
endmodule