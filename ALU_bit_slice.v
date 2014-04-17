`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////
//
// Michael Rudy & Russell Brooks
// University of Kentucky
// EE 480 Spring 2014
//
// Module: ALU_bit_slice.v
// Dependencies: mux_2nx1.v, BFA.v
//
// Description: Arithmetic Logic Unit (1 bit)
// 0 : "b"
// 1 : BFA sum out
// 2 : or out
// 3 : and out
//
// Last Modified: Michael - 4/14/2014
//
//////////////////////////////////////////////////////////////////
module ALU_bit_slice(a,b,c,ctrl0,ctrl1,ctrl2,f_out,c_out);
    input a, b, c;
	 input ctrl0, ctrl1, ctrl2; 
	 output f_out, c_out;

    wire [4:0] w;
	 
	 
	 not no1(b_n,b);
	 
	 mux_2nx1 #(1) M20 ({b_n,b},ctrl0,w[0]);
	 
	 BFA     BFA0 (w[0],a,c,w[1],c_out);
	 
	 mux_2nx1 #(1) M21 ({a,w[0]},ctrl0,w[4]);
	 
	 mux_2nx1 #(2) M40 ({w[4],w[3],w[2],w[1]},{ctrl2,ctrl1},f_out);

	 and and1 (w[2],a,w[0]);
	 or  or1 (w[3],a,w[0]);
endmodule
