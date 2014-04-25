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

  end


end


def run
  rom = RomCreate.new
  rom.parse
  rom.build
end


#build rom verilog file
run
