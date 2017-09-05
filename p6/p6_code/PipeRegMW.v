`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 	TYalison
// 
// Create Date:    20:00:16 06/27/2017 
// Design Name: 
// Module Name:    PipeRegMW 
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
module PipeRegMW(
	input clk,
	input reset,
	input movnM,
	input movzM,
	input [4:0] WriteRegM,
	input [31:0] InstrutionM,
	input [31:0] PCouter8M,
	input [31:0] ReadDataM,
	input [31:0] ALUOutM,
	input [31:0] HiDataM,
	input [31:0] LoDataM,
	
	output reg movnW,
	output reg movzW,
	output reg [4:0] WriteRegW,
	output reg [31:0] InstrutionW,
	output reg [31:0] PCouter8W,
	output reg [31:0] ReadDataW,
	output reg [31:0] ALUOutW,
	output reg [31:0] HiDataW,
	output reg [31:0] LoDataW
    );
	always@(posedge clk) begin
		if(reset) begin
			movnW<=0;
			movzW<=0;
			WriteRegW<=5'b0;
			InstrutionW<=32'b0;
			PCouter8W<=32'b0;
			ReadDataW<=32'b0;
			ALUOutW<=32'b0;
			HiDataW<=32'b0;
			LoDataW<=32'b0;
		end
		else begin
			movnW<=movnM;
			movzW<=movzM;
			WriteRegW<=WriteRegM;
			InstrutionW<=InstrutionM;
			PCouter8W<=PCouter8M;
			ReadDataW<=ReadDataM;
			ALUOutW<=ALUOutM;
			HiDataW<=HiDataM;
			LoDataW<=LoDataM;
		end
	end
endmodule
