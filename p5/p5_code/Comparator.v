`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 	TYalison
// 
// Create Date:    19:41:10 06/27/2017 
// Design Name: 
// Module Name:    Comparator 
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
module Comparator(
	input [2:0] CmpMode,
	input [31:0] NUM1,
	input [31:0] NUM2,
	
	output reg Branch
   );

	always@(*) begin
		case(CmpMode)
			3'b001: Branch<=(NUM1==NUM2)?1:0;
			3'b010: Branch<=(NUM1!=NUM2)?1:0;
			3'b011: Branch<=($signed(NUM1)>0)?1:0;
			3'b100: Branch<=(NUM1[31]==0)?1:0;
			3'b101: Branch<=(NUM1[31]==1)?1:0;
			3'b110: Branch<=(NUM1[31]==1||NUM1==32'b0)?1:0;
			3'b111: Branch<=($signed(NUM1)>=$signed(NUM2))?1:0;
			default: Branch<=0;
		endcase
	end
endmodule
