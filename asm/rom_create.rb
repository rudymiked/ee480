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
    @header 
    @module
    @memory
  end

  def parse
    machine = File.open("test", "r")
    i = 0;
    machine.each_line { |l|
    break if (i==1)
    
    l = l.split
    
    name = l[1] if (l[0] =~ /#/)

    @file_name = "ROM_#{name}.v";
    i = 1

    }
    @header = <<-eos
##################################################################
##
## Michael Rudy & Russell Brooks
## University of Kentucky
## EE 480 Spring 2014
##
## Module: #{@file_name} 
## Dependencies: N/A
##
## Description: initial RAM module for #{@file_name} program
##
## Last Modified: Michael - 4/24/2014
##
##################################################################
    eos

  end


  def build
    rom_file = File.open(@file_name, "w")  
    rom_file.puts @header
    

    @module = <<-eos
module #{@file_name}(ce, reg_in, addr, rw, clk, clr, reg_out);

  parameter addr_width = 8, data_width = 8;
  input rw, clr, clk, ce;
  input [(data_width-1):0] reg_in;
  input [(addr_width-1):0] addr;

  output [(data_width-1):0] reg_out;
  reg [(data_width-1):0] reg_out;
  integer i;
  reg [(data_width-1):0] mem[((2**addr_width)-1):0];

    eos

    rom_file.puts @module
    rom_file.puts "end" 
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
