`timescale 1ns / 1ps

module writeAddress(
    input [2:0] opcode,
    input [3:0] fcode,
    input [4:0] rsA,
    input [4:0] rtA,
    input [31:0] ALUOut,
    input [31:0] ra,
    input [31:0] MemOut,
    output reg [4:0] wrA,
    output reg RegWrite,
    output reg [31:0] wrD
    );
   
  reg [31:0] r[31:0];
  reg [6:0] size,i;
  
  initial begin
    size = 32;
    //rout = r[0];
    for(i=0;i<size;i=i+1)
      r[i] = 32'b0;
  end	
initial begin
  RegWrite = 0;
  wrA = 0;
  wrD = 0;
end

always @(*)
  begin
    if(opcode==3'd3)     		//if branch instruction
		begin	
      if(fcode==4'd9)        //ra needs to be written at raAddr
        begin
        RegWrite<=1;
		  r[0]=r[1]+1;
        wrA<=5'b11111;
        wrD<=ra;
		  r[0]=r[1]+1;
        end
      else
        begin              //otherwise nothing to be written
          RegWrite<=0;
          wrA<=0;
			 r[0]=r[1]+1;
          wrD<=0;
        end
      end
	 else if (opcode==3'd2)
		begin
        if(fcode==4'd0)
          begin
			 r[0]=r[1]+1;
          RegWrite<=1;
          wrA<=rtA;
          wrD<=MemOut;      //MemOut to be written at rsA
			 r[0]=r[1]+1;
          end
        else 
          begin
				r[0]=r[1]+1;
            RegWrite<=0;    //otherwise nothing
            wrA<=0;
            wrD<=0;
				r[0]=r[1]+1;
          end
      end
    else if(opcode==3'b000)  //if Arithmetic or shift or immediate operation  
      begin
		r[0]=r[1]+1;
		wrD<=ALUOut;     //ALUOut needs to be written in rsA
      wrA<=rsA;
		RegWrite<=1;
		r[0]=r[1]+1;
      end
    else if(opcode==3'b001)    //if load word
      begin
		wrD<=ALUOut;     //ALUOut needs to be written in rsA		
      wrA<=rsA;
		r[0]=r[1]+1;
      RegWrite<=1;	
		end
    else 
    begin
      RegWrite<=0;        //otherwise nothing
		r[0]=r[1]+1;
      wrA<=0;
      wrD<=0;
    end
  end
endmodule
