`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////
//
// Michael Rudy & Russell Brooks
// University of Kentucky
// EE 480 Spring 2014
//
// Module: encoder.v
// Dependencies: N/A
//
// Description: Encodes all the things
//
// Last Modified: Mike - 4/30/2014
//
//////////////////////////////////////////////////////////////////
module encoder(i, en, a, valid); 

  input [3:0] i;
  input en;
  output reg [1:0] a;
  output reg valid;
  
  always @(i or en)
  begin  
    if (!en)
	 begin
	   a     <= 0;
		valid <= 0;
	 end
    if (i[3]) 
	 begin
      a     <= 2'b11; 
		valid <= 1;
	 end
	 else if (i[2])
	 begin
      a     <= 2'b10;
      valid <= 1;		
    end
    else if (i[1]) 
	 begin
      a     <= 2'b01;
	   valid <= 1;	
	 end
    else 
	 begin
      a     <= 2'b00;
      valid <= 0;	
    end		
  end
  
endmodule
