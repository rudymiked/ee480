`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////
//
// Michael Rudy & Russell Brooks
// University of Kentucky
// EE 480 Spring 2014
//
// Module: DEC_4x16.v
// Dependencies: N/A
//
// Description: 4x16 Decoder
//
// Last Modified: Michael - 4/14/2014
//
//////////////////////////////////////////////////////////////////
module dec_4x16(bin,d);
	 
  input  [3:0]bin;
  output [15:0]d;
  
  DEC_3x8 DEC1 (bin[2:0],bin[3],d[15:8]);
  DEC_3x8 DEC0 (bin[2:0],w0,d[7:0]);
  not (w0,bin[3]);

endmodule
