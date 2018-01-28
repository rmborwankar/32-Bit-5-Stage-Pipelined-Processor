`timescale 1ns / 1ps

///////////////////////////////////////////////////////////
// University: Worcester Polytechnic Institute
// Desription : Instruction memory module for pipelined simple CPU 
// Course : Computer Architecture ECE 501/ summer 2016
////////////////////////////////////////////////////////////

module InstructionMem #(parameter n = 16)(input [n-4:0] addrBus,output reg [n-1:0] dataBus);

reg [n-1:0] IM [0:8192];

always @(addrBus) dataBus <= IM [addrBus];

initial begin
	IM[0] = 16'h0000;	// ADD
	IM[1] = 16'h2001;	// AND
	IM[2] = 16'h4001;	// MUL
	IM[3] = 16'h6000;	// NOT
	IM[4] = 16'h8001;	// LDA
	IM[5] = 16'hA000;	// STA
	IM[6] = 16'hC100;	// JMP
	IM[7] = 16'hE000;	// JZ
end

endmodule

