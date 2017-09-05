`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 	TYalison
// 
// Create Date:    08:59:30 07/01/2017 
// Design Name: 
// Module Name:    MultDivReg 
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
module MultDivUnit(
	input clk,
	input reset,
	input Start,
	input HLSelect,
	input HLRegWrite,
	input [2:0] MDOperator,
	input [31:0] MDOperand1,
	input [31:0] MDOperand2,
	
	output reg Busy,
	output reg [31:0] HiData,
	output reg [31:0] LoData
    );
	 
	reg [3:0]  count;
	reg [31:0] HiReg;
	reg [31:0] LoReg;
	
	initial begin
		Busy=0;
		HiReg=32'b0;
		LoReg=32'b0;
	end

	always@(posedge clk) begin
		if(reset) begin
			HiReg<=32'b0;
			LoReg<=32'b0;
		end
		else if(Busy) begin
			count<=count+1;
			if(MDOperator[1]==0&&count==4'b0101||MDOperator[1]==1&&count==4'b1010)
				Busy<=0;
		end
		else if(Start) begin
			Busy<=1;
			count<=0;
			case(MDOperator)
				3'b000: {HiReg,LoReg}<={32'b0,MDOperand1}*{32'b0,MDOperand2};
				3'b001: {HiReg,LoReg}<={{32{MDOperand1[31]}},$signed(MDOperand1)}*{{32{MDOperand2[31]}},$signed(MDOperand2)};
				3'b010: begin//divu
					LoReg<=MDOperand1/MDOperand2;
					HiReg<=MDOperand1%MDOperand2;
				end
				3'b011: begin//div
					LoReg<=$signed(MDOperand1)/$signed(MDOperand2);
					HiReg<=$signed(MDOperand1)%$signed(MDOperand2);
				end
				3'b100: {HiReg,LoReg}<={HiReg,LoReg}+{{32{MDOperand1[31]}},$signed(MDOperand1)}*{{32{MDOperand2[31]}},$signed(MDOperand2)};
				3'b101: {HiReg,LoReg}<={HiReg,LoReg}+{32'b0,MDOperand1}*{32'b0,MDOperand2};
				3'b110: {HiReg,LoReg}<={HiReg,LoReg}-{{32{MDOperand1[31]}},$signed(MDOperand1)}*{{32{MDOperand2[31]}},$signed(MDOperand2)};
				3'b111: {HiReg,LoReg}<={HiReg,LoReg}-{32'b0,MDOperand1}*{32'b0,MDOperand2};	
			endcase
		end
		else if(HLRegWrite) begin
			if(HLSelect)
				HiReg<=MDOperand1;
			else
				LoReg<=MDOperand1;
		end
		HiData<=(HLRegWrite&&HLSelect==1)?MDOperand1:HiReg;
		LoData<=(HLRegWrite&&HLSelect==0)?MDOperand1:LoReg;
	end
endmodule
