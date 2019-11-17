`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:12:57 10/23/2019 
// Design Name: 
// Module Name:    InstrFetch 
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
module InstrFetch(
	input clock1,
	input clock2,
	input rst,
	input select,
	input [7:0] EN,
	output [31:0] instruction,
	output [7:0] NPC
    );
	 
	wire [31:0] out; 
	wire [7:0] npc,pc,npc_mux;

	MUX_2x1 M(npc,EN,select,npc_mux);

	PC P1(clock1,npc_mux,pc); 
	
	blk_mem_gen_v7_3 blk_ram(.clka(clock2),.addra(pc),.douta(out));
	
	IF_ID if_id(reset,clock1,out,npc,instruction,NPC);
	
	PC_incrementor I(pc,npc);
endmodule
