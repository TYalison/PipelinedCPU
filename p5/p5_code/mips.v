`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 	TYalison
// 
// Create Date:    09:00:56 06/28/2017 
// Design Name: 
// Module Name:    mips 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module mips(
	input clk,
	input reset
    );
	//IF:
	wire			PC_EN;
	wire			nextEnable;
	wire [31:0]	PCounter;
	wire [31:0]	PCounter4F;
	wire [31:0]	PCounter8F;
	wire [31:0]	nextPCounter;
	wire [31:0]	newPCounter;
	wire [31:0]	InstructionF;
	//ID:
	wire			IFID_EN;
	wire 			Branch;
	wire [1:0]	Read1Select;
   wire [1:0]	Read2Select;
	wire [1:0]	rdDataSelect;
	wire [1:0]	ExtMode;
	wire [2:0]	NPCSelect;
	wire [2:0]	CmpMode;
	wire [31:0]	PCounter4D;
	wire [31:0]	PCounter8D;
	wire [31:0]	InstructionD;
	wire [31:0]	Read1;
	wire [31:0]	Read2;
	wire [31:0] rdData;
	wire [31:0]	Read1D;
	wire [31:0]	Read2D;
	wire [31:0] rdDataD;
	wire [31:0]	ExtOutD;
	//EX:
	wire			IDEX_CLR;
	wire			ALUSrc;
	wire [1:0]	RegDst;
	wire [2:0]	Opr1Select;
   wire [2:0]	Opr2Select;
	wire [4:0]	Operator;
	wire [4:0]	WriteRegE;
	wire [31:0]	PCounter8E;
	wire [31:0]	InstructionE;
	wire [31:0]	Read1E;
	wire [31:0]	Read2E;
	wire [31:0]	ExtOutE;
	wire [31:0] Operand1;
	wire [31:0] Operand2_temp;
	wire [31:0] Operand2;
	wire [31:0]	ALUOutE;
	//MEM:
	wire			movzM;
	wire			MemWrite;
	wire 			WriteSelect;
	wire [1:0]	SwMode;
	wire [4:0]	WriteRegM;
	wire [31:0]	WriteData;
	wire [31:0]	WriteM;
	wire [31:0]	PCounter8M;
	wire [31:0]	InstructionM;
	wire [31:0] ReadDataM;
	wire [31:0]	ALUOutM;
	//WB:
	wire			movzW;
	wire			RegWrite;
	wire [1:0]	MemtoReg;
	wire [1:0]	LwMode;
	wire [4:0]	WriteRegW;
	wire [31:0] ReadDataW;
	wire [31:0]	PCounter8W;
	wire [31:0]	InstructionW;
	wire [31:0]	Write;
	wire [31:0]	ALUOutW;

	Adder4			add4(PCounter,PCounter4F);
	Adder8			add8(PCounter,PCounter8F);
	NPCEnable		npcen(Branch,NPCSelect,nextEnable);
	Multiplexer2	mux2_pc(nextEnable,PCounter4F,nextPCounter,newPCounter);
	PC					pc(clk,reset,PC_EN,newPCounter,PCounter);
	InstrMemory		im(PCounter[11:2],InstructionF);

	PipeRegFD		ifid(clk,reset,IFID_EN,InstructionF,PCounter4F,PCounter8F,InstructionD,PCounter4D,PCounter8D);
	
	DecoderD			idctrl(InstructionD,ExtMode,NPCSelect,CmpMode);
	GenRegs			grf(clk,reset,RegWrite,LwMode,ALUOutW[1:0],InstructionD[25:21],InstructionD[20:16],InstructionD[15:11],WriteRegW,Write,Read1,Read2,rdData);
	Multiplexer3	mux3_rd1(Read1Select,Read1,ALUOutM,PCounter8M,Read1D);
	Multiplexer3	mux3_rd2(Read2Select,Read2,ALUOutM,PCounter8M,Read2D);
	Multiplexer3	mux3_rd(rdDataSelect,rdData,ALUOutM,PCounter8M,rdDataD);
	Comparator		cmp(CmpMode,Read1D,Read2D,Branch);
	NextPC			npc(NPCSelect,Read1D,rdDataD,PCounter4D,InstructionD,nextPCounter);
	Extender			ext(ExtMode,InstructionD[15:0],ExtOutD);
	
	PipeRegDE		idex(clk,reset,IDEX_CLR,InstructionD,PCounter8D,Read1D,Read2D,ExtOutD,InstructionE,PCounter8E,Read1E,Read2E,ExtOutE);
	
	DecoderE			exctrl(InstructionE,ALUSrc,RegDst,Operator);
	Multiplexer4	mux4_opr1(Opr1Select,Read1E,ALUOutM,PCounter8M,Write,Operand1);
	Multiplexer4	mux4_opr2(Opr2Select,Read2E,ALUOutM,PCounter8M,Write,Operand2_temp);
	Multiplexer2	mux2_opr2(ALUSrc,Operand2_temp,ExtOutE,Operand2);
	AlgLogUnit		alu(Operator,InstructionE[10:6],Operand1,Operand2,ALUOutE);
	MultiplexerR	mux3_wr(RegDst,InstructionE[20:16],InstructionE[15:11],5'b11111,WriteRegE);
	
	PipeRegEM		exmem(clk,reset,WriteRegE,InstructionE,PCounter8E,Operand2_temp,ALUOutE,WriteRegM,InstructionM,PCounter8M,WriteM,ALUOutM);
	
	DecoderM			memctrl(WriteM,InstructionM,movzM,MemWrite,SwMode);
	Multiplexer2	mux2_dwd(WriteSelect,WriteM,Write,WriteData);
	DataMemory		dm(clk,reset,MemWrite,SwMode,ALUOutM[1:0],ALUOutM[11:2],WriteData,ReadDataM);
	
	PipeRegMW		memwb(clk,reset,movzM,WriteRegM,InstructionM,PCounter8M,ReadDataM,ALUOutM,movzW,WriteRegW,InstructionW,PCounter8W,ReadDataW,ALUOutW);
	
	DecoderW			wbctrl(movzW,InstructionW,RegWrite,MemtoReg,LwMode);
	Multiplexer3	mux3_rwd(MemtoReg,ALUOutW,ReadDataW,PCounter8W,Write);
	
	Hazard			hazard(movzM,movzW,InstructionD,InstructionE,InstructionM,InstructionW,PC_EN,IFID_EN,IDEX_CLR,WriteSelect,Read1Select,Read2Select,rdDataSelect,Opr1Select,Opr2Select);
	

endmodule
