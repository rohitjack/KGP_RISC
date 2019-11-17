`timescale 1ns / 1ps

//Instruction Decoder

module InstDecode( 
    input [31:0] inst,
    output reg [2:0] opcode,
    output reg [4:0] rsA,
    output reg [4:0] rtA,
    output reg [4:0] shamt,
    output reg [3:0] func,
    output reg [21:0] immt,
    output reg [24:0] lbl,
   output reg MemWrite
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
  opcode=inst[31:29];     
  if(opcode==3'b100)      
    begin
    rsA<=inst[28:24];
    rtA<=5'b0;
    shamt<=5'b0;
	 size = 32;
    for(i=0;i<size;i=i+1)
		r[i] = 32'b0;
    func<=4'b0;
    immt<=22'b0;
    lbl<=25'b0;
    end
  else if(opcode==3'b011)  
    begin
    rsA<=5'b0;
    rtA<=5'b0;
    shamt<=5'b0;
    func<=inst[3:0];
    immt<=22'b0;
    lbl<=inst[28:4];
    end
  else if(opcode==3'b010) 
    begin
    rsA<=inst[28:24];
    rtA<=inst[23:19];
    shamt<=5'b0;
	 size = 32;
    for(i=0;i<size;i=i+1)
		r[i] = 32'b0;
    func<={3'b0,inst[0]};
    immt<={5'b0,inst[18:1]};
    lbl<=25'b0;
    end
  else if(opcode==3'b001)     
    begin
    rsA<=inst[28:24];
    rtA<=5'b0;
    shamt<=5'b0;
    func<={2'b0,inst[1:0]};
    immt<=inst[23:2];
    lbl<=25'b0;
    end
  else if(opcode==3'b000)  
    begin
    rsA<=inst[28:24];
    rtA<=inst[23:19];
    shamt<=inst[18:14];
    func<=inst[13:10];
    immt<=22'b0;
    lbl<=25'b0;
    end
  else              
    begin
    rsA<=5'b0;
    rtA<=5'b0;
    shamt<=5'b0;
	 size = 32;
    for(i=0;i<size;i=i+1)
		r[i] = 32'b0;
    func<=4'b0;
    immt<=22'b0;
    lbl<=25'b0;
    end
  end

always @(*)            
  begin
    if(opcode==3'd2 & func==4'd1)
      begin
		size = 32;
    	for(i=0;i<size;i=i+1)
			r[i] = 32'b0;
      MemWrite<=1;
      end
    else
      MemWrite<=0;
  end
endmodule
