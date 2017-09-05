`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 	TYalison
// 
// Create Date:    22:41:01 06/26/2017 
// Design Name: 
// Module Name:    NextPC 
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
module NextPC(
	input [2:0] NPCSelect,
	input [31:0] ReadData1,
	input [31:0] rdData,
	input [31:0] PCounter4,
	input [31:0] Instruction,
	
	output reg [31:0] nextPCounter
   );
	
	wire [15:0] immediate16=Instruction[15:0];
	wire [25:0] InstrIndex=Instruction[25:0];
	
	always@(*) begin
		case(NPCSelect)
			3'b001: nextPCounter<=PCounter4+{{14{immediate16[15]}},immediate16,2'b0};//b
			3'b010: nextPCounter<={PCounter4[31:28],InstrIndex,2'b0};//j|jal
			3'b011: nextPCounter<=ReadData1;//jr|jalr
			3'b100: nextPCounter<=PCounter4+rdData;//bgeal
			default: nextPCounter<=PCounter4;
		endcase 
	end
endmodule
