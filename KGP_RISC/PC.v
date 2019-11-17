`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:17:29 10/16/2019 
// Design Name: 
// Module Name:    PC 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module PC(
	 input clk,
    input [7:0] in,
    output reg [7:0] out
    );

	initial begin
		out<=0;
		end
		
	always @(posedge clk)      //Assigns pc_out equal to pc_in at every clock cycle
		begin
		out<=in;          
		end

endmodule
