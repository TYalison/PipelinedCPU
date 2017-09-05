`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 	TYalison
// 
// Create Date:    19:59:36 06/27/2017 
// Design Name: 
// Module Name:    PipeRegFD 
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
module PipeRegFD(
	input clk,
	input reset,
	input IFID_EN,
	input [31:0] InstructionF,
	input [31:0] PCounter4F,
	input [31:0] PCounter8F,
   
   output reg [31:0] InstructionD,
	output reg [31:0] PCounter4D,
   output reg [31:0] PCounter8D
  );	
	always@(posedge clk) begin
		if(reset) begin
			InstructionD<=32'b0;
			PCounter4D<=32'b0;
			PCounter8D<=32'b0;
		end
		else if(IFID_EN) begin
			InstructionD<=InstructionF;
			PCounter4D<=PCounter4F;
			PCounter8D<=PCounter8F;
		end
		else begin
			InstructionD<=InstructionD;
			PCounter4D<=PCounter4D;
			PCounter8D<=PCounter8D;
		end
	end
endmodule
