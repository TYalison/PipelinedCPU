`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 	TYalison
// 
// Create Date:    23:07:20 06/26/2017 
// Design Name: 
// Module Name:    DataMemory 
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
module DataMemory(//8KB
	input clk,
	input reset,
	input MemWrite,
	input [1:0] SwMode,
	input [1:0] AddrLow2,
	input [3:0]  ByteEnable,
	input [12:2] DataAddr,//ALUOutM[12:2]
	input [31:0] WriteData,
	
	output [31:0] ReadData
    );
	
	integer i;
	reg [31:0] mem[2047:0];
	
	initial begin
		for(i=0;i<2048;i=i+1)
			mem[i]=32'b0;
	end

	assign ReadData = (ByteEnable==4'b0001)?{24'b0,mem[DataAddr][7:0]}:
							(ByteEnable==4'b0010)?{24'b0,mem[DataAddr][15:8]}:
							(ByteEnable==4'b0011)?{16'b0,mem[DataAddr][15:0]}:
							(ByteEnable==4'b0100)?{24'b0,mem[DataAddr][23:16]}:
							(ByteEnable==4'b1000)?{24'b0,mem[DataAddr][31:24]}:
							(ByteEnable==4'b1100)?{16'b0,mem[DataAddr][31:16]}:mem[DataAddr];
	
	always@(posedge clk) begin
		if(reset) begin
			for(i=0;i<2048;i=i+1)
				mem[i]<=32'b0;
		end
		else begin
			if(MemWrite) begin
				case(ByteEnable)
					4'b0001: begin
						mem[DataAddr][7:0]<=WriteData[7:0];
						$display("*%h <= %h",{22'b0,DataAddr,2'b00},WriteData[7:0]);
					end
					4'b0010: begin
						mem[DataAddr][15:8]<=WriteData[7:0];
						$display("*%h <= %h",{22'b0,DataAddr,2'b01},WriteData[7:0]);
					end
					4'b0011: begin
						mem[DataAddr][15:0]<=WriteData[15:0];
						$display("*%h <= %h",{22'b0,DataAddr,2'b00},WriteData[15:0]);
					end
					4'b0100: begin
						mem[DataAddr][23:16]<=WriteData[7:0];
						$display("*%h <= %h",{22'b0,DataAddr,2'b10},WriteData[7:0]);
					end
					4'b1000: begin
						mem[DataAddr][31:14]<=WriteData[7:0];
						$display("*%h <= %h",{22'b0,DataAddr,2'b11},WriteData[7:0]);
					end
					4'b1100: begin
						mem[DataAddr][31:16]<=WriteData[15:0];
						$display("*%h <= %h",{22'b0,DataAddr,2'b10},WriteData[15:0]);
					end
					4'b1111: begin
						mem[DataAddr]<=WriteData;
						$display("*%h <= %h",{22'b0,DataAddr,2'b00},WriteData);
					end
					default: begin
						case(AddrLow2)
							2'b00: begin
								if(SwMode==2'b01) begin//swl
									mem[DataAddr][7:0]<=WriteData[31:24];
									$display("*%h <= %h",{20'b0,DataAddr,2'b0},WriteData[31:24]);
								end
								else begin
									mem[DataAddr]<=WriteData;
									$display("*%h <= %h",{20'b0,DataAddr,2'b0},WriteData);
								end
							end
							2'b01: begin
								if(SwMode==2'b01) begin//swl
									mem[DataAddr][15:0]<=WriteData[31:16];
									$display("*%h <= %h",{20'b0,DataAddr,2'b01},WriteData[31:16]);
								end
								else if(SwMode==2'b10) begin//swr
									mem[DataAddr][31:8]<=WriteData[23:0];
									$display("*%h <= %h",{20'b0,DataAddr,2'b01},WriteData[23:0]);
								end
							end
							2'b10: begin
								if(SwMode==2'b01) begin//swl
									mem[DataAddr][23:0]<=WriteData[31:8];
									$display("*%h <= %h",{20'b0,DataAddr,2'b10},WriteData[31:8]);
								end
								else if(SwMode==2'b10) begin//swr
									mem[DataAddr][31:16]<=WriteData[15:0];
									$display("*%h <= %h",{20'b0,DataAddr,2'b10},WriteData[15:0]);
								end
							end
							2'b11: begin
								if(SwMode==2'b01) begin//swl
									mem[DataAddr]<=WriteData;
									$display("*%h <= %h",{20'b0,DataAddr,2'b11},WriteData);
								end
								else if(SwMode==2'b10) begin//swr
									mem[DataAddr][31:24]<=WriteData[7:0];
									$display("*%h <= %h",{20'b0,DataAddr,2'b11},WriteData[7:0]);
								end
							end
						endcase
					end
				endcase
			end
		end
	end

endmodule
