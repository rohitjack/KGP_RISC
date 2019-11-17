`timescale 1ns / 1ps


module regBank_tb;

	// Inputs
	reg reset;
	reg clk;
	reg RegWrite;
	reg [4:0] wrAddr;
	reg [31:0] wrData;
	reg [4:0] rdAddrA;
	reg [4:0] rdAddrB;

	// Outputs
	wire [31:0] rdDataA;
	wire [31:0] rdDataB;

	// Instantiate the Unit Under Test (UUT)
	regBank uut (
		.rst(reset),
		.clock(clk), 
		.RgW(RegWrite), 
		.wrA(wrAddr), 
		.wrD(wrData), 
		.rdA(rdAddrA), 
		.rdDA(rdDataA), 
		.rdB(rdAddrB), 
		.rdDB(rdDataB)
	);

	initial begin
		// Initialize Inputs
		reset=0;
		clk = 1;
		RegWrite = 0;
		wrAddr = 0;
		wrData = 0;
		rdAddrA = 0;
		rdAddrB = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		RegWrite=1;
		wrAddr=5'd10;
		wrData=32'b10101;
		
		#20
		RegWrite=0;
		rdAddrA=5'd15;
		rdAddrB=5'd10;

		#20
		RegWrite=1;
		wrAddr=5'd15;
		wrData=32'b00011;
		
	end
    always 
		#10 clk=!clk;	 
endmodule

