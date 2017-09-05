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
	input movn,
	input movz,
	input [31:0] InstructionCur,
	
	output RegWrite,
	output [1:0] LwMode,
	output [1:0] BExtMode,
	output [2:0] MemtoReg
    );
	
	`include "CommonDecoder.txt"
	
	assign RegWrite=LdCur|CalRCur|movz|movn|CalICur_Alg|CalICur_Log|CalSCur|jalCur|jalrCur|bgezalCur|bltzalCur|bgealCur|MfHLCur;
	
	assign LwMode =(lwlCur)?2'b01:
						(lwrCur)?2'b10:2'b0;
						
	assign BExtMode = (lbCur)?2'b01:
							(lhCur)?2'b10:2'b00;
	
	assign MemtoReg = (CalRCur|movz|movn|CalICur_Alg|CalICur_Log|CalSCur)?3'b001:
							(LdCur)?3'b010:
							(jalCur|jalrCur|bgezalCur|bltzalCur|bgealCur)?3'b011:
							(mfhiCur)?3'b100:
							(mfloCur)?3'b101:3'b000;

endmodule
