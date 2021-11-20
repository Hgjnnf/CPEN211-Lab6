module ALU_tb();
    //Inputs
    reg [15:0] SIM_Ain, SIM_Bin;
	reg [1:0] SIM_ALUop;

    //Outputs
    wire [15:0] SIM_out;
	wire SIM_Z;

    //Signal
    reg err = 0;

    ALU DUT(
        .Ain(SIM_Ain),
        .Bin(SIM_Bin),
        .ALUop(SIM_ALUop),
        .out(SIM_out),
        .Z(SIM_Z)
    );

    initial begin
        //Test 1: 3602 + 28420 = 32022
        SIM_Ain = 16'b0000111000010010;
        SIM_Bin = 16'b0110111100000100;
        SIM_ALUop = 2'b00;
        #5;

        if (ALU_tb.SIM_out == 16'b0111110100010110) $display("Test #1 - SIM_out: PASS");
            else begin
                $display("Test #1 - SIM_out: FAIL");
                err = 1'b1;
            end

        if (ALU_tb.SIM_Z == 1'b0) $display("Test #1 - SIM_Z: PASS");
            else begin
                $display("Test #1 - SIM_Z: FAIL");
                err = 1'b1;
            end
        #5;

        //Test 2: 5 - 2 = 3
        SIM_Ain = 16'b0000000000000101;
        SIM_Bin = 16'b0000000000000010;
        SIM_ALUop = 2'b01;
        #5;

        if (ALU_tb.SIM_out == 16'b0000000000000011) $display("Test #2 - SIM_out: PASS");
            else begin
                $display("Test #2 - SIM_out: FAIL");
                err = 1'b1;
            end

        if (ALU_tb.SIM_Z == 1'b0) $display("Test #2 - SIM_Z: PASS");
            else begin
                $display("Test #2 - SIM_Z: FAIL");
                err = 1'b1;
            end
        #5;

        //Test 3: 43690 & 21845 = 0
        SIM_Ain = 16'b1010101010101010;
        SIM_Bin = 16'b0101010101010101;
        SIM_ALUop = 2'b10;
        #5;

        if (ALU_tb.SIM_out == 16'b0000000000000000) $display("Test #3 - SIM_out: PASS");
            else begin
                $display("Test #3 - SIM_out: FAIL");
                err = 1'b1;
            end

        if (ALU_tb.SIM_Z == 1'b1) $display("Test #3 - SIM_Z: PASS");
            else begin
                $display("Test #3 - SIM_Z: FAIL");
                err = 1'b1;
            end
        #5;

        //Test 4: ~3792 = 61743
        SIM_Bin = 16'b0000111011010000;
        SIM_ALUop = 2'b11;
        #5;

        if (ALU_tb.SIM_out == 16'b1111000100101111) $display("Test #4 - SIM_out: PASS");
            else begin
                $display("Test #4 - SIM_out: FAIL");
                err = 1'b1;
            end

        if (ALU_tb.SIM_Z == 1'b0) $display("Test #4 - SIM_Z: PASS");
            else begin
                $display("Test #4 - SIM_Z: FAIL");
                err = 1'b1;
            end
        #5;

        //Test 5: 4648 + 48329 = 52977
        SIM_Ain = 16'b0001001000101000;
        SIM_Bin = 16'b1011110011001001;
        SIM_ALUop = 2'b00;
        #5;

        if (ALU_tb.SIM_out == 16'b1100111011110001) $display("Test #5 - SIM_out: PASS");
            else begin
                $display("Test #5 - SIM_out: FAIL");
                err = 1'b1;
            end

        if (ALU_tb.SIM_Z == 1'b0) $display("Test #5 - SIM_Z: PASS");
            else begin
                $display("Test #5 - SIM_Z: FAIL");
                err = 1'b1;
            end
        #5;

        //Test 6: 463 - 463 = 0
        SIM_Ain = 16'b0000000111001111;
        SIM_Bin = 16'b0000000111001111;
        SIM_ALUop = 2'b01;
        #5;

        if (ALU_tb.SIM_out == 16'b0000000000000000) $display("Test #6 - SIM_out: PASS");
            else begin
                $display("Test #6 - SIM_out: FAIL");
                err = 1'b1;
            end

        if (ALU_tb.SIM_Z == 1'b1) $display("Test #6 - SIM_Z: PASS");
            else begin
                $display("Test #6 - SIM_Z: FAIL");
                err = 1'b1;
            end
        #5;

        //Test 7: 52084 & 13976 = 528
        SIM_Ain = 16'b1100101101110100;
        SIM_Bin = 16'b0011011010011000;
        SIM_ALUop = 2'b10;
        #5;

        if (ALU_tb.SIM_out == 16'b0000001000010000) $display("Test #7 - SIM_out: PASS");
            else begin
                $display("Test #7 - SIM_out: FAIL");
                err = 1'b1;
            end

        if (ALU_tb.SIM_Z == 1'b0) $display("Test #7 - SIM_Z: PASS");
            else begin
                $display("Test #7 - SIM_Z: FAIL");
                err = 1'b1;
            end
        #5;

        //Test 8: ~65535 = 0
        SIM_Bin = 16'b1111111111111111;
        SIM_ALUop = 2'b11;
        #5;

        if (ALU_tb.SIM_out == 16'b0000000000000000) $display("Test #8 - SIM_out: PASS");
            else begin
                $display("Test #8 - SIM_out: FAIL");
                err = 1'b1;
            end

        if (ALU_tb.SIM_Z == 1'b1) $display("Test #8 - SIM_Z: PASS");
            else begin
                $display("Test #8 - SIM_Z: FAIL");
                err = 1'b1;
            end
        #5;

        //Test 9: Select Multiple Operations Before 36838 + 373 = 37211
        SIM_Ain = 16'b1000111111100110;
        SIM_Bin = 16'b0000000101110101;
        SIM_ALUop = 2'b01;
        #5;
        SIM_ALUop = 2'b10;
        #5;
        SIM_ALUop = 2'b00;
        #5;

        if (ALU_tb.SIM_out == 16'b1001000101011011) $display("Test #9 - SIM_out: PASS");
            else begin
                $display("Test #9 - SIM_out: FAIL");
                err = 1'b1;
            end

        if (ALU_tb.SIM_Z == 1'b0) $display("Test #9 - SIM_Z: PASS");
            else begin
                $display("Test #9 - SIM_Z: FAIL");
                err = 1'b1;
            end
        #5;

        //Test 10: Select Multiple Operations Before 1 + 1 = 2
        SIM_Ain = 16'b0000000000000001;
        SIM_Bin = 16'b0000000000000001;
        SIM_ALUop = 2'b00;
        #5;
        SIM_ALUop = 2'b11;
        #5;
        SIM_ALUop = 2'b10;
        #5;
        SIM_ALUop = 2'b00;
        #5;

        if (ALU_tb.SIM_out == 16'b0000000000000010) $display("Test #10 - SIM_out: PASS");
            else begin
                $display("Test #10 - SIM_out: FAIL");
                err = 1'b1;
            end

        if (ALU_tb.SIM_Z == 1'b0) $display("Test #10 - SIM_Z: PASS");
            else begin
                $display("Test #10 - SIM_Z: FAIL");
                err = 1'b1;
            end
        #5;

        //Test 11: 463 - 4630 = -4167
        SIM_Ain = 16'b0000000111001111;
        SIM_Bin = 16'b0001001000010110;
        SIM_ALUop = 2'b01;
        #5;

        if (ALU_tb.SIM_out == 16'b1110111110111001) $display("Test #11 - SIM_out: PASS");
            else begin
                $display("Test #11 - SIM_out: FAIL");
                err = 1'b1;
            end

        if (ALU_tb.SIM_Z == 1'b0) $display("Test #11 - SIM_Z: PASS");
            else begin
                $display("Test #11 - SIM_Z: FAIL");
                err = 1'b1;
            end
        #5;

        //Test 12: 100 - 32868 = -32768 (the Most Negative Number that can be Displayed Using 16-bits)
        SIM_Ain = 16'b0000000001100100;
        SIM_Bin = 16'b1000000001100100;
        SIM_ALUop = 2'b01;
        #5;

        if (ALU_tb.SIM_out == 16'b1000000000000000) $display("Test #12 - SIM_out: PASS");
            else begin
                $display("Test #12 - SIM_out: FAIL");
                err = 1'b1;
            end

        if (ALU_tb.SIM_Z == 1'b0) $display("Test #12 - SIM_Z: PASS");
            else begin
                $display("Test #12 - SIM_Z: FAIL");
                err = 1'b1;
            end
        #5;
        $stop;
    end
endmodule