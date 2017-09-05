`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 	TYalison
// 
// Create Date:    21:27:23 07/03/2017 
// Design Name: 
// Module Name:    NPCEnable 
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
module NPCEnable(
	input Branch,
	input [2:0] NPCSelect,
	
	output nextEnable
    );
	
	assign nextEnable=(Branch||NPCSelect==3'b010||NPCSelect==3'b011)?1:0;
	
endmodule
