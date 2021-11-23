 module datapath_tb();
  reg sim_clk;
  reg [2:0] sim_readnum, sim_writenum;
  reg [1:0] sim_ALUop, sim_shift, sim_vsel;
  reg sim_write, sim_loada, sim_loadb, sim_asel, sim_bsel, sim_loadc, sim_loads;
  reg [15:0] sim_sximm5, sim_sximm8;
  reg err;

  wire [15:0] sim_datapath_out;
  wire [2:0] sim_Z_out;

    datapath DUT(
        .clk(sim_clk), 
        .readnum(sim_readnum), 
        .vsel(sim_vsel), 
        .loada(sim_loada), 
        .loadb(sim_loadb), 
        .shift(sim_shift),
        .asel(sim_asel),
        .bsel(sim_bsel),
        .ALUop(sim_ALUop),
        .loadc(sim_loadc),
        .loads(sim_loads),
        .writenum(sim_writenum),
        .write(sim_write),
        .mdata(16'b0),
        .PC(8'b0),
        .sximm5(sim_sximm5),
        .sximm8(sim_sximm8),
        .Z_out(sim_Z_out),
        .datapath_out(sim_datapath_out)
    );
  initial begin

    sim_clk = 1'b0;
    err = 1'b0;
  
    //overall instruction to execute ADD R2, R0, R1, LSL #1
    //where R1 and R0 are given numbers
    //will be executed in 4 cycles

    //Before executing the cycles must write some values to R1 and R0
    #5;
    sim_write = 1'b1;
    sim_writenum = 3'b000;
    sim_vsel = 2'b10;
    #5;
    sim_sximm8 = 16'd18;
    #5;
    sim_clk = 1'b1;
    #5;
    sim_clk = 1'b0;
    //at this point value 18 is in R0
    #5;
    sim_write = 1'b1;
    sim_writenum = 3'b001;
    sim_vsel = 2'b10;
    #5;
    sim_sximm8 = 16'd76;
    #5;
    sim_clk = 1'b1;
    #5;
    sim_clk = 1'b0;
    #5;
    //at this point value 76 is in R1
    //now we can start our 4 cycles to execute the instruction
    sim_write = 1'b0;

    //cycle 1
    sim_readnum = 3'b000;
    sim_loada = 1'b1;
    sim_loadb = 1'b0;
    #5;
    sim_clk = 1'b1;
    #5;
    sim_clk = 1'b0;
    #5;
    //at this point R0 is loaded at A

    //cycle 2
    sim_readnum = 3'b001;
    sim_loada = 1'b0;
    sim_loadb = 1'b1;
    #5
    sim_clk = 1'b1;
    #5;
    sim_clk = 1'b0;
    #5;
    sim_loadb = 1'b0;
    //at this point R1 is loaded at B
   
    //cycle 3
    sim_shift = 2'b01;
    sim_asel = 1'b0;
    sim_bsel = 1'b0;
    sim_ALUop = 2'b00;
    sim_loadc = 1'b1;
    sim_loads = 1'b1;
    #5;
    sim_clk = 1'b1;
    #5;
    sim_clk = 1'b0; 
    #5;
    //at this point 2*R1 + R0 is loaded at C

    //cycle 4
    sim_write = 1'b1;
    sim_writenum = 3'b010;
    sim_vsel = 2'b00;
    #5;
    sim_clk = 1'b1;
    #5;
    sim_clk = 1'b0; 
    #5;
    sim_write = 1'b0;
    #5;
    //at this point 2*R1+R0 is written at R2(170)
    
    if(sim_datapath_out != 16'd18 + 16'd152)begin
      err = 1'b1;
      $display("Error with 1st sequence of actions in datapath!");
    end 
    #5;

    if(sim_Z_out != 1'b0)begin
      err = 1'b1;
      $display("Error with status register!");
    end 
    #5;

    //overall instruction to execute SUB R3,R2,#32
    //value 170 should be at R2 so no need to write that
    //should write value 32 to some register 
    sim_write = 1'b1;
    sim_writenum = 3'b011;//R3
    sim_vsel = 2'b10;
    #5;
    sim_sximm8 = 16'd32;
    #5;
    sim_clk = 1'b1;
    #5;
    sim_clk = 1'b0;
    //at this point value 32 is in R3
    #5;
    sim_write = 1'b0;   
    #5;

    //cycle 1
    sim_readnum = 3'b010;
    sim_loada = 1'b1;
    sim_loadb = 1'b0;
    #5
    sim_clk = 1'b1;
    #5;
    sim_clk = 1'b0;
    #5;
    //at this point R2 is loaded at A

    //cycle 2
    sim_readnum = 3'b011;
    sim_loada = 1'b0;
    sim_loadb = 1'b1;
    #5
    sim_clk = 1'b1;
    #5;
    sim_clk = 1'b0;
    #5;
    //at this point R3 is loaded at B

    //cycle 3
    sim_shift = 2'b00;
    sim_asel = 1'b0;
    sim_bsel = 1'b0;
    sim_ALUop = 2'b01;
    sim_loadc = 1'b1;
    sim_loads = 1'b0;
    #5;
    sim_clk = 1'b1;
    #5;
    sim_clk = 1'b0; 
    #5;
    //at this point R2 - R3 is loaded at C

    //cycle 4
    sim_write = 1'b1;
    sim_writenum = 3'b011;
    sim_vsel = 2'b00;
    #5;
    sim_clk = 1'b1;
    #5;
    sim_clk = 1'b0; 
    #5;
    sim_write = 1'b0;
    #5;
    //at this point R2-32(R3) is written at R3(170-32)

    if(sim_datapath_out != 16'd170 - 16'd32)begin
      err = 1'b1;
      $display("Error with 2nd sequence of actions in datapath!");
    end 
    #5;

    //overall instruction to execute MOV R7,R0,LSR #1
    //we have all necessary values already written should load R0 to Bin
    //then with asel and bsel signals we can modify value as we like and MOV RO to R7

    //cycle 1
    sim_readnum = 3'b000;
    sim_loada = 1'b0;
    sim_loadb = 1'b1;
    #5
    sim_clk = 1'b1;
    #5;
    sim_clk = 1'b0;
    #5;
    //at this point R0 is loaded at B

    //cycle 2
    sim_shift = 2'b10;
    sim_asel = 1'b1;
    sim_bsel = 1'b0;
    sim_ALUop = 2'b00;
    sim_loadc = 1'b1;
    sim_loads = 1'b0;
    #5;
    sim_clk = 1'b1;
    #5;
    sim_clk = 1'b0; 
    #5;
    //at this point 0+R0/2=R0/2 is loaded at C

    //cycle 3
    sim_write = 1'b1;
    sim_writenum = 3'b111;
    sim_vsel = 2'b00;
    #5;
    sim_clk = 1'b1;
    #5;
    sim_clk = 1'b0; 
    #5;
    sim_write = 1'b0;
    #5;
    //at this point R0/2 is written at R7

    if(sim_datapath_out != 16'd9)begin
      err = 1'b1;
      $display("Error with 3rd sequence of actions in datapath!");
    end 
    #5;

    //now we can test other two operations of ALU and bsel signal
    //now test R3&R1 (16'd138 & 16'd76)
    //0000000010001010 & 0000000001001100 = 0000000000001000

    //cycle 1
    sim_readnum = 3'b011;
    sim_loada = 1'b1;
    sim_loadb = 1'b0;
    #5
    sim_clk = 1'b1;
    #5;
    sim_clk = 1'b0;
    #5;
    //at this point R3 is loaded at A

    //cycle 2
    sim_readnum = 3'b001;
    sim_loada = 1'b0;
    sim_loadb = 1'b1;
    #5
    sim_clk = 1'b1;
    #5;
    sim_clk = 1'b0;
    #5;
    //at this point R1 is loaded at B

    //cycle 3
    sim_shift = 2'b00;
    sim_asel = 1'b0;
    sim_bsel = 1'b0;
    sim_ALUop = 2'b10;
    sim_loadc = 1'b1;
    sim_loads = 1'b0;
    #5;
    sim_clk = 1'b1;
    #5;
    sim_clk = 1'b0; 
    #5;
    //at this point R3&R1 is loaded at C

    //cycle 4
    sim_write = 1'b1;
    sim_writenum = 3'b101;
    sim_vsel = 2'b00;
    #5;
    sim_clk = 1'b1;
    #5;
    sim_clk = 1'b0; 
    #5;
    sim_write = 1'b0;
    #5;
    //at this point R3&R1 is written at R5

    if(sim_datapath_out != 16'b0000000000001000)begin
      err = 1'b1;
      $display("Error with 4th sequence of actions in datapath!");
    end 
    #5;

    //and finally will test bsel and NOT operation of ALU
    //bsel requires lower 5 bits of datapath_in

    //cycle 1
    sim_sximm8 = 16'b1010010011101001;
    sim_readnum = 3'b101;
    sim_loada = 1'b0;
    sim_loadb = 1'b1;
    #5
    sim_clk = 1'b1;
    #5;
    sim_clk = 1'b0;
    #5;
    //at this point R5 is loaded at B

    //cycle 2
    sim_shift = 2'b00;
    sim_asel = 1'b1;
    sim_bsel = 1'b1;
    sim_ALUop = 2'b11;
    sim_loadc = 1'b1;
    sim_loads = 1'b0;
    #5;
    sim_clk = 1'b1;
    #5;
    sim_clk = 1'b0; 
    #5;
    //at this point ~Bin is loaded at C (a different signal than the one loaded at B because bsel is 1)

    //cycle 3
    sim_write = 1'b1;
    sim_writenum = 3'b110;
    sim_vsel = 2'b00;
    #5;
    sim_clk = 1'b1;
    #5;
    sim_clk = 1'b0; 
    #5;
    sim_write = 1'b0;
    #5;
    //at this point ~Bin is written at R6

    if(sim_datapath_out != {11'b11111111111,5'b10110})begin
      err = 1'b1;
      $display("Error with 5th sequence of actions in datapath!");
    end 
    #5;

    if(err == 1'b1)
      $display("DATAPATH FAILED AT LEAST ONE TEST!");
    else
      $display("DATAPATH PASSED ALL TESTS!");
    #5;

    //$stop;
  end
endmodule
