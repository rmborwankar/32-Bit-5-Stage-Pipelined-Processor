`timescale 1ns / 1ps

///////////////////////////////////////////////////////////
// University: Worcester Polytechnic Institute
// Desription : Hazard unit module for pipelined simple CPU 
// Course : Computer Architecture ECE 501/ summer 2016
////////////////////////////////////////////////////////////

module HazardUnit(input [2:0]opcodeA,opcodeB,input rst,output reg[1:0]AccSelE,output reg MemSelE);

always @(opcodeA,opcodeB)begin
if (rst) begin
	 AccSelE <= 11;
	 MemSelE <= 0;
	end
else begin
case ({opcodeA[2],opcodeB[2]})
	00 : 	begin
	 AccSelE <= 00;
	 MemSelE <= 0;
	end
	01 : 	begin
	 AccSelE <= 00;
	 MemSelE <= 1;
	end
	10 : 	begin
	 AccSelE <= 01;
	 MemSelE <= 0;
	end
	11 : 	begin
	 AccSelE <= 01;
	 MemSelE <= 1;
	end
	default : 	begin
	 AccSelE <= 11;
	 MemSelE <= 0;
	end
endcase
end
end
endmodule
