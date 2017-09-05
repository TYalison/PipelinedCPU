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
	output movn,
	output movz,
	output mfhi,
	output mflo,
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
	output CalHL,
	output MtHL,
	output MfHL
    );

	`include "CommonDecoder.txt"
	
	assign lwl=lwlCur;
	assign lwr=lwrCur;
	assign movn=movnCur;
	assign movz=movzCur;
	assign mfhi=mfhiCur;
	assign mflo=mfloCur;
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
	assign CalHL=CalHLCur;
	assign MtHL=MtHLCur;
	assign MfHL=MfHLCur;
	
endmodule
