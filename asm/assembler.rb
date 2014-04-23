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
    @op_out = "010001"  # OUTPUT WORD FROM RAM
    @op_msk = "010010"  # HVPI

  end

  def parse
    file = File.open("test", "r")
    file_out = File.open("out", "w")

    file.each { |l|
      l = l.split

      value = l[1].to_i
      bin_value = value.to_s(2)
      hex_value = value.to_s(16)

      case l[0]
      when "add"
        file_out.puts "#{@op_add} #{bin_value}"
      when "sub"
        file_out.puts "#{@op_sub} #{bin_value}"
      when "or"
        file_out.puts "#{@op_or} #{bin_value}"
      when "and"
        file_out.puts "#{@op_and} #{bin_value}" #{l[2]}"
      when "not" 
        file_out.puts "#{@op_not} #{bin_value}"
      when "mult" 
        file_out.puts "#{@op_mul} #{bin_value}"
      when "div" 
        file_out.puts "#{@op_div} #{bin_value}"
      when "asr" 
        file_out.puts "#{@op_asr} #{bin_value}"
      when "asl" 
        file_out.puts "#{@op_asl} #{bin_value}"
      when "bra" 
        file_out.puts "#{@op_bra} #{bin_value}"
      when "jmp" 
        file_out.puts "#{@op_jmp}"
      when "jsr" 
        file_out.puts "#{@op_jsr} #{bin_value}"
      when "rts" 
        file_out.puts "#{@op_rts}"
      when "isr"
        file_out.puts "#{@op_isr} #{bin_value}"
      when "ld" 
        file_out.puts "#{@op_ld} #{bin_value}"
      when "st" 
        file_out.puts "#{@op_st} #{bin_value}"
      when "in" 
        file_out.puts "#{@op_in} #{hex_value}"
      when "out" 
        file_out.puts "#{@op_out} #{hex_value}"
      when "msk"
        file_out.puts "#{@op_msk} #{bin_value}"
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

