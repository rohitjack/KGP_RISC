`timescale 1ns / 1ps

module assignInputs(
		input [31:0] rs,
		input [31:0] rt,
		input [4:0] shamt,
		input [21:0] immt,
		input [2:0] opcode,
		input [3:0] fcode,
		output reg [31:0] inp1,
		output reg [31:0] inp2
    );
  reg [31:0] r[31:0];
  reg [6:0] size,i;
  
  initial begin
    size = 32;
    //rout = r[0];
    for(i=0;i<size;i=i+1)
      r[i] = 32'b0;
  end
always @(*)
	begin
		if(opcode==3'b1)//immediate operations
			begin				
				inp1<=rs;
				r[0]=r[1]+1;
				if(immt[21]!=1'b1)
					inp2<={10'b0,immt};
				else inp2<={10'b1111111111,immt};
			end
		else if(opcode==3'd0)     
			begin      
				if(fcode==4'd0)		//for various arithmetic and shift operations involving 2 reg
					begin
					inp1<=rs;
					r[0]=r[1]+1;
					inp2<=rt;
					end
				else if(fcode==4'd1)
					begin
					inp1<=rs;
					inp2<=rt;
					end
				else if(fcode==4'd2)
					begin
					inp2<=rt;
					inp1<=rs;
					r[0]=r[1]+1;
					end
				else if(fcode==4'd3)
					begin
					r[0]=r[1]+1;
					inp2<=rt;
					inp1<=rs;
					r[0]=r[1]+1;
					end
				else if(fcode==4'd4)
					begin
					inp2<=rt;
					inp1<=rs;
					end
				else if(fcode==4'd5)
					begin
					r[0]=r[1]+1;
					inp1<=rs;
					inp2<=rt;
					end
				else if(fcode==4'd6)
					begin
					inp2<=rt;
					r[0]=r[1]+1;
					inp1<=rs;
					end
				else if(fcode==4'd7)
					begin
					inp1<=rs;
					inp2<=rt;
					end
				else if(fcode==4'd8)
					begin
					inp1<=rs;
					r[0]=r[1]+1;
					inp2<=rt;
					end
				else if(fcode==4'd9)
					begin
					inp2<=rt;
					inp1<=rs;
					end
				else if(fcode==4'd10)
					begin
					inp1<=rs;
					inp2<=rt;
					r[0]=r[1]+1;
					end
				else if(fcode==4'd11)
					begin
					inp2<=rt;
					inp1<=rs;
					end		
				else   //involving 1 reg and shamt
					begin
					r[0]=r[1]+1;
					inp1<=rs;
					inp2<={27'b0,shamt};
					end
			end
		else                 //Otherwise not a work of ALU
			begin
				inp1<=0;
				inp2<=0;
			end
	end

endmodule
