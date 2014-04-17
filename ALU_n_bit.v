`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////
//
// Michael Rudy & Russell Brooks
// University of Kentucky
// EE 480 Spring 2014
//
// Module: ALU_n_bit.v
// Dependencies: ALU_bit_slice.v
//
// Description: Arithmetic Logic Unit
//
// Last Modified: Michael - 4/14/2014
//
//////////////////////////////////////////////////////////////////
module ALU_n_bit(a,b,c_in,ctrl,f_out,c_out,v,z,sign);
   parameter n = 4;
	
   input [n-1:0] a;
	input [n-1:0] b;
   input c_in;
   input [2:0] ctrl;	
	
	output [n-1:0] f_out;
	output c_out;
	output v; 				// overflow bit
	wire [1:0] v_wire;
	output z,sign;
	
	wire [n:0] w;
	wire [n-1:0]z_check; // zero check
	
	genvar i;
	assign w[0] = c_in;
	assign c_out = w[n];
	assign z_check[0] = f_out[0];
	
	
	generate 
	  for (i=0; i<n; i=i+1)
	    begin:alu_loop
	      ALU_bit_slice ALU (a[i],b[i],w[i],ctrl[0],ctrl[1],ctrl[2],f_out[i],w[i+1]);
			  
		 end
		for(i=0; i <n-1; i=i+1)
        begin:z_check_loop
          or OR0 (z_check[i+1],f_out[i+1],z_check[i]);
        end
   endgenerate
	
	//zero check
	not(z,z_check[n-1]);
	
	//overflow bit 'v'
	xor (v_wire[1],w[n-1],w[n]);
	assign v_wire[0] = (~ctrl[2] & ~ctrl[1] & ~ctrl[0]);
	and (v,v_wire[1],v_wire[0]);
	
	//sign bit
	assign sign = f_out[n-1];
	
	
endmodule

