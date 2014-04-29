`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////
//
// Michael Rudy & Russell Brooks
// University of Kentucky
// EE 480 Spring 2014
//
// Module: psr.v 
// Dependencies: N/A
//
// Description: pipeline stage register
//
// Last Modified: Russell - 4/28/2014
//
/////////////////////////////////////////////////////////////////

module psr(in, out, left, right, bubble, bub_clr, clr, clk);
    parameter n = 30;
	 
    input [n - 1 : 0] in;
    input left, right, bubble, bub_clr, clr, clk;
    output reg [n - 1 : 0] out;
	 reg [n - 1 : 0] data_in;
    reg [1 : 0] bub_reg;
    
    always @ (posedge clk) begin
        if(!clr) begin  // clear pipeline stage register
            out = 0;
            data_in = 0;
            bub_reg = 0;
        end else if(bubble) begin
            out = 0;
            data_in = 0;
            bub_reg = 1;
        end else begin
            if(left && !bub_reg) begin  // load all
                data_in = in;
            end else begin
                data_in = data_in;  
				end
            
				if(bub_clr == 1 && bub_reg != 0) begin  // bubble
                bub_reg = bub_reg - 1; 
            end else if(right) begin  // move everything to the right
                out = data_in;
            end else begin
                out = out;
				end
        end
    end
    
endmodule
