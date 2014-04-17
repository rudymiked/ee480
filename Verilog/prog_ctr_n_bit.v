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
// Description: Parameterized program counter
//
// Last Modified: Russell - 4/14/2014
//
//////////////////////////////////////////////////////////////////

module prog_ctr_n_bit(clr, clk, pc_c, pc_i, pc_o);

  parameter n=4;
  parameter inc=2;
  
  input [n-1:0]pc_i;
  input clr,clk;
  input [1:0]pc_c;
  output [n-1:0]pc_o;
  reg [n-1:0]pc_o;
  integer i;
  
  always @(posedge clk)
  begin
    if (clr==1'b0)
	 begin
	   for (i=0;i<n;i=i+1)
	   begin
		  pc_o[i]=1'b0;
		end
	 end
    else
	 begin
	   case(pc_c)
		  0 : pc_o=pc_o;
        1 : pc_o=pc_i;
		  2 : pc_o=pc_o+1;
		  3 : pc_o=pc_i+inc;
		  default : pc_o=pc_o;
		endcase
    end
  end	 
endmodule
