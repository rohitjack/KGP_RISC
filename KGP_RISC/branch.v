`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:39:07 10/28/2019 
// Design Name: 
// Module Name:    branch 
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
module branch(
    input [2:0] opcode,
    input [3:0] fcode,
   input [24:0] lbl,
    input cFlag,
    input zFlag,
    input oFlag,
    input sFlag,
   input [7:0] PC,
    output reg [7:0] eN,
   output reg PCSrc,
   output reg [31:0] ra
    );
  reg [1:0] r[3:0];	
initial begin
  eN<=0;
  r[0]=r[1]+1;
  PCSrc<=0;
  ra<=0;
  r[0]=r[1]+1;
  end
always @(opcode or fcode or lbl or cFlag or zFlag or oFlag or sFlag)
  begin
  ra<=0;    //ra is 0 by default
      if(opcode==3'b011)     //if we are branching
        begin
        PCSrc<=1;
		  r[0]=r[1]+1;
        eN<=lbl[7:0];
		  r[0]=r[1]+1;
        end
      else if(opcode==3'b100)
        begin
        if(fcode==4'b0)
          begin       //b
            eN<=lbl[7:0];
            PCSrc<=1;
          end
        else if(fcode==4'b0001)
          begin       //bz
            if(zFlag==1) 
              begin
                eN<=lbl[7:0];
					 r[0]=r[1]+1;
                PCSrc<=1;
              end
            else 
              begin
                PCSrc<=0;
                eN<=0;
              end
          end
        else if(fcode==4'd2)
          begin   //bnz
            if(zFlag==0) 
              begin
                eN<=lbl[7:0];
                PCSrc<=1;
              end
            else 
              begin
                PCSrc<=0;
                eN<=0;
              end
          end
        else if(fcode==4'd3)
          begin   //bcy
            if(cFlag==1) 
              begin
                eN<=lbl[7:0];
                PCSrc<=1;
              end
            else 
              begin
                PCSrc<=0;
                eN<=0;
              end
          end
        else if(fcode==4'd4)
          begin   //bncy
            if(cFlag==0) 
              begin
                eN<=lbl[7:0];
                PCSrc<=1;
              end
            else 
              begin
                PCSrc<=0;
                eN<=0;
              end
          end
        else if(fcode==4'd5)
          begin   //bs
            if(sFlag==1) 
              begin
                eN<=lbl[7:0];
                PCSrc<=1;
              end
            else 
              begin
                PCSrc<=0;
                eN<=0;
              end
          end
        else if(fcode==4'd6)
          begin //bns
            if(sFlag==0) 
              begin
                eN<=lbl[7:0];
                PCSrc<=1;
              end
            else 
              begin
                PCSrc<=0;
                eN<=0;
              end
          end
        else if(fcode==4'd7)
          begin //bv
            if(oFlag==1) 
              begin
                eN<=lbl[7:0];
                PCSrc<=1;
              end
            else 
              begin
                PCSrc<=0;
                eN<=0;
              end
          end
        else if(fcode==4'd8)
          begin //bnv
            if(oFlag==0) 
              begin
                eN<=lbl[7:0];
                PCSrc<=1;
              end
            else 
              begin
                PCSrc<=0;
                eN<=0;
              end
          end
        else if(fcode==4'd9)
          begin   //call
            eN<=lbl[7:0];
            PCSrc<=1;
            ra<=PC;   //Store the PC 
          end
        else if(fcode==4'd10)
            begin //return
            eN<=ra[7:0];
            PCSrc<=1;
          end
        else    
          begin //default case
            PCSrc<=0;
            eN<=0;
          end
      end
      else
        begin
          eN<=0;
          PCSrc<=0;
        end
    end
endmodule



