`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:23:21 10/16/2019 
// Design Name: 
// Module Name:    PC_incrementor 
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
module PC_incrementor(
    input [7:0] in,
    output [7:0] out
    );

	assign out=in+8'b00000001;  //simply add 1

endmodule
