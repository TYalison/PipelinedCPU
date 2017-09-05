`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 	TYalison
// 
// Create Date:    20:39:10 07/09/2017 
// Design Name: 
// Module Name:    HazardDecoder 
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
module HazardDecoder(
	input [31:0] InstructionCur,
	
	output lwl,
	output lwr,
	output movz,
	output jr,
	output jal,
	output jalr,
	output bgezal,
	output bltzal,
	output bgeal,
	output CalR,
	output CalI_Alg,
	output CalI_Log,
	output CalS,
	output Ld,
	output Sto,
	output Br,
	output Brz,
	
	output [4:0] rs,
	output [4:0] rt,
	output [4:0] rd
    );

	`include "CommonDecoder.txt"
	
	assign lwl=lwlCur;
	assign lwr=lwrCur;
	assign movz=movzCur;
	assign jr=jrCur;
	assign jal=jalCur;
	assign jalr=jalrCur;
	assign bgezal=bgezalCur;
	assign bltzal=bltzalCur;
	assign bgeal=bgealCur;
	assign CalR=CalRCur;
	assign CalI_Alg=CalICur_Alg;
	assign CalI_Log=CalICur_Log;
	assign CalS=CalSCur;
	assign Ld=LdCur;
	assign Sto=StoCur;
	assign Br=BrCur;
	assign Brz=BrzCur;
	
	assign rs=rs_Cur;
	assign rt=rt_Cur;
	assign rd=rd_Cur;
	
endmodule
