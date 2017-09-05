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
	input [1:0] AddrLow2,
	input [31:0] Read2Data,
	input [31:0] InstructionCur,

	output movn,
	output movz,
	output MemWrite,
	output [1:0] SwMode,
	output [3:0] ByteEnable
    );

	`include "CommonDecoder.txt"
	
	assign movn=(movnCur&&Read2Data!=32'b0)?1:0;
	assign movz=(movzCur&&Read2Data==32'b0)?1:0;
	assign MemWrite=StoCur;
	
	assign SwMode =(swlCur)?2'b01:
						(swrCur)?2'b10:2'b0;
						
	assign ByteEnable=(AddrLow2==2'b00&&(lbCur|lbuCur|sbCur))?4'b0001:
							(AddrLow2==2'b01&&(lbCur|lbuCur|sbCur))?4'b0010:
							(AddrLow2==2'b10&&(lbCur|lbuCur|sbCur))?4'b0100:
							(AddrLow2==2'b11&&(lbCur|lbuCur|sbCur))?4'b1000:
							(AddrLow2==2'b00&&(lhCur|lhuCur|shCur))?4'b0011:
							(AddrLow2==2'b10&&(lhCur|lhuCur|shCur))?4'b1100:
							(AddrLow2==2'b00&&(lwCur|swCur))?4'b1111:4'b0000;

endmodule
