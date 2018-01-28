`timescale 1ns / 1ps

///////////////////////////////////////////////////////////
// University: Worcester Polytechnic Institute
// Desription : Program Counter module for pipelined simple CPU 
// Course : Computer Architecture ECE 501/ summer 2016
////////////////////////////////////////////////////////////

module PC #(parameter n = 16)(input [n-4:0]In ,input reset,start,clk,output reg [n-4:0]Out);

always @(posedge clk) begin
	if (reset) Out <= 0;
	else if(start) Out <= In;
	else Out <= 13'bzzzzzzzzzzzzz;
end

endmodule
