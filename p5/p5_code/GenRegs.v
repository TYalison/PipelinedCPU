`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 	TYalison
// 
// Create Date:    22:18:19 06/26/2017 
// Design Name: 
// Module Name:    GenRegs 
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
module GenRegs(
	input clk,
	input reset,
	input RegWrite,
	input [1:0] LwMode,
	input [1:0] AddrLow2,
	input [4:0] Read1Reg,//RS
	input [4:0] Read2Reg,//RT
	input [4:0] ReadReg,//RD
	input [4:0] WriteReg,
	input [31:0] Write,
	
	output [31:0] ReadData1,
	output [31:0] ReadData2,
	output [31:0] rdData
   );
	
	integer i;
	reg [31:0] regs[31:0];
	wire [31:0] WriteData;
	
	initial begin
		for(i=0;i<32;i=i+1) regs[i]=32'b0;
	end
	
	assign WriteData =(LwMode==2'b01&&AddrLow2==2'b00)?{Write[7:0],regs[WriteReg][23:0]}:
							(LwMode==2'b01&&AddrLow2==2'b01)?{Write[15:0],regs[WriteReg][15:0]}:
							(LwMode==2'b01&&AddrLow2==2'b10)?{Write[23:0],regs[WriteReg][7:0]}:
							(LwMode==2'b10&&AddrLow2==2'b01)?{regs[WriteReg][31:24],Write[31:8]}:
							(LwMode==2'b10&&AddrLow2==2'b10)?{regs[WriteReg][31:16],Write[31:16]}:
							(LwMode==2'b10&&AddrLow2==2'b11)?{regs[WriteReg][31:8],Write[31:24]}:Write;							
	
	assign ReadData1 =(Read1Reg==5'b0)?32'b0:
							(Read1Reg==WriteReg&&RegWrite)?WriteData:regs[Read1Reg];
	assign ReadData2 =(Read2Reg==5'b0)?32'b0:
							(Read2Reg==WriteReg&&RegWrite)?WriteData:regs[Read2Reg];
							
	assign rdData =(ReadReg==5'b0)?32'b0:
						(ReadReg==WriteReg&&RegWrite)?WriteData:regs[ReadReg];
	
	always@(posedge clk) begin
		if(reset) begin
			for(i=0;i<32;i=i+1)
				regs[i]<=32'b0;
		end
		else begin
			if(RegWrite&&WriteReg!=5'b0) begin
				regs[WriteReg]<=WriteData;
				$display("$%d <= %h",WriteReg,WriteData);
			end
		end
	end

endmodule
