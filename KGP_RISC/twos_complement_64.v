`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:59:13 10/30/2019 
// Design Name: 
// Module Name:    twos_complement_64 
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
module twos_complement_64(
    input [63:0] inp1,
    output [63:0] out
    );
		
	 wire c;
	 reg [63:0] one;
	 initial begin
		one = 32'b0000000000000000000000000000000000000000000000000000000000000001;
	 end
	 
	 assign out = ~inp1 + one;

endmodule
