#!/usr/bin/env ruby  

#
# Assembler EE 480
# Mike Rudy
# Russel Brooks
# Spring 2014 
#



class Assembler 

  def initialize
    @op_and = "0000"   # AND 
    @op_add = "0001"   # ADD 
    @op_sub = "0010"   # SUB
    @op_jmp = "100000" # JUMP
    @op_mov = "1001"   # MOVE
    @op_in  = "101100" # IN
    @op_out = "101101" # OUT
    @op_bne = "01110"  # BNE
    @op_beq = "01111"  # BEQ
  end


  def parse
    file = File.open("test", "r")
    file_out = File.open("out", "w")

    file.each { |l|
      l = l.split
      case l[0]
      when "and"
        file_out.puts "#{@op_and} #{l[1]} #{l[2]}"
      when "add"
        file_out.puts "#{@op_add} #{l[1]} #{l[2]}"
      when "sub" 
        file_out.puts "#{@op_sub} #{l[1]} #{l[2]}"
      when "jmp" 
        file_out.puts "#{@op_jmp} #{l[1]} #{l[2]}"
      when "mov" 
        file_out.puts "#{@op_mov} #{l[1]} #{l[2]}"
      when "in" 
        file_out.puts "#{@op_in} #{l[1]}"
      when "out" 
        file_out.puts "#{@op_out} #{l[1]}"

      when "\""
        next
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

#Run Assembler
run

