//////////////////////////////////////////////////////////////////
//
// Michael Rudy & Russell Brooks
// University of Kentucky
// EE 480 Spring 2014
//
// Module: ROM_sub.v 
// Dependencies: N/A
//
// Description: initial RAM module for ROM_sub program
//
// Last Modified: Michael - 4/24/2014
//
//////////////////////////////////////////////////////////////////
module ROM_sub(reg_in, clk, addr, ce, clr, rw, reg_out);

  parameter addr_width = 8, data_width = 16;
  input rw, clr, clk, ce;
  input [(data_width-1):0] reg_in;
  input [(addr_width-1):0] addr;

  output [(data_width-1):0] reg_out;
  reg [(data_width-1):0] reg_out;
  integer i;
  reg [(data_width-1):0] mem[((2**addr_width)-1):0];

  initial
  begin
    mem[0] = 16'b0011100000000011;
    mem[1] = 16'b0011110000000000;
    mem[2] = 16'b0001010000000010;
    mem[3] = 16'b0000010000000001;
    mem[4] = 16'b0001110000000010;
    mem[5] = 16'b0010110000000000;
    mem[6] = 16'b0011000000000000;
    mem[7] = 16'b0000010000000001;
    mem[8] = 16'b0010000000000010;
    mem[9] = 16'b0011000000000000;

    for(i = 10; i < 255; i = i + 1)
      mem[i] = 0;

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
