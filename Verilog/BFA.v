`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////
//
// Michael Rudy & Russell Brooks
// University of Kentucky
// EE 480 Spring 2014
//
// Module: BFA.v
// Dependencies: N/A
//
// Description: Binary Full Adder - Adds binary values and accounts for overflow
//
// Last Modified: Michael - 4/14/2014
//
//////////////////////////////////////////////////////////////////
module BFA(i1, i0, ci, so, co);

  input i1, i0, ci;
  output so;
  output co;
  //wire w0, w1, w2; 
  
  assign so = i1^i0^ci;
  assign co = (i1&&ci)||(i0&&ci)||(i1&&i0);


endmodule
