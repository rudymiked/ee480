#! /usr/bin/env ruby

##################################################################
##
## Michael Rudy & Russell Brooks
## University of Kentucky
## EE 480 Spring 2014
##
## Module: rom_create.rb
## Dependencies: N/A
##
## Description: Parses assembled machine code and build an initial RAM state
##
## Last Modified: Michael - 4/24/2014
##
##################################################################

class RomCreate
  
  def initialize
    @file_name 
    @header # header
    @module # module declaration and variables
    @memory = Hash.new # machine code data 
  end

  def parse
    test = File.open(ARGV[0], "r")
    i = 0;
    
    #get file name
    test.each_line { |l|
      break if (i==1)
    
      l = l.split
    
      name = l[1] if (l[0] =~ /#/)

      @file_name = "ROM_#{name}";
      i = 1

    }
    @header = <<-eos
//////////////////////////////////////////////////////////////////
//
// Michael Rudy & Russell Brooks
// University of Kentucky
// EE 480 Spring 2014
//
// Module: #{@file_name}.v 
// Dependencies: N/A
//
// Description: initial RAM module for #{@file_name} program
//
// Last Modified: Michael - 4/24/2014
//
//////////////////////////////////////////////////////////////////
    eos

    machine = File.open("out", "r")
   
      j = 0
      machine.each_line { |l|
     
      @memory[j] = l 
  
      j += 1
    } 

   test.close
   machine.close

  end


  def build
    rom_file = File.open("#{@file_name}.v", "w")  
    rom_file.puts @header
    

    @module = <<-eos
module #{@file_name}(ce, reg_in, addr, rw, clk, clr, reg_out);

  parameter addr_width = 8, data_width = 16;
  input rw, clr, clk, ce;
  input [(data_width-1):0] reg_in;
  input [(addr_width-1):0] addr;

  output [(data_width-1):0] reg_out;
  reg [(data_width-1):0] reg_out;
  integer i;
  reg [(data_width-1):0] mem[((2**addr_width)-1):0];

    eos
    
    clr_blk = <<-eos
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
    eos

    read_write = <<-eos
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

    eos

    @memory = @memory.sort

    memory = <<-eos
  initial
  begin
    eos
   
    mem_blk = ""

      @memory.each { |k,v|
        mem_blk = mem_blk + "    mem[#{k}] = #{v}" 
      }

   memory = memory + mem_blk +  <<-eos
  end

    eos

    rom_file.puts @module
    rom_file.puts memory
    rom_file.puts clr_blk
    rom_file.puts read_write
    rom_file.puts "endmodule" 
    rom_file.close
  end


end


def run
  rom = RomCreate.new
  rom.parse
  rom.build
end


#build rom verilog file
run
