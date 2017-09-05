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
	input [2:0] Mode,
	input [10:6] Immediate5,
	input [15:0] Immediate16,
	
	output reg [31:0] Immediate32
    );
	
	always@(*) begin
		case(Mode)
			3'b001: Immediate32<={16'b0,Immediate16};//zero_high_16b
			3'b010: Immediate32<={{16{Immediate16[15]}},Immediate16};//sign_16b
			3'b011: Immediate32<={Immediate16,16'b0};//zero_low_16b
			3'b100: Immediate32<={27'b0,Immediate5};//sa_zero_high_5b
			default: Immediate32<=32'b0;
		endcase
	end


endmodule
