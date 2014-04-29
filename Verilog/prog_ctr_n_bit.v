`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////
//
// Michael Rudy & Russell Brooks
// University of Kentucky
// EE 480 Spring 2014
//
// Module: prog_ctr_n_bit.v
// Dependencies: N/A
//
// Description: Parameterized program counter with synchronous low clear:
//					ctrl	funct
//					00		store
//					01		load input
//					10		increment by 1
//					11		increment by input
//
// Last Modified: Russell - 4/28/2014
//
//////////////////////////////////////////////////////////////////

module prog_ctr_n_bit(pc_in, pc_ctrl, clr, clk, pc_out);
  parameter d_width=4;
  
  input [d_width - 1 : 0] pc_in;
  input [1 : 0] pc_ctrl;
  input clr, clk;
  output reg [d_width - 1 : 0] pc_out;
  
  always @(posedge clk)
  begin
    if (clr == 1'b0) pc_out <= 1'b0;
    else begin
	   case(pc_ctrl)
		  0 : pc_out <= pc_out;
        1 : pc_out <= pc_in;
		  2 : pc_out <= pc_out + 1;
		  3 : pc_out <= pc_out + pc_in;
		  default : pc_out = pc_out;
		endcase
    end
  end	 
endmodule
