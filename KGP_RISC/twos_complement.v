`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:45:21 10/30/2019 
// Design Name: 
// Module Name:    twos_complement 
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
module twos_complement(
    input [31:0] inp1,
    output [31:0] out
    );
	 
	 wire c;
	 reg [31:0] one;
	 initial begin
		one = 32'b00000000000000000000000000000001;
	 end
	 
	 hybrid_adder HA1(~inp1,one,out,c);

endmodule
