`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:28:25 11/04/2019 
// Design Name: 
// Module Name:    KGP_RISC 
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
module KGP_RISC(
        input clock,
        input rst,
        output [15:0] r
    );
wire [31:0] rout;
assign r = rout[15:0];
wire PCSrcIn,PCSRc;        //to decide if we need to choose external NPC or incremented PC
wire [7:0] eNI,eN;  //external NPC (coming from branch statements)
wire [7:0] npc,pc,npc_mux;  //Parts of instruction fetch

//Various Parameters of the instruction decoder
wire [2:0] opcode;
wire [4:0] rsA,rtA,shamt,wrAddr;
wire [7:0] if_id_NPC;
wire [31:0] if_id_instr; 
wire [3:0] fcode;
wire [21:0] immt;
wire [24:0] lbl;
wire clock1,clock2;

//RegWrite: To decide if we need to write in register
wire RegWrite;

//Data corresponding to rsA, rtA
wire [31:0] rsData,rtData,wrData;

//dout: output of Instuction_Memory, ra: return address
wire [31:0] dout,ra;

//To decide if we need to write in memory
wire MemWrite;

//Various flags
wire cFlag,oFlag,zFlag,sFlag;

//ALU parameters
wire [31:0] ALUOut,ALUExtOut,inp1,inp2;

//MemOut: Data loaded, MemAddr: Address in Memory
wire [31:0] MemOut;
wire [31:0] MemAddrFull;
wire [9:0] MemAddr;

//
wire [31:0] rout2;

clockDivide CD(clock,clock1,clock2);

/*//Instruction fetch module: Combination of 5 top modules
MUX_2x1 M(npc,eN,PCSrc,npc_mux);    //Choose out of npc and external npc
PC P1(clock1,npc_mux,pc);            //make it pc at clock
Instruction_Memory IMEM(           //extract instruction
  .clocka(clock2), 
  .addra(pc), 
  .douta(dout)); 
IF_ID if_id(rst,clock1,dout,npc,if_id_instr,if_id_NPC);   //make it output at clock
PC_incrementor I(pc,npc);          //increment
*/
//InstrFetch IF(clock1,clock2,rst,PCSrc,eN,if_id_instr,if_id_NPC);
//assign rout = if_id_instr;
InstrFetch IF(clock1,clock2,rst,PCSrc,eN,if_id_instr,if_id_NPC);


//Instruction Decoder, input as instruction, output as various parameters of instruction
//assign rout = {opcode[2:0] ,rsA[4:0] ,rtA[4:0],shamt[4:0],fcode[3:0],immt[8:0],MemWrite};
InstDecode I_D(
     .inst(if_id_instr),
     .opcode(opcode),
     .rsA(rsA),
     .rtA(rtA),
     .shamt(shamt),
     .func(fcode),
     .immt(immt),
     .lbl(lbl),
     .MemWrite(MemWrite)
     );

//WriteAddress decides if we need to write something
//if yes, what and where based on opcode and fcode
//there are multiple options to write like ALUOut (Arithmetic and shift op)
//ra (call a function case) and MemOut(load case)
//assign rout = {opcode,fcode,rsA,ALUOut[5:0],wrAddr[4:0],wrData[7:0],RegWrite};
writeAddress wa (
    .opcode(opcode), 
    .fcode(fcode), 
    .rsA(rsA),
     .rtA(rtA),
    .ALUOut(ALUOut), 
    .ra(ra), 
     .MemOut(MemOut),
    .wrA(wrAddr), 
    .RegWrite(RegWrite), 
    .wrD(wrData)
    );

//Register File 32 x 32, can read from two registers and write into one register at a time
assign rout = rout2;
regBank RB(
     .rst(rst),
    .clock(clock1), 
    .RgW(RegWrite), 
    .wrA(wrAddr), 
    .wrD(wrData), 
    .rdA(rsA), 
    .rdDA(rsData), 
    .rdB(rtA), 
    .rdDB(rtData),
     .rout(rout2)
    );

//Get the Address from Memory where we need to load/store
//assign rout = MemAddr;
assign MemAddrFull=rsData+immt;   
assign MemAddr=MemAddrFull[7:0];

//assign inputs assigns values to the two inputs of the ALU based on the opcode and fcode
//assign rout ={opcode,fcode,rsData[4:0],rtData[4:0],immt[14:0]};
//assign rout = {inp1[10:0],inp2[10:0],immt[9:0]};
assignInputs a_i (
    .rs(rsData), 
    .rt(rtData), 
    .shamt(shamt), 
    .immt(immt), 
    .opcode(opcode), 
    .fcode(fcode), 
    .inp1(inp1), 
    .inp2(inp2)
    ); 

//given two inputs, opcode and fcode, ALU gives the output and updates flags     
//assign rout = {inp1[4:0],inp2[4:0],ALUOut[21:0]};
ALU alu(
    .inp1(inp1), 
    .inp2(inp2), 
    .opcode(opcode), 
    .fcode(fcode), 
    .out(ALUOut),
     .ext_out(ALUExtOut),
    .cFlag(cFlag), 
    .zFlag(zFlag), 
    .sFlag(sFlag), 
    .oFlag(oFlag)
    );

//given the opcode, fcode, lbls and flags, branch gives the new eN where we need to jump and updates PCSrc
branch b (
    .opcode(opcode), 
    .fcode(fcode), 
    .lbl(lbl), 
    .cFlag(cFlag), 
    .zFlag(zFlag), 
    .oFlag(oFlag), 
    .sFlag(sFlag), 
    .PC(if_id_NPC), 
    .eN(eN), 
    .PCSrc(PCSrc), 
    .ra(ra)
    );
     

//Data Block RAM 
blk_mem_gen_v7_3b blk_mem (
  .clka(clock2), 
  .wea(MemWrite), 
  .addra(MemAddr),
  .dina(rtData),
  .douta(MemOut) 
);

endmodule