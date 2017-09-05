`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 	TYalison
// 
// Create Date:    23:15:07 06/26/2017 
// Design Name: 
// Module Name:    Extender 
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
module Extender(
	input [1:0] Mode,
	input [15:0] Immediate16,
	
	output reg [31:0] Immediate32
    );
	
	always@(*) begin
		case(Mode)
			2'b01: Immediate32<={16'b0,Immediate16};//zero_high
			2'b10: Immediate32<={{16{Immediate16[15]}},Immediate16};//sign
			2'b11: Immediate32<={Immediate16,16'b0};//zero_low
			default: Immediate32<=32'b0;
		endcase
	end


endmodule
