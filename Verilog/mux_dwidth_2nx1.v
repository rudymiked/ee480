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
// Description: Parameterized 2**n x 1 MUX with data width
//
// Last Modified: Russell - 4/26/2014
//
//////////////////////////////////////////////////////////////////

module mux_dwidth_2nx1(in, sel, out);
	parameter n = 3;
	parameter d_width = 1;
	
	input [d_width * 2**n - 1 : 0] in;
	input [n - 1 : 0] sel;
	output reg [d_width - 1 : 0] out;
	integer i, j;
	
	always@(in or sel) begin
		j = sel;
		for(i = 0; i < d_width; i = i + 1)
			out[i] = in[d_width * j + i];
	end

endmodule
