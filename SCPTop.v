`timescale 1ns / 1ps

///////////////////////////////////////////////////////////
// University: Worcester Polytechnic Institute
// Desription : Top module for pipelined simple CPU 
// Course : Computer Architecture ECE 501/ summer 2016
////////////////////////////////////////////////////////////

module SCPTop #(parameter n = 16) (input clk,reset);

wire [2:0] opCode;
wire en,start,AddMul,AndNot,AcMem,LoadAcc,MemSel,AcSel,PcSel,Wr,Rd,AluZero;
wire [1:0] WbSel;

SCPDatapath #(n) datapath	(clk,reset,en,start,AddMul,AndNot,AcMem,LoadAcc,MemSel,AcSel,PcSel,Wr,Rd,WbSel,AluZero,opCode);
SCPController    controller	(clk,reset,opCode,AluZero,en,start,AddMul,AndNot,AcMem,LoadAcc,MemSel,PcSel,Wr,Rd,AcSel,WbSel);


endmodule
