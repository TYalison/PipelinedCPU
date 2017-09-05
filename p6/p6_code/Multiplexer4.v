`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 	TYalison
// 
// Create Date:    00:46:48 06/28/2017 
// Design Name: 
// Module Name:    Multiplexer5 
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
module Multiplexer4(//MUX4 #(32)
	input [2:0] select,
	input [31:0] IN1,
	input [31:0] IN2,
	input [31:0] IN3,
	input [31:0] IN4,

	output [31:0] OUT
    );

	assign OUT =(select==3'b001)?IN1:
					(select==3'b010)?IN2:
					(select==3'b011)?IN3:
					(select==3'b100)?IN4:32'b0;

endmodule
