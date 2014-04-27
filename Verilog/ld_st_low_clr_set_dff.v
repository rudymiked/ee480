`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////
//
// Michael Rudy & Russell Brooks
// University of Kentucky
// EE 480 Spring 2014
//
// Module: ld_st_low_clr_set_dff.v
// Dependencies: dff_low_active_low_set_clr.v, mux_2nx1.v
//
// Description: Load Store Register
//
// Last Modified: Michael - 4/14/2014
//
//////////////////////////////////////////////////////////////////

module ld_st_low_clr_set_dff(
  input in, ls_sel, set, clr, clk,
  output q);

  wire w_dq;

  mux_2nx1 #(1) SLICE (in, q, w_dq, ls_sel);
  
  dff_low_active_low_set_clr DFF (clk, w_dq, set, clr, q);

endmodule



