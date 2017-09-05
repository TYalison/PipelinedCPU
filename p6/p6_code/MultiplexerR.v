`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 	TYalison
// 
// Create Date:    22:47:08 06/26/2017 
// Design Name: 
// Module Name:    MultiplexerR 
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
module MultiplexerR(//MUX3 #(5)
	input [1:0] select,
	input [4:0] RegAddr1,//RT
	input [4:0] RegAddr2,//RD
	input [4:0] RegAddr3,//5'b11111
	
	output [4:0] RegAddr
    );

	assign RegAddr=(select==2'b01)?RegAddr1:
						(select==2'b10)?RegAddr2:
						(select==2'b11)?RegAddr3:0;
						
endmodule
