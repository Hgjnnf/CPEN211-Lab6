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
        if (lab6_check.DUT.DP.REGFILE.R1 !== 16'h70) begin
        err = 1;
        $display("FAILED: MOV R1, #70");
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
        if (lab6_check.DUT.DP.REGFILE.R2 !== 16'h2) begin
        err = 1;
        $display("FAILED: MOV R2, #2");
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
        if (lab6_check.DUT.DP.REGFILE.R3 !== 16'h8) begin
        err = 1;
        $display("FAILED: MOV R3, #8");
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
        if (lab6_check.DUT.DP.REGFILE.R4 !== 16'h21) begin
        err = 1;
        $display("FAILED: MOV R4, #21");
        $stop;
        end

        //Test #5: MOV R5, #-30
        SIM_in = 16'b1101011011100010;
        SIM_load = 1;
        #10;
        SIM_load = 0;
        SIM_s = 1;
        #10
        SIM_s = 0;
        @(posedge SIM_w); // wait for w to go high again
        #10;
        if (lab6_check.DUT.DP.REGFILE.R5 !== 16'h(-30)) begin
        err = 1;
        $display("FAILED: MOV R5, #-30");
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
        if (lab6_check.DUT.DP.REGFILE.R6 !== 16'h0) begin
        err = 1;
        $display("FAILED: MOV R6, #0");
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
        if (lab6_check.DUT.DP.REGFILE.R7 !== 16'h100) begin
        err = 1;
        $display("FAILED: MOV R7, #100");
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
        if (lab6_check.DUT.DP.REGFILE.R0 !== 16'h10) begin
        err = 1;
        $display("FAILED: MOV R0, #10");
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
        if (lab6_check.DUT.DP.REGFILE.R1 !== 16'h20) begin
        err = 1;
        $display("FAILED: MOV R1, R0, LSL#1");
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
        if (lab6_check.DUT.DP.REGFILE.R5 !== 16'h4) begin
        err = 1;
        $display("FAILED: MOV R5, R3, LSR#1");
        $stop;
        end

        //Test 11: ADD R2, R1, R5 (R2 Should Equal 24)
        in = 16'b1010000101000101;
        load = 1;
        #10;
        load = 0;
        s = 1;
        #10
        s = 0;
        @(posedge w); // wait for w to go high again
        #10;
        if (lab6_check.DUT.DP.REGFILE.R2 !== 16'h24) begin
        err = 1;
        $display("FAILED: ADD R2, R1, R0, LSL#1");
        $stop;
        end

        //End of Tests...Check the Overall Outcome
        if (~err) $display("INTERFACE OK");
        $stop;
        
    end
endmodule
