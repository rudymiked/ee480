`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////
//
// Michael Rudy & Russell Brooks
// University of Kentucky
// EE 480 Spring 2014
//
// Module: controller.v
// Dependencies: N/A
//
// Description: Controls all the things
//
// Last Modified: Mike - 4/29/2014
//
//////////////////////////////////////////////////////////////////
module controller(opcode, clk, clr, pc, cmpr_out, in_bus_valid, ram_rdy, out_bus_valid, ram_valid, op_out, control);

  //State Declarations using One Hot Encoding
   reg [36:0] RESET  = 38'b00000000000000000000000000000000000001; //0
   reg [36:0] READ   = 38'b00000000000000000000000000000000000010;
   reg [36:0] HVPIS  = 38'b00000000000000000000000000000000000100;
   reg [36:0] ISR    = 38'b00000000000000000000000000000000001000;
   reg [36:0] JSR    = 38'b00000000000000000000000000000000010000;
   reg [36:0] RTS    = 38'b00000000000000000000000000000000100000; //5
   reg [36:0] BRA0   = 38'b00000000000000000000000000000001000000;
   reg [36:0] BRA1   = 38'b00000000000000000000000000000010000000;
   reg [36:0] JMP    = 38'b00000000000000000000000000000100000000;
   reg [36:0] EXE    = 38'b00000000000000000000000000001000000000;
   reg [36:0] ADD0   = 38'b00000000000000000000000000010000000000; //10
   reg [36:0] ADD1   = 38'b00000000000000000000000000100000000000;
   reg [36:0] SUB0   = 38'b00000000000000000000000001000000000000;
   reg [36:0] SUB1   = 38'b00000000000000000000000010000000000000;
   reg [36:0] OR0    = 38'b00000000000000000000000100000000000000;
	reg [36:0] OR1    = 38'b00000000000000000000001000000000000000; //15
   reg [36:0] AND0   = 38'b00000000000000000000010000000000000000;
   reg [36:0] AND1   = 38'b00000000000000000000100000000000000000;
   reg [36:0] MULT0  = 38'b00000000000000000001000000000000000000;
   reg [36:0] MULT1  = 38'b00000000000000000010000000000000000000;
   reg [36:0] DIV0   = 38'b00000000000000000100000000000000000000;  //20
   reg [36:0] DIV1   = 38'b00000000000000001000000000000000000000;
   reg [36:0] ASR0   = 38'b00000000000000010000000000000000000000;
   reg [36:0] ASR1   = 38'b00000000000000100000000000000000000000;
   reg [36:0] ASL0   = 38'b00000000000001000000000000000000000000;
   reg [36:0] ASL1   = 38'b00000000000010000000000000000000000000; //25
   reg [36:0] STR0   = 38'b00000000000100000000000000000000000000;
   reg [36:0] STR1   = 38'b00000000001000000000000000000000000000;
   reg [36:0] LOAD   = 38'b00000000010000000000000000000000000000;
   reg [36:0] IN0    = 38'b00000000100000000000000000000000000000;
   reg [36:0] IN1    = 38'b00000001000000000000000000000000000000;
   reg [36:0] IN2    = 38'b00000010000000000000000000000000000000;
   reg [36:0] OUT0   = 38'b00000100000000000000000000000000000000;
   reg [36:0] OUT1   = 38'b00001000000000000000000000000000000000;
   reg [36:0] OUT2   = 38'b00010000000000000000000000000000000000;
   reg [36:0] NOT0   = 38'b00100000000000000000000000000000000000;
   reg [36:0] NOT1   = 38'b01000000000000000000000000000000000000;
   reg [36:0] ILLOP  = 38'b10000000000000000000000000000000000000;


  input [5:0] opcode;
  input clk, pc, clr, cmpr_out;
  input in_bus_valid, ram_rdy, out_bus_valid, ram_valid; // 2-way hand shaking variables
  output [5:0] op_out;
  output [16:0] control; // all control bits that flow through the pipeline
  
  reg [36:0] pres_state;
  reg [36:0] next_state;
  reg MEM_write, MEM_read, mask_ctrl, MDR_mux, MDR_out, PC_stk_st, PC_stk_ld, JSR_ctrl, ACC_ctrl, ILLOP_ctrl, MDR_ctrl;
  reg [3:0] ALU_ctrl;
  reg  ALU_mux;
  reg  ACC_mux;
  
  initial
  begin
    mask_ctrl = 0;
	 MDR_out = 0;
	 PC_stk_st = 0;
	 PC_stk_ld = 0;
	 JSR_ctrl = 0;
	 ACC_ctrl = 0;
	 ILLOP_ctrl = 0;
	 MDR_ctrl = 0;
	 ALU_ctrl = 0;
    ALU_mux = 0;
    MDR_mux = 0;
    ACC_mux = 0;
	 MEM_read = 0;
	 MEM_write = 0;
  end

  assign op_out = opcode;
  assign control = {MEM_write, MEM_read, mask_ctrl, MDR_out, PC_stk_st, PC_stk_ld, JSR_ctrl, ACC_ctrl, ILLOP_ctrl, MDR_ctrl, ALU_ctrl[3:0], ALU_mux, MDR_mux, ACC_mux};
  
  always@(posedge clk)
  begin
    if(!clr)
	 begin
	   pres_state <= RESET; 
 	   next_state <= RESET; 
	 end
    else
    begin
      pres_state <= next_state;
    end 
  end  

  always @ (*)
  begin
    if (!clr) next_state = RESET;
	 else
	 begin
	   case (pres_state)
		  RESET:
		    next_state <= READ;
		  READ:
		  begin
		    if (opcode == 6'b010010 || opcode == 6'b001101 || opcode == 6'b001011 || opcode == 6'b001100 || opcode == 6'b001001)
			 begin
			   case (opcode)
			    6'b010010 : next_state = HVPIS;
				  6'b001101 : next_state = ISR;
				  6'b001011 : next_state = JSR;
				  6'b001100 : next_state = RTS;
				  6'b001001 : next_state = BRA0;
				  default   : next_state = ILLOP;
				endcase
			 end
			 else 
			   next_state = EXE;			  
		  end	  
		  HVPIS:
		    next_state = READ;
		  ISR:
		    next_state = READ;
		  JSR:
		    next_state = READ;
		  RTS:
		    next_state = READ;
		  BRA0:
          if (cmpr_out)			 
		      next_state = BRA1;
	       else
		      next_state = READ;
		  BRA1:
		    next_state = READ;
		  EXE:
		  begin
		    case (opcode)
			     6'b000000 : next_state = ADD0;
				  6'b000001 : next_state = SUB0;
				  6'b000010 : next_state = OR0;
				  6'b000011 : next_state = AND0;
				  6'b000100 : next_state = NOT0;
				  6'b000101 : next_state = MULT0;
				  6'b000110 : next_state = DIV0;
				  6'b000111 : next_state = ASR0;
				  6'b001000 : next_state = ASL0;
				  //6'b001001 BRA0
				  6'b001010 : next_state = JMP;
				  //6'b001011 JSR
				  //6'b001100 RTS
				  //6'b001101 ISR
				  6'b001110 : next_state = LOAD;
				  6'b001111 : next_state = STR0;
				  6'b010000 : next_state = IN0;
				  6'b010001 : next_state = OUT0;
				  //6'b010010 HPVIS
				  default   : next_state = ILLOP;
		    endcase
		  end
		  ADD0:
		    next_state = ADD1;
		  ADD1:
		    next_state = READ;
		  SUB0:
		    next_state = SUB1;
		  SUB1:  
		    next_state = READ;
		  OR0:
		    next_state = OR1;
		  OR1:
		    next_state = READ;
		  AND0:
		    next_state = AND1;
		  AND1:
		    next_state = READ;
		  MULT0:
		    next_state = MULT1;
		  MULT1: 
		    next_state = READ;
		  DIV0:
		    next_state = DIV1;
		  DIV1:
		    next_state = READ;
		  ASR0:
		    next_state = ASR1;
		  ASR1:
		    next_state = READ;
		  ASL0:
		    next_state = ASL1;
		  ASL1:
		    next_state = READ;
		  STR0:
		    next_state = STR1;
		  STR1:
		    next_state = READ;
		  LOAD:
		    next_state = READ;
		  IN0:
		   if (in_bus_valid)
		     next_state = IN1;
       else 
         next_state = IN0;
		  IN1:
       if(ram_rdy)
		      next_state = IN2;
       else 
        next_state = IN1;
		  IN2:
		    next_state = READ;
		  OUT0:
		   if(ram_valid)
		     next_state = OUT1;
       else 
         next_state = OUT0;
		  OUT1:
		   if(out_bus_valid)
		     next_state = OUT2;
       else 
         next_state = OUT1;
		  OUT2:
		    next_state = READ;
		  NOT0:
		    next_state = NOT1;
		  NOT1:
		    next_state = READ;
		  JMP:
		    next_state <= READ;
		  ILLOP: 
		    next_state = RESET;
		  default : next_state = RESET;
		endcase
    end
  end
  
always @ (*)
  begin
    if (!clr) next_state = RESET;
	 else
	 begin
	   case (pres_state)
		  RESET:
		  begin
		    next_state <= READ;
			 mask_ctrl <= 0;
		    MDR_out <= 0;
		    PC_stk_st <= 0;
		    PC_stk_ld <= 0;
		    JSR_ctrl <= 0;
		    ACC_ctrl <= 0;
		    ILLOP_ctrl <= 0;
		    MDR_ctrl <= 0;
	       ALU_ctrl <= 0;
          ALU_mux <= 0;
          MDR_mux <= 0;
          ACC_mux <= 0;
			 MEM_read <= 0;
			 MEM_write <= 0;
		  end
		  READ:
		    begin
				case(opcode)
				    6'b000000 : MEM_read = 1;
				    6'b000001 : MEM_read = 1;
				    6'b000010 : MEM_read = 1;
				    6'b000011 : MEM_read = 1;
				    6'b000100 : MEM_read = 1;
				    6'b000101 : MEM_read = 1;
				    6'b000110 : MEM_read = 1;
				    6'b000111 : MEM_read = 1;
				    6'b001000 : MEM_read = 1;
				    //6'b001001 BRA0
				    6'b001010 : MEM_read = 1;
				    //6'b001011 JSR
				    //6'b001100 RTS
				    //6'b001101 ISR
				    6'b001110 : MEM_read = 1;
				    6'b001111 : MEM_read = 1;
				    6'b010000 : MEM_read = 1;
				    6'b010001 : MEM_read = 1;
				    //6'b010010 HPVIS
				    default   : MEM_read = 0;
				endcase
   			end  		  
		  HVPIS:
		  begin
		    mask_ctrl = 1;
			 MDR_ctrl  = 0;
			 PC_stk_st = 1;
		  end	 
		  ISR:
		    PC_stk_ld = 1;
		  JSR:
		    PC_stk_st = 1;
		  RTS:
		    PC_stk_ld = 1;
		  BRA0:
          ALU_mux = 1;			 
		  BRA1:
		    JSR_ctrl = 1;
		  EXE:
		  begin
		    MEM_read = 0;
		    MDR_ctrl = 1;
			 MDR_mux = 0;
		  end
		  ADD0:
		  begin
		    ALU_ctrl = 4'b0000;
        MDR_ctrl = 0;			 
		  end
		  ADD1:
		  begin
		    ACC_ctrl = 1;
			  ACC_mux = 0;
		  end
		  SUB0:
		  begin
		    ALU_ctrl = 4'b0001;
        MDR_ctrl = 0;			 
		  end
		  SUB1:  
		  begin
		    ACC_ctrl = 1;
			  ACC_mux = 0;
		  end
		  OR0:
		  begin
		    ALU_ctrl = 4'b0100;
        MDR_ctrl = 0;			 
		  end
		  OR1:
		  begin
		    ACC_ctrl = 1;
			 ACC_mux = 0;
		  end
		  AND0:
		  begin
		    ALU_ctrl = 4'b0010;
        MDR_ctrl = 0;			 
		  end
		  AND1:
		  begin
		    ACC_ctrl = 1;
			  ACC_mux = 0;
		  end
		  MULT0:
		  begin
		    ALU_ctrl = 4'b1001;
        MDR_ctrl = 0;			 
		  end
		  MULT1: 
		  begin
		    ACC_ctrl = 1;
			 ACC_mux = 0;
		  end
		  DIV0:
		  begin
		    ALU_ctrl = 4'b1100;
          MDR_ctrl = 0;			 
		  end
		  DIV1:
		  begin
		    ACC_ctrl = 1;
		    ACC_mux = 0;
		  end
		  ASR0:
		  begin
		    ALU_ctrl = 4'b1011;
          MDR_ctrl = 0;			 
		  end
		  ASR1:
		  begin
		    ACC_ctrl = 1;
		    ACC_mux = 0;
		  end
		  ASL0:
		  begin
		    ALU_ctrl = 4'b1000;
        MDR_ctrl = 0;			 
		  end
		  ASL1:
		  begin
		    ACC_ctrl = 1;
		    ACC_mux = 0;
		  end
		  STR0:
		  begin
		    MDR_ctrl = 1;
          MDR_mux  = 1;
		  end
		  STR1:
		  begin
		    MDR_ctrl = 0;
			 //mem mux
			 MEM_write = 1;
		  end
		  LOAD:
		  begin
		    MDR_ctrl = 1;
          MDR_mux  = 1;
		    ACC_mux  = 1;
		  end
		  IN0: //write
		  //mem mux
		    MEM_write = 1;//check_memory
		  OUT0: //read
		    MEM_read = 0;//check_memory
		  NOT0:
		  begin
		    ALU_ctrl = 4'b1010;
		    MDR_ctrl = 0;
		  end
		  NOT1:
		  begin
		    ACC_ctrl = 1;
		    ACC_mux  = 0;
		  end
		  default : ILLOP_ctrl = 1;
		endcase		 
    end
  end
	


endmodule
