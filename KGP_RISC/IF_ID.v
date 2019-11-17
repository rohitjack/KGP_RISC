`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:18:05 10/16/2019 
// Design Name: 
// Module Name:    IF_ID 
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
module IF_ID(
		input rst,
		input clock,
		input [31:0] In,
		input [7:0] NPCI,
		output reg [31:0] Out,
		output reg [7:0] NPCO
    );
	
	initial begin
		Out<=32'b0;
		NPCO<=8'b0;
		end
		
	always @(posedge clock)     //At every clock cycle, assign output=input
			begin
			if(rst)
				begin
					NPCO<=0;
					Out<=0;
				end
			else
				begin
					NPCO<=NPCI;
					Out<=In;
				end				
			end
endmodule
