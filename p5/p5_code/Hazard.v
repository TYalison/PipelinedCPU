`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 	TYalison
// 
// Create Date:    21:45:33 06/27/2017 
// Design Name: 
// Module Name:    Hazard 
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
module Hazard(
	input movzM,
	input movzW,
	input [31:0] InstructionD,
	input [31:0] InstructionE,
	input [31:0] InstructionM,
	input [31:0] InstructionW,

	output PC_EN,
   output IFID_EN,
   output IDEX_CLR,
	output WriteSelect,
   output [1:0] Read1Select,
   output [1:0] Read2Select,
	output [1:0] rdDataSelect,
	output [2:0] Opr1Select,
   output [2:0] Opr2Select
    );
	wire Stall; 
	
	//ID: 
	wire lwlD;
	wire lwrD;
	wire movzCD;
	wire jrD;
	wire jalD;
	wire jalrD;
	wire bgezalD;
	wire bltzalD;
	wire bgealD;
	wire CalRD;
	wire CalID_Alg;
	wire CalID_Log;
	wire CalSD;
	wire LdD;
	wire StoD;
	wire BrD;
	wire BrzD;
	wire [4:0] rsD;
	wire [4:0] rtD;
	wire [4:0] rdD;
	
	HazardDecoder idhd(InstructionD,lwlD,lwrD,movzCD,jrD,jalD,jalrD,bgezalD,bltzalD,bgealD,CalRD,CalID_Alg,CalID_Log,CalSD,LdD,StoD,BrD,BrzD,rsD,rtD,rdD);
	
	//EX:
	wire lwlE;
	wire lwrE;
	wire movzCE;
	wire jrE;
	wire jalE;
	wire jalrE;
	wire bgezalE;
	wire bltzalE;
	wire bgealE;
	wire CalRE;
	wire CalIE_Alg;
	wire CalIE_Log;
	wire CalSE;
	wire LdE;
	wire StoE;
	wire BrE;
	wire BrzE;
	wire [4:0] rsE;
	wire [4:0] rtE;
	wire [4:0] rdE;
	
	HazardDecoder exhd(InstructionE,lwlE,lwrE,movzCE,jrE,jalE,jalrE,bgezalE,bltzalE,bgealE,CalRE,CalIE_Alg,CalIE_Log,CalSE,LdE,StoE,BrE,BrzE,rsE,rtE,rdE);

	//MEM:
	wire lwlM;
	wire lwrM;
	wire movzCM;
	wire jrM;
	wire jalM;
	wire jalrM;
	wire bgezalM;
	wire bltzalM;
	wire bgealM;
	wire CalRM;
	wire CalIM_Alg;
	wire CalIM_Log;
	wire CalSM;
	wire LdM;
	wire StoM;
	wire BrM;
	wire BrzM;
	wire [4:0] rsM;
	wire [4:0] rtM;
	wire [4:0] rdM;
	
	HazardDecoder memhd(InstructionM,lwlM,lwrM,movzCM,jrM,jalM,jalrM,bgezalM,bltzalM,bgealM,CalRM,CalIM_Alg,CalIM_Log,CalSM,LdM,StoM,BrM,BrzM,rsM,rtM,rdM);
	
	//WB:
	wire lwlW;
	wire lwrW;
	wire movzCW;
	wire jrW;
	wire jalW;
	wire jalrW;
	wire bgezalW;
	wire bltzalW;
	wire bgealW;
	wire CalRW;
	wire CalIW_Alg;
	wire CalIW_Log;
	wire CalSW;
	wire LdW;
	wire StoW;
	wire BrW;
	wire BrzW;
	wire [4:0] rsW;
	wire [4:0] rtW;
	wire [4:0] rdW;
	
	HazardDecoder wbhd(InstructionW,lwlW,lwrW,movzCW,jrW,jalW,jalrW,bgezalW,bltzalW,bgealW,CalRW,CalIW_Alg,CalIW_Log,CalSW,LdW,StoW,BrW,BrzW,rsW,rtW,rdW);

//Forward:
	//Read1Select:
	assign Read1Select = (rsD!=0&&(BrD|BrzD|jrD|jalrD)&&(rsD==rdM&&((CalRM&&movzCM==0)|movzM|CalSM)||rsD==rtM&&(CalIM_Log|CalIM_Alg)))?2'b10:
								(rsD!=0&&(BrD|BrzD|jrD|jalrD)&&(rsD==rdM&&jalrM||rsD==31&&(jalM|bgezalM|bltzalM|bgealM)))?2'b11:2'b01;
	//Read2Select:
	assign Read2Select = (rtD!=0&&BrD&&(rtD==rdM&&((CalRM&&movzCM==0)|movzM|CalSM)||rtD==rtM&&(CalIM_Log|CalIM_Alg)))?2'b10:
								(rtD!=0&&BrD&&(rtD==rdM&&jalrM||rtD==31&&(jalM|bgezalM|bltzalM|bgealM)))?2'b11:2'b01;
	//rdDataSelect:
	assign rdDataSelect =(rdD!=0&&bgealD&&(rdD==rdM&&((CalRM&&movzCM==0)|movzM|CalSM)||rdD==rtM&&(CalIM_Log|CalIM_Alg)))?2'b10:
								(rdD!=0&&bgealD&&(rdD==rdM&&jalrM||rdD==31&&(jalM|bgezalM|bltzalM|bgealM)))?2'b11:2'b01;
	//Opr1Select:
	assign Opr1Select=(rsE!=0&&(CalRE|CalIE_Log|CalIE_Alg|LdE|StoE)&&(rsE==rdM&&((CalRM&&movzCM==0)|movzM|CalSM)||rsE==rtM&&(CalIM_Log|CalIM_Alg)))?3'b010:
							(rsE!=0&&(CalRE|CalIE_Log|CalIE_Alg|LdE|StoE)&&(rsE==rdM&&jalrM||rsE==31&&(jalM|bgezalM|bltzalM|bgealM)))?3'b011:
							(rsE!=0&&(CalRE|CalIE_Log|CalIE_Alg|LdE|StoE)&&(rsE==rdW&&((CalRW&&movzCW==0)|movzW|CalSW|jalrW)||rsE==rtW&&(CalIW_Log|CalIW_Alg|LdW)||rsE==31&&(jalW|bgezalW|bltzalW|bgealW)))?3'b100:3'b001;
	//Opr2Select:
	assign Opr2Select=(rtE!=0&&(CalRE|CalSE|StoE)&&(rtE==rdM&&((CalRM&&movzCM==0)|movzM|CalSM)||rtE==rtM&&(CalIM_Log|CalIM_Alg)))?3'b010:
							(rtE!=0&&(CalRE|CalSE|StoE)&&(rtE==rdM&&jalrM||rtE==31&&(jalM|bgezalM|bltzalM|bgealM)))?3'b011:
							(rtE!=0&&(CalRE|CalSE|StoE)&&(rtE==rdW&&((CalRW&&movzCW==0)|movzW|CalSW|jalrW)||rtE==rtW&&(CalIW_Log|CalIW_Alg|LdW)||rtE==31&&(jalW|bgezalW|bltzalW|bgealW)))?3'b100:3'b001;
	//WriteSelect
	assign WriteSelect = (rtM!=0&&StoM&&(rtM==rdW&&((CalRW&&movzCW==0)|movzW|CalSW|jalrW)||rtM==rtW&&(CalIW_Log|CalIW_Alg|LdW)||rtM==31&&(jalW|bgezalW|bltzalW|bgealW)))?1:0;

//Stall:
	assign Stall =(rsD!=0&&((LdD|StoD|CalRD|CalID_Log|CalID_Alg)&&(rsD==rtE&&LdE||rsD==rtM&&(lwlM|lwrM))||
									(BrD|BrzD|jrD|jalrD)&&(rsD==rdE&&(CalRE|CalSE)||rsD==rtE&&(CalIE_Log|CalIE_Alg|LdE)||rsD==rtM&&LdM))||
						rtD!=0&&((CalRD|CalSD)&&(rtD==rtE&&LdE||rtD==rtM&&(lwlM|lwrM))||
									(BrD)&&(rtD==rdE&&(CalRE|CalSE)||rtD==rtE&&(CalIE_Log|CalIE_Alg|LdE)||rtD==rtM&&LdM))||
						rdD!=0&&(bgealD&&(rdD==rtE&&LdE||rdD==rtM&&(lwlM|lwrM))||
									bgealD&&(rdD==rdE&&(CalRE|CalSE)||rdD==rtE&&(CalIE_Log|CalIE_Alg|LdE)||rdD==rtM&&LdM)))?1:0;
	assign PC_EN=(Stall==0)?1:0;
	assign IFID_EN=(Stall==0)?1:0;
	assign IDEX_CLR=(Stall==1)?1:0;

endmodule
