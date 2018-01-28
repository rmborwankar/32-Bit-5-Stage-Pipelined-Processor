`timescale 1ns / 1ps

///////////////////////////////////////////////////////////
// University: Worcester Polytechnic Institute
// Desription : 2-bit register module for pipelined simple CPU 
// Course : Computer Architecture ECE 501/ summer 2016
////////////////////////////////////////////////////////////

module Reg3 (input [1:0] in,input clk, en, rst,output reg [1:0] out);
  
 always @ (posedge clk) begin
    
   if (rst) out = 1'd0;
   else if (en) out = in;
   else out = out;
     
 end
 
endmodule
