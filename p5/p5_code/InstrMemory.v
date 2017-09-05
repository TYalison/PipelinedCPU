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
module InstrMemory(
	input [9:0] InstrAddr,
	
	output [31:0] Instruction
   );
	
	reg [31:0] mem[1023:0];
	integer i;
	
	assign Instruction=mem[InstrAddr];
	
	initial begin
		for(i=0;i<1024;i=i+1)
			mem[i]=32'b0;
		$readmemh("code.txt",mem);
	end

endmodule
