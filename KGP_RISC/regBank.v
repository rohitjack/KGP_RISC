`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:29:30 10/28/2019 
// Design Name: 
// Module Name:    regBank 
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
module regBank(
  input rst,
  input clock,
  input RgW,       
  input [4:0] wrA,     
  input [31:0] wrD,       
  input [4:0] rdA,       
  output reg [31:0] rdDA,
  input [4:0] rdB,
  output reg [31:0] rdDB,
  output [31:0] rout
  );

  reg [31:0] r[31:0];
  reg [6:0] size,i;
  
  initial begin
    size = 32;
    //rout = r[0];
    for(i=0;i<size;i=i+1)
      r[i] = 32'b0;
  end
      
  assign rout=r[7];
  
  always @(*) 
    begin
      if(rdB<32)begin
          rdDB=r[rdB];          //Read Data
          //rout = rdDB[15:0];
        end 
      else begin
          rdDB=32'hXXXXXXXX;       //Not possible, kept just to prevent latch
          //rout = 16'bX;
        end
        
      if(rdA<32) begin
          rdDA=r[rdA];          //Read Data
          //rout = rdDA[15:0];
        end
      else begin
          rdDA=32'hXXXXXXXX;
          //rout = 16'bX;
        end
    end
    
  always @(posedge clock)            //Write Operation
    begin
    if (RgW) begin
        r[wrA]=wrD;
        //rout = r[wrA];
        end
    end
    
endmodule
