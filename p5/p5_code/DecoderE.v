`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 	TYalison
// 
// Create Date:    22:43:11 06/26/2017 
// Design Name: 
// Module Name:    DecoderE 
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
module DecoderE(
	input [31:0] InstructionCur,
	
	output ALUSrc,
	output [1:0] RegDst,
	output [4:0] Operator
    );
	
	`include "CommonDecoder.txt"
	
	assign ALUSrc=LdCur|StoCur|CalICur_Alg|CalICur_Log;
	
	assign RegDst =(LdCur|CalICur_Alg|CalICur_Log)?2'b01://RT
						(CalRCur|CalSCur|jalrCur)?2'b10://RD
						(jalCur|bgezalCur|bltzalCur|bgealCur)?2'b11:2'b00;
	
	assign Operator = (andCur|andiCur)?5'b00001:
							(orCur|oriCur)?5'b00010:
							(xorCur|xoriCur)?5'b00011:
							(norCur)?5'b00100:
							(LdCur|StoCur|addCur|adduCur|addiCur|addiuCur)?5'b00101:
							(subCur|subuCur)?5'b00110:
							(sllCur)?5'b00111:
							(sllvCur)?5'b01000:
							(srlCur)?5'b01001:
							(srlvCur)?5'b01010:
							(sraCur)?5'b01011:
							(sravCur)?5'b01100:
							(sltCur|sltiCur)?5'b01101:
							(sltuCur|sltiuCur)?5'b01110:
							(movzCur)?5'b01111:
							(sehCur)?5'b10000:
							(sebCur)?5'b10001:5'b0;

endmodule
