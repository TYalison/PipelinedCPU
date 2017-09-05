`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 	TYalison
// 
// Create Date:    22:16:45 06/26/2017 
// Design Name: 
// Module Name:    InstrMemory 
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
module InstrMemory(//8KB
	input [31:0] PCounter,
	
	output [31:0] Instruction
   );
	wire InstrAddr=PCounter-32'h00003000;
	reg [31:0] mem[2048:0];
	integer i;
	
	assign Instruction=mem[InstrAddr[12:2]];
	
	initial begin
		for(i=0;i<2048;i=i+1)
			mem[i]=32'b0;
		$readmemh("code.txt",mem);
	end

endmodule
