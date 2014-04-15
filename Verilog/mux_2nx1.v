`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////
//
// Michael Rudy & Russell Brooks
// University of Kentucky
// EE 480 Spring 2014
//
// Module: mux_2nx1.v
// Dependencies: N/A
//
// Description: Parameterized 2**n x 1 MUX
//
// Last Modified: Russell - 4/14/2014
//
//////////////////////////////////////////////////////////////////

module mux_2nx1(in, sel, out);

	parameter n=3;
	
	input [2**n-1:0] in;
	input [n-1:0] sel;
	output reg out;
	
	always@(in or sel)
	begin
		out = in[sel];
	end

endmodule
