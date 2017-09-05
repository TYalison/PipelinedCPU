`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 	TYalison
// 
// Create Date:    23:39:29 06/26/2017 
// Design Name: 
// Module Name:    DecoderM 
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
module DecoderM(
	input [31:0] Read2Data,
	input [31:0] InstructionCur,

	output movz,
	output MemWrite,
	output [1:0] SwMode
    );
	
	`include "CommonDecoder.txt"
	
	assign movz=(movzCur&&Read2Data==32'b0)?1:0;
	assign MemWrite=StoCur;
	assign SwMode =(swlCur)?2'b01:
						(swrCur)?2'b10:2'b0;

endmodule
