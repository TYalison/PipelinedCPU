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
	
	output ALUSrc1,
	output ALUSrc2,
	output Start,
	output HLSelect,
	output HLRegWrite,
	output [1:0] RegDst,
	output [2:0] MDOperator,
	output [4:0] Operator
    );
	
	`include "CommonDecoder.txt"
	
	assign ALUSrc1=CalSCur;
	assign ALUSrc2=LdCur|StoCur|CalICur_Alg|CalICur_Log;
	
	assign Start=CalHLCur;
	assign HLSelect=mthiCur;
	assign HLRegWrite=MtHLCur;
	
	assign MDOperator=(Start&multuCur)?3'b0:
							(Start&multCur)?3'b001:
							(Start&divuCur)?3'b010:
							(Start&divCur)?3'b011:
							(Start&maddCur)?3'b100:
							(Start&madduCur)?3'b101:
							(Start&msubCur)?3'b110:
							(Start&msubuCur)?3'b111:MDOperator;
	
	assign RegDst =(LdCur|CalICur_Alg|CalICur_Log)?2'b01://RT
						(CalRCur|movzCur|movnCur|CalSCur|jalrCur|MfHLCur)?2'b10://RD
						(jalCur|bgezalCur|bltzalCur|bgealCur)?2'b11:2'b00;
	
	assign Operator = (andCur|andiCur)?5'b00001:
							(orCur|oriCur)?5'b00010:
							(xorCur|xoriCur)?5'b00011:
							(norCur)?5'b00100:
							(LdCur|StoCur|addCur|adduCur|addiCur|addiuCur)?5'b00101:
							(subCur|subuCur)?5'b00110:
							(sllCur|sllvCur)?5'b00111:
							(srlCur|srlvCur)?5'b01000:
							(sraCur|sravCur)?5'b01001:
							(sltCur|sltiCur)?5'b01010:
							(sltuCur|sltiuCur)?5'b01011:
							(movzCur)?5'b01100:
							(sehCur)?5'b01101:
							(sebCur)?5'b01110:
							(rotrCur|rotrvCur)?5'b01111:
							(movnCur)?5'b10000:
							(cloCur)?5'b10001:
							(clzCur)?5'b10010:5'b0;

endmodule
