`timescale 1ns / 1ps

///////////////////////////////////////////////////////////
// University: Worcester Polytechnic Institute
// Desription : Data memory module for pipelined simple CPU 
// Course : Computer Architecture ECE 501/ summer 2016
////////////////////////////////////////////////////////////

module DataMem #(parameter n = 16)(input [n-4:0]AddrBus, input Rd,Wr,input [n-1:0] DataInBus,output reg [n-1:0] DataOutBus);

reg [n-1:0] DM [0:8192];

always @(Rd or AddrBus)
	if(Rd) DataOutBus <= DM[AddrBus];
 always @(Wr or AddrBus or DataInBus)
	if(Wr) DM[AddrBus] <= DataInBus;

initial begin
	DM[0] = 16'h1111;
	DM[1] = 16'h0000;
end

endmodule
 
