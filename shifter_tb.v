module shifter_tb();
    //Inputs
    reg [15:0] SIM_in;
    reg [1:0] SIM_shift;

    //Outputs
    wire [15:0] SIM_sout;

    //Signal
    reg err = 0;

    shifter DUT(
        .in(SIM_in),
        .shift(SIM_shift),
        .sout(SIM_sout)
    );

    initial begin
        //Test #1: SIM_sout takes the value of SIM_in (input = 5; output = 5)
        SIM_in = 16'b0000000000000101;
        SIM_shift = 2'b00;
        #5;

        if (SIM_sout == 16'b0000000000000101) $display("Test #1 - SIM_sout: PASS");
        else begin
            $display("Test #1 - SIM_sout: FAIL");
            err = 1'b1;
        end
        #5;

        //Test #2: SIM_sout takes the value of SIM_in, shifted 1-bit left (input = 42069; output = 18602)
        SIM_in = 16'b1010010001010101;
        SIM_shift = 2'b01;
        #5;

        if (SIM_sout == 16'b0100100010101010) $display("Test #2 - SIM_sout: PASS");
        else begin
            $display("Test #2 - SIM_sout: FAIL");
            err = 1'b1;
        end
        #5;

        //Test #3: SIM_sout takes the value of SIM_in, shifted 1-bit right (input = 5001; output = 2500)
        SIM_in = 16'b0001001110001001;
        SIM_shift = 2'b10;
        #5;

        if (SIM_sout == 16'b0000100111000100) $display("Test #3 - SIM_sout: PASS");
        else begin
            $display("Test #3 - SIM_sout: FAIL");
            err = 1'b1;
        end
        #5;

        //Test #4: SIM_sout takes the value of SIM_in, shifted 1-bit right, MSB is B[15] (input = 99; output = 2500)
        SIM_in = 16'b0000000001100011;
        SIM_shift = 2'b11;
        #5;

        if (SIM_sout == 16'b0000000000110001) $display("Test #4 - SIM_sout: PASS");
        else begin
            $display("Test #4 - SIM_sout: FAIL");
            err = 1'b1;
        end
        #5;

        //Test #5: SIM_sout takes the value of SIM_in (input = 42727; output = 42727)
        SIM_in = 16'b1010011011100111;
        SIM_shift = 2'b00;
        #5;

        if (SIM_sout == 16'b1010011011100111) $display("Test #5 - SIM_sout: PASS");
        else begin
            $display("Test #5 - SIM_sout: FAIL");
            err = 1'b1;
        end
        #5;

        //Test #6: SIM_sout takes the value of SIM_in, shifted 1-bit left (input = 580; output = 1160)
        SIM_in = 16'b0000001001000100;
        SIM_shift = 2'b01;
        #5;

        if (SIM_sout == 16'b0000010010001000) $display("Test #6 - SIM_sout: PASS");
        else begin
            $display("Test #6 - SIM_sout: FAIL");
            err = 1'b1;
        end
        #5;

        //Test #7: SIM_sout takes the value of SIM_in, shifted 1-bit right (input = 31044; output = 15522)
        SIM_in = 16'b0111100101000100;
        SIM_shift = 2'b10;
        #5;

        if (SIM_sout == 16'b0011110010100010) $display("Test #7 - SIM_sout: PASS");
        else begin
            $display("Test #7 - SIM_sout: FAIL");
            err = 1'b1;
        end
        #5;

        //Test #8: SIM_sout takes the value of SIM_in, shifted 1-bit right, MSB is B[15] (input = 21845; output = 10922)
        SIM_in = 16'b0101010101010101;
        SIM_shift = 2'b11;
        #5;

        if (SIM_sout == 16'b0010101010101010) $display("Test #8 - SIM_sout: PASS");
        else begin
            $display("Test #8 - SIM_sout: FAIL");
            err = 1'b1;
        end
        #5;

        //Test #9: SIM_sout takes the value of SIM_in, shifted 1-bit right, MSB is B[15] (input = 33039; output = 49287)
        SIM_in = 16'b1000000100001111;
        SIM_shift = 2'b11;
        #5;

        if (SIM_sout == 16'b1100000010000111) $display("Test #9 - SIM_sout: PASS");
        else begin
            $display("Test #9 - SIM_sout: FAIL");
            err = 1'b1;
        end
        #5;

        $stop;
    end
endmodule
