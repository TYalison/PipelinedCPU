`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 	TYalison
// 
// Create Date:    20:00:06 06/27/2017 
// Design Name: 
// Module Name:    PipeRegEM 
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
module PipeRegEM(
	input clk,
	input reset,
	input [4:0] WriteRegE,
	input [31:0] InstructionE,
	input [31:0] PCouter8E,
	input [31:0] ReadData2E,
	input [31:0] ALUOutE,
	
	output reg [4:0] WriteRegM,
	output reg [31:0] InstructionM,
	output reg [31:0] PCouter8M,
	output reg [31:0] ReadData2M,
	output reg [31:0] ALUOutM
    );

	always@(posedge clk) begin
		if(reset) begin
			WriteRegM<=5'b0;
			InstructionM<=32'b0;
			PCouter8M<=32'b0;
			ReadData2M<=32'b0;
			ALUOutM<=32'b0;
		end
		else begin
			WriteRegM<=WriteRegE;
			InstructionM<=InstructionE;
			PCouter8M<=PCouter8E;
			ReadData2M<=ReadData2E;
			ALUOutM<=ALUOutE;
		end
	end



endmodule
