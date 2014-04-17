`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////
//
// Michael Rudy & Russell Brooks
// University of Kentucky
// EE 480 Spring 2014
//
// Module: RAM.v
// Dependencies: N/A
//
// Description: Parameterized random access memory implemented using registers
//
// Last Modified: Russell - 4/14/2014
//
/////////////////////////////////////////////////////////////////

module RAM(data_in, clk, addr, ce, clr, rw, data_out);
	parameter d_width = 8;              // data bus width
	parameter a_width = 8;					// address width (2**m memory locations)
	
	input [d_width - 1 : 0] data_in;		// data input
	input clk;                          // clock
	input [a_width - 1 : 0] addr;       // address (m bits wide)
   input ce;                           // chip enable (operates when ce=1, data_out is HiZ when ce=0)
   input clr;                          // synch active low clear
   input rw;                           // read when rw=1, write when rw=0
   
	output [d_width - 1 : 0] data_out;  // data output
	reg [d_width - 1 : 0] data_out;     // data output register
   reg [d_width - 1 : 0] memory [2**a_width - 1 : 0];  // memory values
	integer i;
	
	 // read/write synchronous loop
    always @ (posedge clk)
    begin
		  // synch low clear
        if(!clr) begin 
            data_out <= 0;
            for(i = 0; i < 2**a_width; i = i + 1) begin
                memory[i] <= 0;
            end
        end
        
		  // read or write only if enabled
		  if(ce) begin
				// do nothing on a clear
            if(clr) begin
					 // read data
					 if(rw) begin
							data_out <= memory[addr];
                end
					 // write data
                else begin
							memory[addr] <= data_in;
                end
            end
        end
		  else begin
				data_out <= 8'bZ;
		  end
    end

	
endmodule
