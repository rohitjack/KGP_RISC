`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:51:00 11/04/2019
// Design Name:   KGP_RISC
// Module Name:   D:/My Study Folder/3rd Year/Sem 5/COA/Lab/Assignment 10/CPU/KGP_RISC_tb.v
// Project Name:  blk_mem_gen_v7_3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: KGP_RISC
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module KGP_RISC_tb;

	// Inputs
	reg clk;
	reg reset;

	// Outputs
	wire [15:0] rout;

	// Instantiate the Unit Under Test (UUT)
	KGP_RISC uut (
		.clock(clk), 
		.rst(reset), 
		.r(rout)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	always
		#1 clk=!clk;
      
endmodule

