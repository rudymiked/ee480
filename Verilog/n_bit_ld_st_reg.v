`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////
//
// Michael Rudy & Russell Brooks
// University of Kentucky
// EE 480 Spring 2014
//
// Module: n_bit_ld_st_reg.v
// Dependencies: ld_st_low_clr_set_dff.v
//
// Description:  n-bit Load Store Register
//
// Last Modified: Michael - 4/14/2014
//
//////////////////////////////////////////////////////////////////
module n_bit_ld_st_reg(ld_st,in,clk,clr,set,out);
	 
	 parameter n=4;
	 
	 input [n-1:0] in;
	 input set, clk, clr;
	 input ld_st;
	 
	 output [n-1:0] out;
	 
	 genvar i;
	 
	 generate
	   for (i=0;i<=n-1;i=i+1)
		begin:submit
		  ld_st_low_clr_set_dff LDST (in[i], ld_st, set, clr, clk, out[i]);
		end
    endgenerate

endmodule
