#!/usr/bin/env ruby 

# Assembler EE 480
# Mike Rudy
# Russel Brooks
# Spring 2014 



class Assembler 

  def initialize
    @op_add = "0000" # "ADD" 
    @op_sub = "0001" #"SUB"
  end


  def parse
    file = File.open("test", "r")
    file_out = File.open("out", "w")

    file.each { |l|
      l = l.split

      case l[0]
      when "add"
        file_out.puts "#{@op_add} #{l[1]} #{l[2]}"
      when "sub" 
        file_out.puts "#{@op_sub} #{l[1]} #{l[2]}"
      end

    }

    file.close
    file_out.close

  end

end

def run 
  assemble = Assembler.new

  assemble.parse
end

#run script
run

