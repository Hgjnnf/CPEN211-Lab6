module cpu_tb ();
    reg SIM_clk, SIM_reset, SIM_s, SIM_load;
    reg [15:0] SIM_in;
    wire [15:0] SIM_out;
    wire SIM_N, SIM_V, SIM_Z, SIM_w;

    reg err;

    //cpu module instantiation
    cpu DUT(SIM_clk, SIM_reset, SIM_s, SIM_load, SIM_in, SIM_out, SIM_N, SIM_V, SIM_Z, SIM_w);

    //clk cycle
    initial begin
        SIM_clk = 0; #5;
        forever begin
        SIM_clk = 1; #5;
        SIM_clk = 0; #5;
        end
    end

    //test benches
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
        @(negedge SIM_clk);
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
        @(negedge SIM_clk);
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
        @(negedge SIM_clk);
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
        @(negedge SIM_clk);
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

        //Test #6: MOV R6, #0
        @(negedge SIM_clk);
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
        @(negedge SIM_clk);
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
        @(negedge SIM_clk);
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
        @(negedge SIM_clk);
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
        @(negedge SIM_clk);
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
        @(negedge SIM_clk);
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
        @(negedge SIM_clk);
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
        @(negedge SIM_clk);
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
        @(negedge SIM_clk);
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
        @(negedge SIM_clk);
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
        @(negedge SIM_clk);
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

        //Test #17: MOV R3, #-10
        @(negedge SIM_clk);
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

        //Test 18: CMP R2, R3
        @(negedge SIM_clk);
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
        if (cpu_tb.DUT.V !== 1'd1) begin
        err = 1;
        $display("FAILED TEST #18c: CMP R2, R3");
        $stop;
        end

        //Test #19: AND R7, R2, R3
        @(negedge SIM_clk);
        SIM_in = 16'b1011001011100011;
        SIM_load = 1;
        #10;
        SIM_load = 0;
        SIM_s = 1;
        #10
        SIM_s = 0;
        @(posedge SIM_w); // wait for w to go high again
        #10;
        if (cpu_tb.DUT.DP.REGFILE.R7 !== 16'b1111111111110110) begin
        err = 1;
        $display("FAILED TEST #19: AND R7, R2, R3");
        $stop;
        end

        //Test #20: AND R0, R7, R5, LSL#1
        @(negedge SIM_clk);
        SIM_in = 16'b1011011100001101;
        SIM_load = 1;
        #10;
        SIM_load = 0;
        SIM_s = 1;
        #10
        SIM_s = 0;
        @(posedge SIM_w); // wait for w to go high again
        #10;
        if (cpu_tb.DUT.DP.REGFILE.R0 !== 16'b0000000000000000) begin
        err = 1;
        $display("FAILED TEST #20: AND R0, R7, R5, LSL#1");
        $stop;
        end

        //Test #21: AND R0, R1, R3, ASR#1
        @(negedge SIM_clk);
        SIM_in = 16'b1011000100011011;
        SIM_load = 1;
        #10;
        SIM_load = 0;
        SIM_s = 1;
        #10
        SIM_s = 0;
        @(posedge SIM_w); // wait for w to go high again
        #10;
        if (cpu_tb.DUT.DP.REGFILE.R0 !== 16'b00000000010000) begin
        err = 1;
        $display("FAILED TEST #21: AND R0, R1, R3, ASR#1");
        $stop;
        end

        //Test #22: MVN R4, R4
        @(negedge SIM_clk);
        SIM_in = 16'b1011100010000100;
        SIM_load = 1;
        #10;
        SIM_load = 0;
        SIM_s = 1;
        #10
        SIM_s = 0;
        @(posedge SIM_w); // wait for w to go high again
        #10;
        if (cpu_tb.DUT.DP.REGFILE.R4 !== 16'b1111111111101010) begin
        err = 1;
        $display("FAILED TEST #22a: MVN R4, R4");
        $stop;
        end
        if (cpu_tb.DUT.N !== 1'd1) begin
        err = 1;
        $display("FAILED TEST #22b: MVN R4, R4");
        $stop;
        end
        if (cpu_tb.DUT.V !== 1'd1) begin
        err = 1;
        $display("FAILED TEST #22c: MVN R4, R4");
        $stop;
        end

        //Test #23: MVN R5, R4, LSL#1
        @(negedge SIM_clk);
        SIM_in = 16'b1011100010101100;
        SIM_load = 1;
        #10;
        SIM_load = 0;
        SIM_s = 1;
        #10
        SIM_s = 0;
        @(posedge SIM_w); // wait for w to go high again
        #10;
        if (cpu_tb.DUT.DP.REGFILE.R5 !== 16'd43) begin
        err = 1;
        $display("FAILED TEST #23a: MVN R5, R4, LSL#1");
        $stop;
        end
        if (cpu_tb.DUT.N !== 1'd0) begin
        err = 1;
        $display("FAILED TEST #23b: MVN R5, R4, LSL#1");
        $stop;
        end
        if (cpu_tb.DUT.V !== 1'd0) begin
        err = 1;
        $display("FAILED TEST #23c: MVN R5, R4, LSL#1");
        $stop;
        end

        //Test #24: MVN R1, R5
        @(negedge SIM_clk);
        SIM_in = 16'b1011100000100101;
        SIM_load = 1;
        #10;
        SIM_load = 0;
        SIM_s = 1;
        #10
        SIM_s = 0;
        @(posedge SIM_w); // wait for w to go high again
        #10;
        if (cpu_tb.DUT.DP.REGFILE.R1 !== -16'd44) begin
        err = 1;
        $display("FAILED TEST #24: MVN R1, R5");
        $stop;
        end

        //End of Tests...Check the Overall Outcome
        if (~err) $display("PASSED ALL TESTS");

        $stop;

    end
endmodule
