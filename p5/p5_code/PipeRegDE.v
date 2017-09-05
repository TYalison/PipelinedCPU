`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 	TYalison
// 
// Create Date:    19:59:51 06/27/2017 
// Design Name: 
// Module Name:    PipeRegDE 
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
module PipeRegDE(
	input clk,
	input reset,
	input IDEX_CLR,
	input [31:0] InstructionD,
	input [31:0] PCounter8D,
	input [31:0] ReadData1D,
	input [31:0] ReadData2D,
	input [31:0] ExtOutD,
	
	output reg [31:0] InstructionE,
	output reg [31:0] PCounter8E,
	output reg [31:0] ReadData1E,
	output reg [31:0] ReadData2E,
	output reg [31:0] ExtOutE
  );
	
	always@(posedge clk) begin
		if(reset|IDEX_CLR) begin
			InstructionE<=32'b0;
			PCounter8E<=32'b0;
			ReadData1E<=32'b0;
			ReadData2E<=32'b0;
			ExtOutE<=32'b0;
		end
		else begin
			InstructionE<=InstructionD;
			PCounter8E<=PCounter8D;
			ReadData1E<=ReadData1D;
			ReadData2E<=ReadData2D;
			ExtOutE<=ExtOutD;
		end
	end

endmodule
