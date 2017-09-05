`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 	TYalison
// 
// Create Date:    10:03:21 07/02/2017 
// Design Name: 
// Module Name:    Multiplexer6 
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
module Multiplexer6(//MUX6(32)
	input [2:0] select,
	input [31:0] IN1,
	input [31:0] IN2,
	input [31:0] IN3,
	input [31:0] IN4,
	input [31:0] IN5,
	input [31:0] IN6,

	output [31:0] OUT
    );

	assign OUT =(select==3'b001)?IN1:
					(select==3'b010)?IN2:
					(select==3'b011)?IN3:
					(select==3'b100)?IN4:
					(select==3'b101)?IN5:
					(select==3'b110)?IN6:32'b0;


endmodule
