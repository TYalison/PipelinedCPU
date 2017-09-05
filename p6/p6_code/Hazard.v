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
	input Busy,
	input movnM,
	input movnW,
	input movzM,
	input movzW,
	input [31:0] InstructionD,
	input [31:0] InstructionE,
	input [31:0] InstructionM,
	input [31:0] InstructionW,

	output PC_EN,
   output IFID_EN,
   output IDEX_CLR,
	output [2:0] WriteSelect,
	output [2:0] Read1Select,
   output [2:0] Read2Select,
	output [2:0] rdDataSelect,
	output [2:0] Opr1Select,
   output [2:0] Opr2Select
    );
	
	wire Stall; 
	
	//ID: 
	wire [4:0] rsD=InstructionD[25:21];
	wire [4:0] rtD=InstructionD[20:16];
	wire [4:0] rdD=InstructionD[15:11];
	
	wire lwlD;
	wire lwrD;
	wire movnCD;
	wire movzCD;
	wire mfhiD;
	wire mfloD;
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
	wire CalHLD;
	wire MtHLD;
	wire MfHLD;
	
	HazardDecoder idhd(InstructionD,lwlD,lwrD,movnCD,movzCD,mfhiD,mfloD,jrD,jalD,jalrD,bgezalD,bltzalD,bgealD,CalRD,CalID_Alg,CalID_Log,CalSD,LdD,StoD,BrD,BrzD,CalHLD,MtHLD,MfHLD);
	
	//EX:
	wire [4:0] rsE=InstructionE[25:21];
	wire [4:0] rtE=InstructionE[20:16];
	wire [4:0] rdE=InstructionE[15:11];
	
	wire lwlE;
	wire lwrE;
	wire movnCE;
	wire movzCE;
	wire mfhiE;
	wire mfloE;
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
	wire CalHLE;
	wire MtHLE;
	wire MfHLE;
	
	HazardDecoder exhd(InstructionE,lwlE,lwrE,movnCE,movzCE,mfhiE,mfloE,jrE,jalE,jalrE,bgezalE,bltzalE,bgealE,CalRE,CalIE_Alg,CalIE_Log,CalSE,LdE,StoE,BrE,BrzE,CalHLE,MtHLE,MfHLE);
	
	//MEM:
	wire [4:0] rsM=InstructionM[25:21];
	wire [4:0] rtM=InstructionM[20:16];
	wire [4:0] rdM=InstructionM[15:11];
	
	wire lwlM;
	wire lwrM;
	wire movnCM;
	wire movzCM;
	wire mfhiM;
	wire mfloM;
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
	wire CalHLM;
	wire MtHLM;
	wire MfHLM;
	
	HazardDecoder memhd(InstructionM,lwlM,lwrM,movnCM,movzCM,mfhiM,mfloM,jrM,jalM,jalrM,bgezalM,bltzalM,bgealM,CalRM,CalIM_Alg,CalIM_Log,CalSM,LdM,StoM,BrM,BrzM,CalHLM,MtHLM,MfHLM);
	
	//WB:
	wire [4:0] rsW=InstructionW[25:21];
	wire [4:0] rtW=InstructionW[20:16];
	wire [4:0] rdW=InstructionW[15:11];
	
	wire lwlW;
	wire lwrW;
	wire movnCW;
	wire movzCW;
	wire mfhiW;
	wire mfloW;
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
	wire CalHLW;
	wire MtHLW;
	wire MfHLW;
	
	HazardDecoder wbhd(InstructionW,lwlW,lwrW,movnCW,movzCW,mfhiW,mfloW,jrW,jalW,jalrW,bgezalW,bltzalW,bgealW,CalRW,CalIW_Alg,CalIW_Log,CalSW,LdW,StoW,BrW,BrzW,CalHLW,MtHLW,MfHLW);

//Forward:
	//Read1Select:
	assign Read1Select = (rsD!=0&&(BrD|BrzD|jrD|jalrD)&&(rsD==rdM&&(CalRM|movzM|movnM|CalSM)||rsD==rtM&&(CalIM_Log|CalIM_Alg)))?3'b010:
								(rsD!=0&&(BrD|BrzD|jrD|jalrD)&&(rsD==rdM&&jalrM||rsD==31&&(jalM|bgezalM|bltzalM|bgealM)))?3'b011:
								(rsD!=0&&(BrD|BrzD|jrD|jalrD)&&(rsD==rdM&&mfhiM))?3'b100:
								(rsD!=0&&(BrD|BrzD|jrD|jalrD)&&(rsD==rdM&&mfloM))?3'b101:3'b001;
	//Read2Select:
	assign Read2Select = (rtD!=0&&BrD&&(rtD==rdM&&(CalRM|movzM|movnM|CalSM)||rtD==rtM&&(CalIM_Log|CalIM_Alg)))?3'b010:
								(rtD!=0&&BrD&&(rtD==rdM&&jalrM||rtD==31&&(jalM|bgezalM|bltzalM|bgealM)))?3'b011:
								(rtD!=0&&BrD&&(rtD==rdM&&mfhiM))?3'b100:
								(rtD!=0&&BrD&&(rtD==rdM&&mfloM))?3'b101:3'b001;
	//rdDataSelect:
	assign rdDataSelect =(rdD!=0&&bgealD&&(rdD==rdM&&(CalRM|movzM|movnM|CalSM)||rdD==rtM&&(CalIM_Log|CalIM_Alg)))?3'b010:
								(rdD!=0&&bgealD&&(rdD==rdM&&jalrM||rdD==31&&(jalM|bgezalM|bltzalM|bgealM)))?3'b011:
								(rdD!=0&&bgealD&&(rdD==rdM&&mfhiM))?3'b100:
								(rdD!=0&&bgealD&&(rdD==rdM&&mfloM))?3'b101:3'b001;
	//Opr1Select:
	assign Opr1Select=(rsE!=0&&(MtHLE|CalHLE|CalRE|movzCE|movnCE|CalIE_Log|CalIE_Alg|LdE|StoE)&&(rsE==rdM&&(CalRM|movzM|movnM|CalSM)||rsE==rtM&&(CalIM_Log|CalIM_Alg)))?3'b010:
							(rsE!=0&&(MtHLE|CalHLE|CalRE|movzCE|movnCE|CalIE_Log|CalIE_Alg|LdE|StoE)&&(rsE==rdM&&jalrM||rsE==31&&(jalM|bgezalM|bltzalM|bgealM)))?3'b011:
							(rsE!=0&&(MtHLE|CalHLE|CalRE|movzCE|movnCE|CalIE_Log|CalIE_Alg|LdE|StoE)&&(rsE==rdM&&mfhiM))?3'b100:
							(rsE!=0&&(MtHLE|CalHLE|CalRE|movzCE|movnCE|CalIE_Log|CalIE_Alg|LdE|StoE)&&(rsE==rdM&&mfloM))?3'b101:
							(rsE!=0&&(MtHLE|CalHLE|CalRE|movzCE|movnCE|CalIE_Log|CalIE_Alg|LdE|StoE)&&(rsE==rdW&&(CalRW|movzW|movnW|CalSW|jalrW|MfHLW)||rsE==rtW&&(CalIW_Log|CalIW_Alg|LdW)||rsE==31&&(jalW|bgezalW|bltzalW|bgealW)))?3'b110:3'b001;
	//Opr2Select:
	assign Opr2Select=(rtE!=0&&(CalHLE|CalRE|movzCE|movnCE|CalSE|StoE)&&(rtE==rdM&&(CalRM|movzM|movnM|CalSM)||rtE==rtM&&(CalIM_Log|CalIM_Alg)))?3'b010:
							(rtE!=0&&(CalHLE|CalRE|movzCE|movnCE|CalSE|StoE)&&(rtE==rdM&&jalrM||rtE==31&&(jalM|bgezalM|bltzalM|bgealM)))?3'b011:
							(rtE!=0&&(CalHLE|CalRE|movzCE|movnCE|CalSE|StoE)&&(rtE==rdM&&mfhiM))?3'b100:
							(rtE!=0&&(CalHLE|CalRE|movzCE|movnCE|CalSE|StoE)&&(rtE==rdM&&mfloM))?3'b101:
							(rtE!=0&&(CalHLE|CalRE|movzCE|movnCE|CalSE|StoE)&&(rtE==rdW&&(CalRW|movzW|movnW|CalSW|jalrW|MfHLW)||rtE==rtW&&(CalIW_Log|CalIW_Alg|LdW)||rtE==31&&(jalW|bgezalW|bltzalW|bgealW)))?3'b110:3'b001;
	//WriteSelect
	assign WriteSelect = (rtM!=0&&StoM&&(rtM==rdW&&(CalRW|movzW|movnW|CalSW|jalrW)||rtM==rtW&&(CalIW_Log|CalIW_Alg|LdW)||rtM==31&&(jalW|bgezalW|bltzalW|bgealW)))?3'b010:
								(rtM!=0&&StoM&&(rtM==rdW&&mfhiW))?3'b011:
								(rtM!=0&&StoM&&(rtM==rdW&&mfloW))?3'b100:3'b001;

//Stall:
	assign Stall =(rsD!=0&&((CalHLD|MtHLD|LdD|StoD|CalRD|movzCD|movnCD|CalID_Log|CalID_Alg)&&(rsD==rtE&&LdE||rsD==rtM&&(lwlM|lwrM))||
									(BrD|BrzD|jrD|jalrD)&&(rsD==rdE&&(CalRE|movzCE|movnCE|CalSE|MfHLE)||rsD==rtE&&(CalIE_Log|CalIE_Alg|LdE)||rsD==rtM&&LdM))||
						rtD!=0&&((CalHLD|CalRD|movzCD|movnCD|CalSD)&&(rtD==rtE&&LdE||rtD==rtM&&(lwlM|lwrM))||
									(BrD)&&(rtD==rdE&&(CalRE|movzCE|movnCE|CalSE|MfHLE)||rtD==rtE&&(CalIE_Log|CalIE_Alg|LdE)||rtD==rtM&&LdM))||
						rdD!=0&&((bgealD)&&(rdD==rtE&&LdE||rdD==rtM&&(lwlM|lwrM))||
									(bgealD)&&(rdD==rdE&&(CalRE|movzCE|movnCE|CalSE|MfHLE)||rdD==rtE&&(CalIE_Log|CalIE_Alg|LdE)||rdD==rtM&&LdM))||
						(CalHLD|MtHLD|MfHLD)&&(CalHLE|Busy))?1:0;

	assign PC_EN=(Stall==0)?1:0;
	assign IFID_EN=(Stall==0)?1:0;
	assign IDEX_CLR=(Stall==1)?1:0;

endmodule
