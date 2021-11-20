module regfile_tb();
    //Inputs
    reg [15:0] SIM_data_in;
	reg [2:0] SIM_writenum, SIM_readnum;
	reg SIM_write, SIM_clk;
    //Outputs
	wire [15:0] SIM_data_out;
	
    //Internals
	reg [7:0] SIM_writenum_out, SIM_readnum_out;
	reg [15:0] SIM_r0, SIM_r1, SIM_r2, SIM_r3, SIM_r4, SIM_r5, SIM_r6, SIM_r7;
    reg err;

    //Module Instantiation
    regfile DUT(
        .data_in(SIM_data_in),
        .writenum(SIM_writenum),
        .write(SIM_write),
        .readnum(SIM_readnum),
        .clk(SIM_clk),
        .data_out(SIM_data_out)
        );
    
    initial begin
        //Initial Assignments
        err = 0;
        SIM_clk = 1'b0;
        SIM_data_in = 16'b0;
        SIM_write = 1'b0;
        #5;

        //Part 1: Writing to Register and Immediately Reading
        //Test Case #1: Writing 50984 to SIM_r1
        SIM_data_in = 16'b1100011100101000;
        SIM_writenum = 3'b001;
        SIM_write = 1'b1;
        #5;

        SIM_clk = 1'b1;
        #5;

        SIM_readnum = 3'b001;
        #5;

        if (regfile_tb.SIM_data_out == 16'b1100011100101000) $display("Test #1: PASS");
            else begin
                $display("Test #1: FAIL");
                err = 1'b1;
            end
        #5;


        //Test Case #2: Writing 21131 to SIM_r2
        SIM_clk = 1'b0;
        SIM_data_in = 16'b0;
        SIM_write = 1'b0;
        #5;

        SIM_data_in = 16'b0101001010001011;
        SIM_writenum = 3'b010;
        SIM_write = 1'b1;
        #5;

        SIM_clk = 1'b1;
        #5;

        SIM_readnum = 3'b010;
        #5;

        if (regfile_tb.SIM_data_out == 16'b0101001010001011) $display("Test #2: PASS");
            else begin
                $display("Test #2: FAIL");
                err = 1'b1;
            end
        #5;


        //Test Case #3: Writing 42 to SIM_r3
        SIM_clk = 1'b0;
        SIM_data_in = 16'b0;
        SIM_write = 1'b0;
        #5;

        SIM_data_in = 16'b0000000000101010;
        SIM_writenum = 3'b011;
        SIM_write = 1'b1;
        #5;

        SIM_clk = 1'b1;
        #5;

        SIM_readnum = 3'b011;
        #5;

        if (regfile_tb.SIM_data_out == 16'b0000000000101010) $display("Test #3: PASS");
            else begin
                $display("Test #3: FAIL");
                err = 1'b1;
            end
        #5;


        //Test Case #4: Writing 25126 to SIM_r4
        SIM_clk = 1'b0;
        SIM_data_in = 16'b0;
        SIM_write = 1'b0;
        #5;

        SIM_data_in = 16'b0110001000100110;
        SIM_writenum = 3'b100;
        SIM_write = 1'b1;
        #5;

        SIM_clk = 1'b1;
        #5;

        SIM_readnum = 3'b100;
        #5;

        if (regfile_tb.SIM_data_out == 16'b0110001000100110) $display("Test #4: PASS");
            else begin
                $display("Test #4: FAIL");
                err = 1'b1;
            end
        #5;


        //Test Case #5: Writing 42858 to SIM_r5
        SIM_clk = 1'b0;
        SIM_data_in = 16'b0;
        SIM_write = 1'b0;
        #5;

        SIM_data_in = 16'b1010011101101010;
        SIM_writenum = 3'b101;
        SIM_write = 1'b1;
        #5;

        SIM_clk = 1'b1;
        #5;

        SIM_readnum = 3'b101;
        #5;

        if (regfile_tb.SIM_data_out == 16'b1010011101101010) $display("Test #5: PASS");
            else begin
                $display("Test #5: FAIL");
                err = 1'b1;
            end
        #5;


        //Test Case #6: Writing 13760 to SIM_r6
        SIM_clk = 1'b0;
        SIM_data_in = 16'b0;
        SIM_write = 1'b0;
        #5;

        SIM_data_in = 16'b0011010111000000;
        SIM_writenum = 3'b110;
        SIM_write = 1'b1;
        #5;

        SIM_clk = 1'b1;
        #5;

        SIM_readnum = 3'b110;
        #5;

        if (regfile_tb.SIM_data_out == 16'b0011010111000000) $display("Test #6: PASS");
            else begin
                $display("Test #6: FAIL");
                err = 1'b1;
            end
        #5;


        //Test Case #7: Writing 3839 to SIM_r6
        SIM_clk = 1'b0;
        SIM_data_in = 16'b0;
        SIM_write = 1'b0;
        #5;

        SIM_data_in = 16'b0000111011111111;
        SIM_writenum = 3'b111;
        SIM_write = 1'b1;
        #5;

        SIM_clk = 1'b1;
        #5;

        SIM_readnum = 3'b111;
        #5;

        if (regfile_tb.SIM_data_out == 16'b0000111011111111) $display("Test #7: PASS");
            else begin
                $display("Test #7: FAIL");
                err = 1'b1;
            end
        #5;


        //Test Case #8: Writing 1 to SIM_r0
        SIM_clk = 1'b0;
        SIM_data_in = 16'b0;
        SIM_write = 1'b0;
        #5;

        SIM_data_in = 16'b0000000000000001;
        SIM_writenum = 3'b000;
        SIM_write = 1'b1;
        #5;

        SIM_clk = 1'b1;
        #5;

        SIM_readnum = 3'b000;
        #5;

        if (regfile_tb.SIM_data_out == 16'b0000000000000001) $display("Test #8: PASS");
            else begin
                $display("Test #8: FAIL");
                err = 1'b1;
            end
        #5;


        //Part 2: Writing to All Registers First and then Reading One-By-One
        //Resetting for Part 2
        SIM_clk = 1'b0;
        SIM_data_in = 16'b0;
        SIM_write = 1'b0;
        #5;

        //Test 9a: Writing 43562 to SIM_r1
        SIM_data_in = 16'b1010101000101010;
        SIM_writenum = 3'b001;
        SIM_write = 1'b1;
        #5;

        SIM_clk = 1'b1;
        #5;

        SIM_clk = 1'b0;
        #5;

        //Test 10a: Writing 11890 to SIM_r2
        SIM_data_in = 16'b0010111001110010;
        SIM_writenum = 3'b010;
        #5;

        SIM_clk = 1'b1;
        #5;

        SIM_clk = 1'b0;
        #5;

        //Test 11a: Writing 29492 to SIM_r3
        SIM_data_in = 16'b0111001100110100;
        SIM_writenum = 3'b011;
        #5;

        SIM_clk = 1'b1;
        #5;

        SIM_clk = 1'b0;
        #5;

        //Test 12a: Writing 64597 to SIM_r4
        SIM_data_in = 16'b1111110001010101;
        SIM_writenum = 3'b100;
        #5;

        SIM_clk = 1'b1;
        #5;

        SIM_clk = 1'b0;
        #5;

        //Test 13a: Writing 13683 to SIM_r5
        SIM_data_in = 16'b0011010101110011;
        SIM_writenum = 3'b101;
        #5;

        SIM_clk = 1'b1;
        #5;

        SIM_clk = 1'b0;
        #5;

        //Test 14a: Writing 37238 to SIM_r6
        SIM_data_in = 16'b1001000101110110;
        SIM_writenum = 3'b110;
        #5;

        SIM_clk = 1'b1;
        #5;

        SIM_clk = 1'b0;
        #5;

        //Test 15a: Writing 34063 to SIM_r7
        SIM_data_in = 16'b1000010100001111; 
        SIM_writenum = 3'b111;
        #5;

        SIM_clk = 1'b1;
        #5;

        SIM_clk = 1'b0;
        #5;

        //Test 16a: Writing 10826 to SIM_r0
        SIM_data_in = 16'b0010101001001010;
        SIM_writenum = 3'b000;
        #5;

        SIM_clk = 1'b1;
        #5;

        SIM_clk = 1'b0;
        #5;

        //Test Case #9b: Reading 43562 from SIM_r1
        SIM_readnum = 3'b001;
        #5;

        if (regfile_tb.SIM_data_out == 16'b1010101000101010) $display("Test #9: PASS");
            else begin
                $display("Test #9: FAIL");
                err = 1'b1;
            end
        #5;


        //Test Case #10b: Reading 11890 from SIM_r2      
        SIM_readnum = 3'b010;
        #5;

        if (regfile_tb.SIM_data_out == 16'b0010111001110010) $display("Test #10: PASS");
            else begin
                $display("Test #10: FAIL");
                err = 1'b1;
            end
        #5;


        //Test Case #11b: Reading 29492 from SIM_r3
        SIM_readnum = 3'b011;
        #5;

        if (regfile_tb.SIM_data_out == 16'b0111001100110100) $display("Test #11: PASS");
            else begin
                $display("Test #11: FAIL");
                err = 1'b1;
            end
        #5;


        //Test Case #12b: Reading 64597 from SIM_r4
        SIM_readnum = 3'b100;
        #5;

        if (regfile_tb.SIM_data_out == 16'b1111110001010101) $display("Test #12: PASS");
            else begin
                $display("Test #12: FAIL");
                err = 1'b1;
            end
        #5;


        //Test Case #13b: Reading 13683 from SIM_r5
        SIM_readnum = 3'b101;
        #5;

        if (regfile_tb.SIM_data_out == 16'b0011010101110011) $display("Test #13: PASS");
            else begin
                $display("Test #13: FAIL");
                err = 1'b1;
            end
        #5;


        //Test Case #14b: Reading 37238 from SIM_r6
        SIM_readnum = 3'b110;
        #5;

        if (regfile_tb.SIM_data_out == 16'b1001000101110110) $display("Test #14: PASS");
            else begin
                $display("Test #14: FAIL");
                err = 1'b1;
            end
        #5;


        //Test Case #15b: Reading 34063 from SIM_r6
        SIM_readnum = 3'b111;
        #5;

        if (regfile_tb.SIM_data_out == 16'b1000010100001111) $display("Test #15: PASS");
            else begin
                $display("Test #15: FAIL");
                err = 1'b1;
            end
        #5;


        //Test Case #16b: Reading 10826 from SIM_r0
        SIM_readnum = 3'b000;
        #5;

        if (regfile_tb.SIM_data_out == 16'b0010101001001010) $display("Test #16: PASS");
            else begin
                $display("Test #16: FAIL");
                err = 1'b1;
            end
        #5;
    $stop;
    end
endmodule
