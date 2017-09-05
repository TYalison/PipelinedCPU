`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 	TYalison
// 
// Create Date:    22:59:38 06/26/2017 
// Design Name: 
// Module Name:    Adder4 
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
module Adder4(
	input [31:0] IN,
	
	output [31:0] OUT
   );
	
	assign OUT=IN+4;

endmodule
