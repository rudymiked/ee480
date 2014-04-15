`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////
//
// Michael Rudy & Russell Brooks
// University of Kentucky
// EE 480 Spring 2014
//
// Module: n_bit_shifter.v
// Dependencies: N/A
//
// Description: A shifter that implements the following function table:
//
//    shfc   funct
//    000    f * 2
//    001    f * 4
//    010    f
//    011    f / 2
//    100    f / 4
//    101    All 0's
//    110    All 1's
//    111    All Z's
//
// Last Modified: Russell - 4/14/2014
//
//////////////////////////////////////////////////////////////////

module shifter_n_bit(in, out, shfc);
	parameter n_bits = 3;
	
	input [n_bits - 1 : 0] in;
	input [2 : 0] shfc; // control input
	output reg [n_bits - 1 : 0] out;
	integer i;
	
	always@(in, shfc)
	begin
		case(shfc)
		0 : out = in <<< 1;
		1 : out = in <<< 2;
		2 : out = in;
		3 : out = in >>> 1;
		4 : out = in >>> 1;
		5 : begin
			for(i = 0; i < n_bits; i = i + 1) begin
				out[i] = 0;
			end
			end			
		6 : begin
			for(i = 0; i < n_bits; i = i + 1) begin
				out[i] = 1;
			end
			end	
		7 : begin
			for(i = 0; i < n_bits; i = i + 1) begin
				out[i] = 1'bZ;
			end
			end	
		endcase
	end
	
endmodule
