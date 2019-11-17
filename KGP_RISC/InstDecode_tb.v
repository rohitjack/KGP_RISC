`timescale 1ns / 1ps

module InstDecode_tb;

	// Inputs
	reg [31:0] inst;

	// Outputs
	wire [2:0] opcode;
	wire [4:0] rsAddr;
	wire [4:0] rtAddr;
	wire [4:0] shamt;
	wire [3:0] func;
	wire [21:0] imm;
	wire [24:0] label;
	wire MemWrite;

	// Instantiate the Unit Under Test (UUT)
	InstDecode uut (
		.inst(inst), 
		.opcode(opcode), 
		.rsA(rsAddr), 
		.rtA(rtAddr), 
		.shamt(shamt), 
		.func(func), 
		.immt(imm), 
		.lbl(label), 
		.MemWrite(MemWrite)
	);

	initial begin
		// Initialize Inputs
		inst = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		inst=32'b00000100110000101000000111100101;
		
		#20
		inst=32'b00100100110000101000000111100101;
		
		#20
		inst=32'b01000100110000101000000111100101;
		
		#20
		inst=32'b01100100110000101000000111100101;
		
		#20
		inst=32'b10000100110000101000000111100101;
	end
      
endmodule

