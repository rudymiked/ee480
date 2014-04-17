`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////
//
// Michael Rudy & Russell Brooks
// University of Kentucky
// EE 480 Spring 2014
//
// Module: DFF_SYN_LOW_CLR_SET.v
// Dependencies: N/A
//
// Description:
//
// Last Modified: Russell - 4/14/2014
//
//////////////////////////////////////////////////////////////////

module DFF_SYN_LOW_CLR_SET(clk,d,set,clr,q,q_cmp);
input clk,d,set,clr;
output reg q, q_cmp;

always@(posedge(clk))
begin

if(clr==1'b0) begin q=1'b0; q_cmp=1'b1; end
else if(set==1'b0) begin q=1'b1; q_cmp=1'b0; end
else
	begin
	case(d)
		1'b0: begin q=1'b0; q_cmp=1'b1; end
		1'b1: begin q=1'b1; q_cmp=1'b0; end
		default: begin q=1'bZ; q_cmp=1'bZ; end
	endcase
	end
end

endmodule
