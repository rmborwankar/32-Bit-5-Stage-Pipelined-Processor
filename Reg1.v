`timescale 1ns / 1ps

///////////////////////////////////////////////////////////
// University: Worcester Polytechnic Institute
// Desription : 1-bit register module for pipelined simple CPU 
// Course : Computer Architecture ECE 501/ summer 2016
////////////////////////////////////////////////////////////

module Reg1 (input in, clk, en, rst,output reg out);
  
 always @ (posedge clk) begin
    
   if (rst) out = 1'd0;
   else if (en) out = in;
   else out = out;
     
 end
 
endmodule
