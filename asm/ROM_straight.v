//////////////////////////////////////////////////////////////////
//
// Michael Rudy & Russell Brooks
// University of Kentucky
// EE 480 Spring 2014
//
// Module: ROM_straight.v 
// Dependencies: N/A
//
// Description: initial RAM module for ROM_straight program
//
// Last Modified: Michael - 4/24/2014
//
//////////////////////////////////////////////////////////////////
module ROM_straight(ce, reg_in, addr, rw, clk, clr, reg_out);

  parameter addr_width = 8, data_width = 8;
  input rw, clr, clk, ce;
  input [(data_width-1):0] reg_in;
  input [(addr_width-1):0] addr;

  output [(data_width-1):0] reg_out;
  reg [(data_width-1):0] reg_out;
  integer i;
  reg [(data_width-1):0] mem[((2**addr_width)-1):0];

  initial
  begin
    mem[0] = 0011100000000011
    mem[1] = 0000000000000101
    mem[2] = 0011110000000100
    mem[3] = 0000010000000100
    mem[4] = 0000110000000111
    mem[5] = 0000100000000000
    mem[6] = 0100000000001110
    mem[7] = 0100010000001100
    mem[8] = 0001010000000101
    mem[9] = 0001100000000111
    mem[10] = 0010000000000010
    mem[11] = 0001110000000011
    mem[12] = 0011100000000001
    mem[13] = 0011110000000101
    mem[14] = 0100100000000001
    mem[15] = 0010100000000000
    mem[16] = 0010010000000001
    mem[17] = 0011000000000100
  end

  always@(posedge clk)
  begin
  if(!clr) //clear memory
  begin
      reg_out <= 0;
		for(i=0; i<(2**addr_width); i=i+1)
		begin
			mem[i] <= 0;
		end
  end
  if (ce)
  begin  
	 if (clr)
	 begin
	   if(rw) //read
	   begin
		  reg_out <= mem[addr];
      end
	   else
	   begin //write
		  mem[addr] <= reg_in;
	   end
	 end
  end
  else //ce (chip enable) = 0
    reg_out <= 8'bZ;
  end

endmodule