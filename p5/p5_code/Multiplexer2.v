`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 	TYalison
// 
// Create Date:    22:45:17 06/26/2017 
// Design Name: 
// Module Name:    Multiplexer2 
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
module Multiplexer2(//MUX2 #(32)
	input select,
	input [31:0] IN0,
	input [31:0] IN1,
	
	output [31:0] OUT
    );

	assign OUT=(select==1)?IN1:IN0;


endmodule
