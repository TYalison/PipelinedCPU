`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 	TYalison
// 
// Create Date:    18:39:30 06/27/2017 
// Design Name: 
// Module Name:    DecoderD 
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
module DecoderD(
	input [31:0] InstructionCur,
	
	output [1:0] ExtMode,
	output [2:0] NPCSelect,
	output [2:0] CmpMode
    );
	
	`include "CommonDecoder.txt"
	
	assign ExtMode=(andiCur|oriCur|xoriCur)?2'b01:
						(LdCur|StoCur|CalICur_Alg)?2'b10:
						(luiCur)?2'b11:2'b00;
	
	assign NPCSelect =((BrCur&&bgealCur==0)|BrzCur)?3'b001:
							(jCur|jalCur)?3'b010:
							(jrCur|jalrCur)?3'b011:
							(bgealCur)?3'b100:3'b000;
	
	assign CmpMode=(beqCur)?3'b001:
						(bneCur)?3'b010:
						(bgtzCur)?3'b011:
						(bgezCur|bgezalCur)?3'b100:
						(bltzCur|bltzalCur)?3'b101:
						(blezCur)?3'b110:
						(bgealCur)?3'b111:3'b000;
	
endmodule
