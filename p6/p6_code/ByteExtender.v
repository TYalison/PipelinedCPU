`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 	TYalison
// 
// Create Date:    10:55:52 07/01/2017 
// Design Name: 
// Module Name:    ByteExtender 
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
module ByteExtender(
	input [1:0]  BExtMode,
	input [31:0] ByteData,
	
	output reg [31:0] ExtRead
    );

	always@(*) begin
		case(BExtMode)
			2'b01: ExtRead<={{24{ByteData[7]}},ByteData[7:0]};//lb
			2'b10: ExtRead<={{16{ByteData[15]}},ByteData[15:0]};//lh
			default: ExtRead<=ByteData;//lbu|lhu|lw
		endcase
	end
	
endmodule
