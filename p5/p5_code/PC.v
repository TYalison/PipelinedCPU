`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 	TYalison
// 
// Create Date:    22:37:13 06/26/2017 
// Design Name: 
// Module Name:    PC 
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
module PC(
	input clk,
	input reset,
	input PC_EN,
	input [31:0] nextPCounter,
	
	output reg [31:0] PCounter
    );
	
	initial begin
		PCounter=32'h00003000;
	end

	always@(posedge clk) begin
		if(reset)
			PCounter<=32'h00003000;
		else if(PC_EN)
			PCounter<=nextPCounter;
		else
			PCounter<=PCounter;
	end
	
endmodule
