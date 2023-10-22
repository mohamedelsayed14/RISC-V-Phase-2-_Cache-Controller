//testbench module
//soc risc_v and cache_memory_system and instructer_memory
`timescale 1ns/1ps
module tb_RISC_V_SOC ();

//*********soc***************************************************
//reg clk,reset;
//RISC_V_SOC dft(clk,reset); 
//***************************************************************

reg clk,reset;
wire [31:0] instr, pc;
wire Mem_Write, Mem_read, stall;
wire [31:0] a_data_mem, w_data_mem;
wire [31:0] r_data_mem;
reg  [0:250]msg;
reg  [31:0]expected_read;

RISC_V    risc_v (clk, reset, instr, pc, Mem_Write, Mem_read, stall, a_data_mem, w_data_mem, r_data_mem);       
inst_mem  i_m    (pc, instr);          
cache_system cache_system (clk, reset, Mem_Write, Mem_read, stall, a_data_mem, w_data_mem, r_data_mem);
///////////////////////////////////// ////////////////////////////

// initialize reset
  initial
  begin
    $display("               time:ns  Mem_Write:  Mem_read:   Word_address:  write_data:    read_data:    expected_read:             state:");
    $dumpfile("risc_v.vcd");
    $dumpvars(0,tb_RISC_V_SOC);

        reset = 1;
    #5; reset = 0;

    #1000;
    $finish;
  end
/////////////////////////////////////////////////////////////////
  always@(posedge clk)
  begin
  if(Mem_read)
   begin
      expected_read= a_data_mem/4;
      if(r_data_mem == a_data_mem/4)
          msg="Test Passed: read operation";
      else 
          msg="Test Failed: read operation";   
    end
  else if (Mem_Write) 
    begin
     msg="Wirte Operation";
     expected_read=32'dx;
    end
  else 
    begin
     msg="Other Operation"; 
     expected_read=32'dx;
    end
   $display("%t\t       %d\t          %d\t  %d\t   %d\t   %d\t      %d\t %s",$time, Mem_Write, Mem_read, a_data_mem/4, w_data_mem, r_data_mem,expected_read, msg);
  end
////////////////////////////////////////////////////////////////////
// generate clock
  always
  begin
   clk = 1;
	#5; 
	clk = 0;
	#5;
  end

endmodule  