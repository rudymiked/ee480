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
    mem[0] = 0011100011
    mem[1] = 0000000101
    mem[2] = 0011110100
    mem[3] = 0000010100
    mem[4] = 0000110111
    mem[5] = 0000100000
    mem[6] = 0100001110
    mem[7] = 0100011100
    mem[8] = 0001010101
    mem[9] = 0001100111
    mem[10] = 0010000010
    mem[11] = 0001110011
    mem[12] = 0011100001
    mem[13] = 0011110101
    mem[14] = 0100100001
    mem[15] = 0010100000
    mem[16] = 0010010001
    mem[17] = 0011000100
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
