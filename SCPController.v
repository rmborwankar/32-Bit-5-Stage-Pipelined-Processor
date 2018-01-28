`timescale 1ns / 1ps

///////////////////////////////////////////////////////////
// University: Worcester Polytechnic Institute
// Desription : Controller module for pipelined simple CPU 
// Course : Computer Architecture ECE 501/ summer 2016
////////////////////////////////////////////////////////////

module SCPController (input clk,reset,input [2:0]opCode,input AluZero, output reg en,start,AddMul,AndNot,AcMem,LoadAcc,MemSel,PcSel,Wr,Rd,AcSel,output reg [1:0] WbSel);

always @(posedge clk) begin
if (~reset) en <=1'b1;
else en <= 0;
end

always @(opCode) begin
start = 1'b1;AddMul= 1'b0;AndNot= 1'b0;AcMem = 1'b0;LoadAcc= 1'b0;MemSel= 1'b0;AcSel = 1'b0;WbSel= 2'b00;PcSel= 1'b0;Wr= 1'b0;Rd= 1'b0;

case (opCode)
	3'b000 : begin
		Rd 	= 1'b1;
		AcSel	= 1'b1;
		MemSel	= 1'b1;
		WbSel	= 2'b11;
		AcMem 	= 1'b1;
		LoadAcc	= 1'b1;
		AddMul	= 1'b0;
		AndNot 	= 1'b0;
	end

	3'b001:  begin
		Rd 	= 1'b1;
		AcSel	= 1'b1;
		MemSel	= 1'b1;
		WbSel	= 2'b11;
		AcMem 	= 1'b1;
		LoadAcc	= 1'b1;
		AddMul	= 1'b0;
		AndNot 	= 1'b1;
	end

	3'b010: begin
		
		Rd 	= 1'b1;
		AcSel	= 1'b1;
		MemSel	= 1'b1;
		WbSel	= 2'b11;
		AcMem 	= 1'b1;
		LoadAcc	= 1'b1;
		AddMul	= 1'b1;
		AndNot 	= 1'b0;
	end
	3'b011: begin
		Rd 	= 1'b1;
		AcSel	= 1'b1;
		MemSel	= 1'b1;
		WbSel	= 2'b11;
		AcMem 	= 1'b1;
		LoadAcc	= 1'b1;
		AddMul	= 1'b1;
		AndNot 	= 1'b1;
	end
	3'b100: begin
		Rd 	= 1'b1;
		MemSel	= 1'b0;
		WbSel 	= 2'b01;
		AcMem 	= 1'b1;
		LoadAcc	= 1'b1;
	end
	3'b101: begin
		Wr 	= 1'b1;
		AcSel	= 1'b0;
		WbSel 	= 2'b00;
		AcMem 	= 1'b0;
	end

	3'b110: PcSel 	= 1'b1;

	3'b111: begin
		if (AluZero) PcSel = 1'b1;
	end
	default: begin
 		start 	= 1'b1;
		AddMul	= 1'b0;
		AndNot	= 1'b0;
		AcMem 	= 1'b0;
		AcSel	= 1'b0;
		LoadAcc	= 1'b0;
		MemSel	= 1'b0;
		WbSel	= 2'b00;
		PcSel	= 1'b0;
		Wr	= 1'b0;
		Rd	= 1'b0;	
	end
endcase
end

endmodule


			