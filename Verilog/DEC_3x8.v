`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////
//
// Michael Rudy & Russell Brooks
// University of Kentucky
// EE 480 Spring 2014
//
// Module: DEC_3x8.v
// Dependencies: N/A
//
// Description: 3x8 Decoder
//
// Last Modified: Michael - 4/14/2014
//
//////////////////////////////////////////////////////////////////
module DEC_3x8(bin,en,d);

  input  [2:0]bin;
  input  en;
  output [7:0]d;
  wire   w0;
 
  always @ (bin or en)
  begin
  if (en==0) d=8'b00000000;
    else if (en==1)
	   case (bin)
		  0 :  d=8'b00000001;
		  1 :  d=8'b00000010;
		  2 :  d=8'b00000100;
		  3 :  d=8'b00001000;
		  4 :  d=8'b00010000;
		  5 :  d=8'b00100000;
		  6 :  d=8'b01000000;
		  7 :  d=8'b10000000;
		  default:d=8'b11111111;
		endcase
		else d=8'b11111111;
  end

endmodule
