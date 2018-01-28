`timescale 1ns / 1ps

///////////////////////////////////////////////////////////
// University: Worcester Polytechnic Institute
// Desription : ALU module for pipelined simple CPU 
// Course : Computer Architecture ECE 501/ summer 2016
////////////////////////////////////////////////////////////

module ALU #(parameter n = 16)(input [n-1:0]A,B,input AddMul,AndNot,output reg [n-1:0]AluOut);
reg [n:0]Out;
reg [n*2-1:0]Out1;
always @(A or B)begin
	case({AddMul,AndNot})
	00:begin
		Out 	<= A + B;
		AluOut 	<= (Out[n]== 1) ? Out[n:1]:Out[n-1:0];
	end
	01: begin
		Out1 	<= A * B;
// Output of multiplication is 32 bit and truncating 16 LSBs is not a good approach
		AluOut 	<= {Out1[n*2-1:n*2-4],Out1[n*2-9:n+4],Out1[n-4:n],Out1[n-13:0]};
	end
	10: begin
		Out 	<= A & B;
		AluOut 	<= Out;
	end
	11: begin
		Out 	<= ~B;// Data Memory is given to B input
		AluOut 	<= Out;
	end
	default : AluOut <= 0;
endcase
end

endmodule
