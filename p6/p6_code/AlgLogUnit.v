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
	input [31:0] Operand1,
	input [31:0] Operand2,
	
	output reg Over,
	output reg [31:0] Result
    );

	integer i;
	integer j;
	wire [4:0] Stemp=Operand1[4:0];
	
	always@(*) begin
		case(Operator)
			5'b00001: {Over,Result}<=Operand1&Operand2;//and|andi
			5'b00010: {Over,Result}<=Operand1|Operand2;//or|ori
			5'b00011: {Over,Result}<=Operand1^Operand2;//xor|xori
			5'b00100: {Over,Result}<=~(Operand1|Operand2);//nor
			5'b00101: {Over,Result}<=Operand1+Operand2;//add|addu|addi|addiu
			5'b00110: {Over,Result}<=Operand1-Operand2;//sub|subu
			5'b00111: {Over,Result}<=(Operand2<<Stemp);//sll|sllv
			5'b01000: {Over,Result}<=(Operand2>>Stemp);//srl|srlv
			5'b01001: {Over,Result}<=($signed(Operand2)>>>Stemp);//sra|srav
			5'b01010: {Over,Result}<=($signed(Operand1)<$signed(Operand2));//slt|slti
			5'b01011: {Over,Result}<=(Operand1<Operand2);//sltu|sltiu
			5'b01100: {Over,Result}<=(Operand2==32'b0)?Operand1:32'b0;//movz
			5'b01101: {Over,Result}<={{16{Operand2[15]}},Operand2[15:0]};//seh
			5'b01110: {Over,Result}<={{24{Operand2[7]}},Operand2[7:0]};//seb
			5'b01111: begin//rotr|rotrv
				for(i=0;i<Stemp;i=i+1)
					Result[31-i]<=Operand2[Stemp-1-i];
				for(j=0;j<32-Stemp;j=j+1) begin
					Result[31-i]<=Operand2[31-i];
					i=i+1;
				end
			end
			5'b10000: {Over,Result}<=(Operand2!=32'b0)?Operand1:32'b0;//movn
			5'b10001: begin//clo
				j=32;
				for(i=31;i>=0;i=i-1) begin
					if(Operand1[i]==0) begin
						j=31-i;
						i=0;
					end	
				end
				{Over,Result}<=j;
			end
			5'b10010: begin//clz
				j=32;
				for(i=31;i>=0;i=i-1) begin
					if(Operand1[i]==1) begin
						j=31-i;
						i=0;
					end	
				end
				{Over,Result}<=j;
			end
			default: {Over,Result}<=Operand2;
		endcase
	end

endmodule
