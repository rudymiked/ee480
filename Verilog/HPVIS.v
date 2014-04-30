`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////
//
// Michael Rudy & Russell Brooks
// University of Kentucky
// EE 480 Spring 2014
//
// Module: HVPIS.v
// Dependencies: encoder
//
// Description: Controls all the things
//
// Last Modified: Mike - 4/29/2014
//
//////////////////////////////////////////////////////////////////
module HPVIS(i_in, mask, clr, i_clr, en, clk, i_pending, PC_out);

  input [3:0] i_in;
  input [3:0] mask;     //bit maskmodule encoder(i, en, a, valid); 
  
  input clr, i_clr, en, clk;        // active low clr, interrupt clr, enable bit, clk
  
  output [7:0] PC_out;
  output i_pending;
  
  
  wire [3:0] mask_wire;
  wire [1:0] en_out;
  wire i_pending_wire;
  
  reg [3:0] i_reg;
  reg [31:0] address;
  
  
  initial
  begin
    //Interrupt Service Routine Addresses
    address[31:24] = 00000100;   // external interrupt
    address[23:16] = 00000010;   // illegal opcode
    address[15:8]  = 00000001;   // overflow
    address[7:0]   = 00000000;   // zero
  end
  
  
  and A0 (mask_wire[0],i_reg[0],mask[0]);
  and A1 (mask_wire[1],i_reg[1],mask[1]);
  and A2 (mask_wire[2],i_reg[2],mask[2]);
  
  //module encoder(i, en, a, valid); 
  encoder EN0(mask_wire,1,en_out,i_pending_wire);
  and (i_pending, i_pending_wire, en);
  
  //mux_dwidth_2nx1(in,sel,out);
  mux_dwidth_2nx1 #(.d_width(8),.n(2)) PC_MUX (address,en_out,PC_out);
  
  
  always @ (posedge clk)
  begin
    if (i_clr)
	   i_reg <= 0;
    else
	   i_reg <= i_reg | i_in;
  end
  

endmodule
