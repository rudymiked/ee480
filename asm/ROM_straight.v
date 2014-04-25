##################################################################
##
## Michael Rudy & Russell Brooks
## University of Kentucky
## EE 480 Spring 2014
##
## Module: ROM_straight.v 
## Dependencies: N/A
##
## Description: initial RAM module for ROM_straight.v program
##
## Last Modified: Michael - 4/24/2014
##
##################################################################
module ROM_straight.v(ce, reg_in, addr, rw, clk, clr, reg_out);

  parameter addr_width = 8, data_width = 8;
  input rw, clr, clk, ce;
  input [(data_width-1):0] reg_in;
  input [(addr_width-1):0] addr;

  output [(data_width-1):0] reg_out;
  reg [(data_width-1):0] reg_out;
  integer i;
  reg [(data_width-1):0] mem[((2**addr_width)-1):0];

end
