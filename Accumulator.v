`timescale 1ns / 1ps

///////////////////////////////////////////////////////////
// University: Worcester Polytechnic Institute
// Desription : Accumulator module for pipelined simple CPU 
// Course : Computer Architecture ECE 501/ summer 2016
////////////////////////////////////////////////////////////

module Accumulator #(parameter n = 16)(input [n-1:0]data_in, input LoadAcc,clk,output reg [n-1:0]data_out);

always @(posedge clk) begin
	if(LoadAcc)
		data_out <= data_in;
end

endmodule
