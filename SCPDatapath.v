`timescale 1ns / 1ps

///////////////////////////////////////////////////////////
// University: Worcester Polytechnic Institute
// Desription : Datapath module for pipelined simple CPU 
// Course : Computer Architecture ECE 501/ summer 2016
////////////////////////////////////////////////////////////

module SCPDatapath #(parameter n = 16)(input clk,reset,en,start,AddMul,AndNot,AcMem,LoadAcc,MemSel,AcSel,PcSel,Wr,Rd,input [1:0] WbSel,output AluZero,output [2:0]opCode);

wire [n-1:0]AluOut,AcOut,AluOutF,MeMoutF,AcOutE,AcOutF;
wire [n-4:0]PcOut,AdderOut,Mux1Out,DM_Abus;
reg  [n-1:0]AcInW,DM_InbusW,AccOutE,AccOut,MeMoutE,MemOutE,AluAin,AluBin,WbOut;
wire AddMulD,AddMulE,LoadAccD,MemSelD,MemSelE,WbSelD,WbSelE,WbSelW,AcMemD,AcMemE,AcMemW,WrD,RdD,AndNotD,AndNotE,MeMselE;
wire [1:0] AcSelD,AcSelE,AluSelD,AluSelE,AluSelW,AccSelE;
wire [n-1:0]IM_Dbus,IM_DbusD,DM_Inbus,DM_OutbusE;
wire [2:0]opcodeA,opcodeB;


//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// Hazard Unit
HazardUnit  HU(opcodeA,opcodeB,rst,AccSelE,MeMSelE);

//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// Stage I : Fetch stage
PC #(n) 	 	pc(Mux1Out,reset,start,clk,PcOut);
InstructionMem #(n)	iM(PcOut,IM_Dbus);
Reg16			regD(IM_Dbus,clk, en, rst,IM_DbusD);
Reg3			reg2D1(AcSel,clk,en,rst,AcSelD);
Reg3			reg2D2(AluSel,clk,en,rst,AluSelD);
Reg1			reg1D1(AddMul,clk,en,rst,AddMulD);
Reg1			reg1D2(AndNot,clk,en,rst,AndNotD);
Reg1			reg1D3(LoadAcc,clk,en,rst,LoadAccD);
Reg1			reg1D4(MemSel,clk,en,rst,MemSelD);
Reg1			reg1D5(WbSel,clk,en,rst,WbSelD);
Reg1			reg1D6(Wr,clk,en,rst,WrD);
Reg1			reg1D7(Rd,clk,en,rst,RdD);
Reg1			reg1D8(AcMem,clk,en,rst,AcMemD);

assign AdderOut = PcOut + 6'b000001;
assign Mux1Out 	= (PcSel) ? IM_Dbus[n-4:0] : AdderOut;
assign opcodeB 	= IM_Dbus[n-1:n-3];
assign opCode = IM_Dbus[n-1:n-3];
//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// Stage II : Decode stage

Accumulator #(n) 	ac(AcIn,LoadAcc,clk,AcOut);
DataMem #(n)		dM(DM_Abus,RdD,WrD,DM_Inbus,DM_Outbus);
Reg16			regAE(AcOut,clk, en, rst,AcoutE);
Reg16			regME(DM_Outbus,clk, en, rst,MeMoutE);
Reg1			reg1D9(AddMulD,clk,en,rst,AddMulE);
Reg1			reg1D10(AndNotD,clk,en,rst,AndNotE);
Reg1			reg1D11(WbSelD,clk,en,rst,WbSelE);
Reg1			reg1D12(AcMemD,clk,en,rst,AcMemE);

//assign Mux2Out 	= (ADI) ? ACIn : (AcSel) ? DM_Inbus : AluOut
assign opcodeA 	= IM_DbusD[n-1:n-3];
assign DM_Abus 	= IM_DbusD[n-4:0];
assign DM_Inbus	= DM_InbusW;
assign AcIn	= AcInW;
//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// Stage III : Execute stage
ALU #(n)	 	alu(AluAin,AluBin,AddMulE,AndNotE,AluOut);
Reg16			regAlu(AluOut,clk, en, rst,AluOutF);
Reg16			regME1(MeMoutE,clk, en, rst,MeMoutF);
Reg16			regAc1(AccOutE,clk, en, rst,AcOutF);
Reg1			reg1D13(WbSelE,clk,en,rst,WbSelF);
Reg1			reg1D14(AcMemE,clk,en,rst,AcMemF);
// To select between Data Transfer or Arthimetic or logical instruction
always @(AcSelD,MemSelD)begin
if (AcSelD)begin
	AluAin <= AccOut;
end
else begin
	AccOutE <= AccOut;
end

if (MemSelD)begin
	AluBin <= MemOutE;
end
else begin
	MeMoutE <= MemOutE;
end
end
	
// Data forwarding
always @(AccSelE)begin
	case(AccSelE)
	00: AccOut <= AluOutF;
	01: AccOut <= MeMoutF;
	11: AccOut <= AcOutE;
	default: AccOutE <= AcOutE;
	endcase
end
// Data forwarding
always @(MeMSelE)begin
	case(MeMSelE)
	0: MemOutE <= MeMoutE;
	1: MemOutE <= MeMoutF;
	default: MemOutE <= MeMoutE;
	endcase
end

assign AluZero	= (AluOut == 0) ? 1:0;

//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// Stage IV : Write-Back stage
always @(WbSelF)begin
	case(WbSelF)
	00: WbOut <= AcOutF;
	01: WbOut <= MeMoutF;
	11: WbOut <= AluOutF;
	default: WbOut <= AluOutF;
endcase
end
always @(AcMemE)begin
	if(AcMemE)begin
		AcInW <= WbOut;
	end
	else begin
		DM_InbusW <= WbOut;
	end
end
endmodule
 
 