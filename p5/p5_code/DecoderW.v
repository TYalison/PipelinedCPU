`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 	TYalison
// 
// Create Date:    23:39:41 06/26/2017 
// Design Name: 
// Module Name:    DecoderW 
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
module DecoderW(
	input movz,
	input [31:0] InstructionCur,
	
	output RegWrite,
	output [1:0] MemtoReg,
	output [1:0] LwMode
    );
	
	`include "CommonDecoder.txt"
	
	assign RegWrite=LdCur|(CalRCur&&movzCur==0)|CalICur_Alg|CalICur_Log|CalSCur|jalCur|jalrCur|bgezalCur|bltzalCur|movz|bgealCur;
	
	assign MemtoReg = ((CalRCur&&movzCur==0)|movz|CalICur_Alg|CalICur_Log|CalSCur)?2'b01:
							(LdCur)?2'b10:
							(jalCur|jalrCur|bgezalCur|bltzalCur|bgealCur)?2'b11:2'b00;
	
	assign LwMode =(lwlCur)?2'b01:
						(lwrCur)?2'b10:2'b0;
						
endmodule
