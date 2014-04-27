`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////
//
// Michael Rudy & Russell Brooks
// University of Kentucky
// EE 480 Spring 2014
//
// Module: ALU_n_bit.v
// Dependencies: ALU_bit_slice.v, shifter_n_bit
//
// Description: Arithmetic Logic Unit - Combined ALU & Shifter
//					 The most significant control bit determines 
//					 which operations are performed
//
//    ctrl   funct
//    0000    a + b + c_in
//    0001    a + ~b + c_in
//    0010    a & b 
//    0011    a & ~b
//    0100    a | b
//    0101    a | ~b
//    0110    b
//    0111    a
//    1000    ASL a
//    1001    a * b
//    1010    ~a
//    1011    ASR a
//    1100    a / b
//    1101    All 0's
//    1110    All 1's
//    1111    All Z's
//
// Last Modified: Russell - 4/26/2014
//
//////////////////////////////////////////////////////////////////
module ALU_n_bit(a, b ,c_in ,ctrl ,f_out ,c_out ,v ,z ,sign);
   	parameter n = 4;
	parameter m = 2;

   	input [n - 1 : 0] a;
	input [n - 1 : 0] b;
   	input c_in;
   	input [3 : 0] ctrl;	

	output [n - 1 : 0] f_out;
	output c_out;
	output v; // overflow bit
	output z; // zero bit
	output sign;

	wire [1 : 0] v_wire;
	wire [n : 0] w;  // bitslice wires
	wire [n - 1 : 0] z_check; // zero check
	wire [n - 1 : 0] f_ALU_wire; // output of ALU
	wire [n - 1 : 0] f_Shifter_wire; // output of Shifter

	genvar i;
	assign w[0] = c_in;
	assign c_out = w[n];
	assign z_check[0] = f_out[0];
	generate
	
	for (i = 0; i < n; i = i + 1)
		begin:alu_loop
			ALU_bit_slice ALU (a[i],b[i],w[i],ctrl[0],ctrl[1],ctrl[2],f_ALU_wire[i],w[i+1]);
		end
	for(i = 0; i < n - 1; i = i + 1)
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
	
	// shifter
	shifter_n_bit #(.n_bits(m)) SHIFTER (a, b[m - 1: 0], ctrl[2 : 0], f_Shifter_wire);
	
	mux_dwidth_2nx1 #(.n(1), .d_width(n)) OUTMUX ({f_ALU_wire, f_Shifter_wire}, ctrl[3], f_out);

endmodule

