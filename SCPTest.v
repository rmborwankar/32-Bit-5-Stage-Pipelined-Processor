`timescale 1ns / 1ps

///////////////////////////////////////////////////////////
// University: Worcester Polytechnic Institute
// Desription : TestBench for pipelined simple CPU 
// Course : Computer Architecture ECE 501/ summer 2016
////////////////////////////////////////////////////////////

module SCPTest();
parameter n = 16;

reg clk,reset;
  SCPTop #(n) UUT(clk,reset);
  
  initial begin 
    clk = 0;
    reset = 1;
    repeat (2) #100 clk = ~clk;
    reset = 0;
    repeat (100) #100 clk = ~clk;
 
  end
endmodule
