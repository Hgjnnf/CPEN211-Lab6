module cpu_tb ();
    reg SIM_clk, SIM_reset, SIM_s, SIM_load;
    reg [15:0] SIM_in;
    wire [15:0] SIM_out;
    wire SIM_N, SIM_V, SIM_Z, SIM_w;

    reg err;

    cpu DUT(SIM_clk, SIM_reset, SIM_s, SIM_load, SIM_in, SIM_out, SIM_N, SIM_V, SIM_Z, SIM_w);

    initial begin
        SIM_clk = 0; #5;
        forever begin
        SIM_clk = 1; #5;
        SIM_clk = 0; #5;
        end
    end

    initial begin
        //Initializations
        err = 0;
        SIM_reset = 1; SIM_s = 0; SIM_load = 0; SIM_in = 16'b0;
        #10;
        SIM_reset = 0; 
        #10;

        //Test #1: MOV R1, #70
        SIM_in = 16'b1101000101000110;
        SIM_load = 1;
        #10;
        SIM_load = 0;
        SIM_s = 1;
        #10
        SIM_s = 0;
        @(posedge SIM_w); // wait for w to go high again
        #10;
        if (cpu_tb.DUT.DP.REGFILE.R1 !== 16'd70) begin
        err = 1;
        $display("FAILED TEST #1: MOV R1, #70");
        $stop;
        end

        //Test #2: MOV R2, #2
        SIM_in = 16'b1101001000000010;
        SIM_load = 1;
        #10;
        SIM_load = 0;
        SIM_s = 1;
        #10
        SIM_s = 0;
        @(posedge SIM_w); // wait for w to go high again
        #10;
        if (cpu_tb.DUT.DP.REGFILE.R2 !== 16'd2) begin
        err = 1;
        $display("FAILED TEST #2: MOV R2, #2");
        $stop;
        end

        //Test #3: MOV R3, #8
        SIM_in = 16'b1101001100001000;
        SIM_load = 1;
        #10;
        SIM_load = 0;
        SIM_s = 1;
        #10
        SIM_s = 0;
        @(posedge SIM_w); // wait for w to go high again
        #10;
        if (cpu_tb.DUT.DP.REGFILE.R3 !== 16'd8) begin
        err = 1;
        $display("FAILED TEST #3: MOV R3, #8");
        $stop;
        end

        //Test #4: MOV R4, #21
        SIM_in = 16'b1101010000010101;
        SIM_load = 1;
        #10;
        SIM_load = 0;
        SIM_s = 1;
        #10
        SIM_s = 0;
        @(posedge SIM_w); // wait for w to go high again
        #10;
        if (cpu_tb.DUT.DP.REGFILE.R4 !== 16'd21) begin
        err = 1;
        $display("FAILED TEST #4: MOV R4, #21");
        $stop;
        end

        //Test #5: MOV R5, #-30
        SIM_in = 16'b1101010111100010;
        SIM_load = 1;
        #10;
        SIM_load = 0;
        SIM_s = 1;
        #10
        SIM_s = 0;
        @(posedge SIM_w); // wait for w to go high again
        #10;
        if (cpu_tb.DUT.DP.REGFILE.R5 !== -16'd30) begin
        err = 1;
        $display("FAILED TEST #5a: MOV R5, #-30");
        $stop;
        end
        if (cpu_tb.DUT.N !== 1'd0) begin
        err = 1;
        $display("FAILED TEST #5b: Negative Integer NOT Detected");
        $stop;
        end
        if (cpu_tb.DUT.V !== 1'd0) begin
        err = 1;
        $display("FAILED TEST #5c: Overflow NOT Detected");
        $stop;
        end

        //Test #6: MOV R6, #0
        SIM_in = 16'b1101011000000000;
        SIM_load = 1;
        #10;
        SIM_load = 0;
        SIM_s = 1;
        #10
        SIM_s = 0;
        @(posedge SIM_w); // wait for w to go high again
        #10;
        if (cpu_tb.DUT.DP.REGFILE.R6 !== 16'd0) begin
        err = 1;
        $display("FAILED TEST #6: MOV R6, #0");
        $stop;
        end

        //Test #7: MOV R7, #100
        SIM_in = 16'b1101011101100100;
        SIM_load = 1;
        #10;
        SIM_load = 0;
        SIM_s = 1;
        #10
        SIM_s = 0;
        @(posedge SIM_w); // wait for w to go high again
        #10;
        if (cpu_tb.DUT.DP.REGFILE.R7 !== 16'd100) begin
        err = 1;
        $display("FAILED TEST #7: MOV R7, #100");
        $stop;
        end

        //Test #8: MOV R0, #10
        SIM_in = 16'b1101000000001010;
        SIM_load = 1;
        #10;
        SIM_load = 0;
        SIM_s = 1;
        #10
        SIM_s = 0;
        @(posedge SIM_w); // wait for w to go high again
        #10;
        if (cpu_tb.DUT.DP.REGFILE.R0 !== 16'd10) begin
        err = 1;
        $display("FAILED TEST #8: MOV R0, #10");
        $stop;
        end

        //Test #9: MOV R1, R0, LSL#1 (R1 Should Equal 20)
        SIM_in = 16'b1100000000101000;
        SIM_load = 1;
        #10;
        SIM_load = 0;
        SIM_s = 1;
        #10
        SIM_s = 0;
        @(posedge SIM_w); // wait for w to go high again
        #10;
        if (cpu_tb.DUT.DP.REGFILE.R1 !== 16'd20) begin
        err = 1;
        $display("FAILED TEST #9: MOV R1, R0, LSL#1");
        $stop;
        end
        

        //Test #10: MOV R5, R3, LSR#1 (R5 Should Equal 4)
        SIM_in = 16'b1100000010110011;
        SIM_load = 1;
        #10;
        SIM_load = 0;
        SIM_s = 1;
        #10
        SIM_s = 0;
        @(posedge SIM_w); // wait for w to go high again
        #10;
        if (cpu_tb.DUT.DP.REGFILE.R5 !== 16'd4) begin
        err = 1;
        $display("FAILED TEST #10: MOV R5, R3, LSR#1");
        $stop;
        end

        //Test 11: ADD R2, R1, R5 (R2 Should Equal 24)
        SIM_in = 16'b1010000101000101;
        SIM_load = 1;
        #10;
        SIM_load = 0;
        SIM_s = 1;
        #10
        SIM_s = 0;
        @(posedge SIM_w); // wait for w to go high again
        #10;
        if (cpu_tb.DUT.DP.REGFILE.R2 !== 16'd24) begin
        err = 1;
        $display("FAILED TEST #11: ADD R2, R1, R5");
        $stop;
        end

        //Test 12: ADD R6, R7, R0 (R6 Should Equal 110)
        SIM_in = 16'b1010011111000000;
        SIM_load = 1;
        #10;
        SIM_load = 0;
        SIM_s = 1;
        #10
        SIM_s = 0;
        @(posedge SIM_w); // wait for w to go high again
        #10;
        if (cpu_tb.DUT.DP.REGFILE.R6 !== 16'd110) begin
        err = 1;
        $display("FAILED TEST #12: ADD R6, R7, R0");
        $stop;
        end

        //Test 13: ADD R3, R5, R6, LSR#1 (R3 Should Equal 59)
        SIM_in = 16'b1010010101110110;
        SIM_load = 1;
        #10;
        SIM_load = 0;
        SIM_s = 1;
        #10
        SIM_s = 0;
        @(posedge SIM_w); // wait for w to go high again
        #10;
        if (cpu_tb.DUT.DP.REGFILE.R3 !== 16'd59) begin
        err = 1;
        $display("FAILED TEST #13: ADD R3, R5, R6, LSR#1");
        $stop;
        end

        //Test 14: CMP R0, R1, LSR#1 (R0 Should Equal R1/2)
        SIM_in = 16'b1010100000010001;
        SIM_load = 1;
        #10;
        SIM_load = 0;
        SIM_s = 1;
        #10
        SIM_s = 0;
        @(posedge SIM_w); // wait for w to go high again
        #10;
        if (cpu_tb.DUT.Z !== 1'd1) begin
        err = 1;
        $display("FAILED TEST #14: CMP R0, R1, LSR#1");
        $stop;
        end

        //Test 15: CMP R0, R0 (R0 Should Equal R0)
        SIM_in = 16'b1010100000000000;
        SIM_load = 1;
        #10;
        SIM_load = 0;
        SIM_s = 1;
        #10
        SIM_s = 0;
        @(posedge SIM_w); // wait for w to go high again
        #10;
        if (cpu_tb.DUT.Z !== 1'd1) begin
        err = 1;
        $display("FAILED TEST #15: CMP R0, R0");
        $stop;
        end

        //Test #16: MOV R2, #-10
        SIM_in = 16'b1101001011110110;
        SIM_load = 1;
        #10;
        SIM_load = 0;
        SIM_s = 1;
        #10
        SIM_s = 0;
        @(posedge SIM_w); // wait for w to go high again
        #10;
        if (cpu_tb.DUT.DP.REGFILE.R2 !== -16'd10) begin
        err = 1;
        $display("FAILED TEST #16a: MOV R2, #-31");
        $stop;
        end
        if (cpu_tb.DUT.N !== 1'd0) begin
        err = 1;
        $display("FAILED TEST #16b: Negative Integer NOT Detected");
        $stop;
        end
        if (cpu_tb.DUT.V !== 1'd0) begin
        err = 1;
        $display("FAILED TEST #16c: Overflow NOT Detected");
        $stop;
        end

        //Test #17: MOV R3, #-10
        SIM_in = 16'b1101001111110110;
        SIM_load = 1;
        #10;
        SIM_load = 0;
        SIM_s = 1;
        #10
        SIM_s = 0;
        @(posedge SIM_w); // wait for w to go high again
        #10;
        if (cpu_tb.DUT.DP.REGFILE.R3 !== -16'd10) begin
        err = 1;
        $display("FAILED TEST #17a: MOV R2, #-31");
        $stop;
        end
        if (cpu_tb.DUT.N !== 1'd0) begin
        err = 1;
        $display("FAILED TEST #17b: Negative Integer NOT Detected");
        $stop;
        end
        if (cpu_tb.DUT.V !== 1'd0) begin
        err = 1;
        $display("FAILED TEST #17c: Overflow NOT Detected");
        $stop;
        end

        //Test 18: CMP R2, R3
        SIM_in = 16'b1010101000000011;
        SIM_load = 1;
        #10;
        SIM_load = 0;
        SIM_s = 1;
        #10
        SIM_s = 0;
        @(posedge SIM_w); // wait for w to go high again
        #10;
        if (cpu_tb.DUT.Z !== 1'd1) begin
        err = 1;
        $display("FAILED TEST #18a: CMP R2, R3");
        $stop;
        end
        if (cpu_tb.DUT.N !== 1'd0) begin
        err = 1;
        $display("FAILED TEST #18b: CMP R2, R3");
        $stop;
        end
        if (cpu_tb.DUT.V !== 1'd0) begin
        err = 1;
        $display("FAILED TEST #18c: CMP R2, R3");
        $stop;
        end

        //End of Tests...Check the Overall Outcome
        if (~err) $display("PASSED ALL TESTS");

        $stop;

    end
endmodule
