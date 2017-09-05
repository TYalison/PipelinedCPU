`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 	TYalison
// 
// Create Date:    23:02:14 06/26/2017 
// Design Name: 
// Module Name:    AlgLogUnit 
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
module AlgLogUnit(
	input [4:0] Operator,
	input [4:0] OperandSa,
	input [31:0] Operand1,
	input [31:0] Operand2,
	
	output reg [31:0] Result
    );

	always@(*) begin
		case(Operator)
			5'b00001: Result<=Operand1&Operand2;//and|andi
			5'b00010: Result<=Operand1|Operand2;//or|ori
			5'b00011: Result<=Operand1^Operand2;//xor|xori
			5'b00100: Result<=~(Operand1|Operand2);//nor
			5'b00101: Result<=Operand1+Operand2;//add|addu|addi|addiu
			5'b00110: Result<=Operand1-Operand2;//sub|subu
			5'b00111: Result<=(Operand2<<OperandSa);//sll
			5'b01000: Result<=(Operand2<<(Operand1[4:0]));//sllv
			5'b01001: Result<=(Operand2>>OperandSa);//srl
			5'b01010: Result<=(Operand2>>(Operand1[4:0]));//srlv
			5'b01011: Result<=($signed(Operand2)>>>OperandSa);//sra
			5'b01100: Result<=($signed(Operand2)>>>(Operand1[4:0]));//srav
			5'b01101: Result<=($signed(Operand1)<$signed(Operand2));//slt|sltu
			5'b01110: Result<=(Operand1<Operand2);//sltu|sltiu
			5'b01111: Result<=(Operand2==32'b0)?Operand1:32'b0;//movz
			5'b10000: Result<={{16{Operand2[15]}},Operand2[15:0]};//seh
			5'b10001: Result<={{24{Operand2[7]}},Operand2[7:0]};//seb
			default: Result<=Operand2;
		endcase
	end

endmodule
