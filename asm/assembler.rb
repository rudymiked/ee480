#!/usr/bin/env ruby  

#
# Assembler EE480
# Mike Rudy
# Russel Brooks
# Spring 2014 
#


class Assembler 

  def initialize
    #Binary values for OpCodes

    @op_add = "000000"  # ADD 
    @op_sub = "000001"  # SUB 
    @op_or  = "000010"  # OR 
    @op_and = "000011"  # AND
    @op_not = "000100"  # NOT
    @op_mul = "000101"  # MULT
    @op_div = "000110"  # DIV
    @op_asr = "000111"  # ASR
    @op_asl = "001000"  # LSR
    @op_bra = "001001"  # CONDITIONAL BRANCH
    @op_jmp = "001010"  # JUMP
    @op_jsr = "001011"  # JUMP TO SUB
    @op_rts = "001100"  # RETURN FROM SUB
    @op_isr = "001101"  # RETURN FROM INTERRUPT
    @op_ld  = "001110"  # LOAD TO RAM
    @op_st  = "001111"  # STORE TO RAM
    @op_in  = "010000"  # INPUT WORD TO RAM
    @op_asl = "010001"  # OUTPUT WORD FROM RAM
    @op_msk = "010010"  # HVPI

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
      when "bne" 
        file_out.puts "#{@op_bne} #{l[1]} #{l[2]} #{l[3]}"
      when "beq" 
        file_out.puts "#{@op_beq} #{l[1]} #{l[2]} #{l[3]}"
      when "in" 
        file_out.puts "#{@op_in} #{l[1]}"
      when "out" 
        file_out.puts "#{@op_out} #{l[1]}"
      when "asr"
        file_out.puts "#{@op_asr} #{l[1]}"
      when "asl"
        file_out.puts "#{@op_asl} #{l[1]}"
      when "\#"
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

