`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 	TYalison
// 
// Create Date:    22:46:31 06/26/2017 
// Design Name: 
// Module Name:    Multiplexer3 
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
module Multiplexer3(//MUX3 #(32)
	input [1:0] select,
	input [31:0] IN1,
	input [31:0] IN2,
	input [31:0] IN3,
	
	output [31:0] OUT
    );

	assign OUT =(select==2'b01)?IN1:
					(select==2'b10)?IN2:
					(select==2'b11)?IN3:32'b0;


endmodule
