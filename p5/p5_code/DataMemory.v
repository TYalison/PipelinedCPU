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
module DataMemory(
	input clk,
	input reset,
	input MemWrite,
	input [1:0] SwMode,
	input [1:0] AddrLow2,
	input [11:2] DataAddr,//ALUOutM[11:2]
	input [31:0] WriteData,
	
	output [31:0] ReadData
    );
	
	integer i;
	reg [31:0] mem[1023:0];
	
	initial begin
		for(i=0;i<1024;i=i+1)
			mem[i]=32'b0;
	end

	assign ReadData=mem[DataAddr];
	
	always@(posedge clk) begin
		if(reset) begin
			for(i=0;i<1024;i=i+1)
				mem[i]<=32'b0;
		end
		else begin
			if(MemWrite) begin
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
		end
	end

endmodule
