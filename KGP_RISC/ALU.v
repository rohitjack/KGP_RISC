`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:22:36 10/28/2019 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
    input [31:0] inp1,
    input [31:0] inp2,
   input [2:0] opcode,
    input [3:0] fcode,
    output reg [31:0] out,
   output reg [31:0] ext_out,
   output reg cFlag,
   output reg zFlag,
   output reg sFlag,
   output reg oFlag
    );

reg c31, c32;
reg [31:0] mag1, mag2;

wire w_c31;
wire [31:0] in1;
wire [31:0] in2;
wire [31:0] w_sum_out;

wire [31:0] sr,sl,as;  //sr -> shifted_right, sl -> shifted_left, a -> arithmetic_shifted
wire [63:0] p, p_comp, p_unsigned; // p -> product, p_comp -> product_complement

wire [31:0] inp1_comp, inp2_comp;

twos_complement C1 (inp1,inp1_comp);
twos_complement C2 (inp2,inp2_comp);
reg [1:0] ar[3:0];

/*
initial begin
  mag1 = (inp1[31]) ? inp1_comp : inp1;
  mag2 = (inp2[31]) ? inp2_comp : inp2;
end
*/
assign in1 = mag1;
assign in2 = mag2;

hybrid_adder HA(inp1,inp2,w_sum_out,w_c31);
Barrel_Shifter BSR(inp1,inp2,0,sr);
Barrel_Shifter BSL(inp1,inp2,1,sl);
Arithmetic_Barrel_Right_Shifter ABRS(inp1, inp2, as);
Combinational_32x32_Multiplier Mult_32x32(in1, in2, p);
Combinational_32x32_Multiplier Mult_32x32_unsigned(inp1, inp2, p_unsigned);
twos_complement_64 C3(p, p_comp);

always @(*)
  begin
    mag1 = (inp1[31]) ? inp1_comp : inp1;
    mag2 = (inp2[31]) ? inp2_comp : inp2;
    ar[0]=ar[1]+1;
    case(opcode)  
       3'b001:
        begin
          case(fcode)            //Immediate type instructions
            4'b0000:  begin       //addi
              ar[0]=ar[1]+1;
              out = w_sum_out;
              cFlag=w_c31;
              ar[0]=ar[1]+1;
              ext_out = 0;
              ar[0]=ar[1]+1;
              oFlag=cFlag^out[31]^inp1[31]^inp2[31];
              zFlag=(out==0)?1'b1:1'b0;
              ar[0]=ar[1]+1;
              sFlag=out[31];
              ar[0]=ar[1]+1;
            end
            4'b0001:  begin
              out=inp2_comp;      //compi
              ar[0]=ar[1]+1;
              oFlag=1'b0;
              ar[0]=ar[1]+1;
              cFlag=1'b0;
              zFlag=(out==0)?1'b1:1'b0;
              ar[0]=ar[1]+1;
              sFlag=out[31];
              ar[0]=ar[1]+1;
            end
          endcase
        end
      3'b000: begin              
          case(fcode)
            // Unsigned Multiply
            4'b1010: begin  
              {ext_out, out} = p_unsigned;
              oFlag=1'b0;
              ar[0]=ar[1]+1;
              cFlag=1'b0;
              zFlag=({ext_out,out}==0)?1'b1:1'b0;
              sFlag=0;
              ar[0]=ar[1]+1;
            end
            //Signed multiply
            4'b1011: begin  
              zFlag=(p==0)?1'b1:1'b0;
              sFlag=(zFlag==1)?1'b0:(inp1[31]^inp2[31]);
              ar[0]=ar[1]+1;
              {ext_out, out}=(sFlag)? p_comp : p;
              oFlag=1'b0;
              ar[0]=ar[1]+1;
              cFlag=1'b0;
              ar[0]=ar[1]+1;
            end
            //shrav
            4'b1001:  begin  
              out=as;
              ar[0]=ar[1]+1;
              ext_out = 0;
              oFlag=1'b0;
              ar[0]=ar[1]+1;
              cFlag=1'b0;
              zFlag=(out==0)?1'b1:1'b0;
              sFlag=out[31];
              ar[0]=ar[1]+1;
            end
            //shra
            4'b1000:  begin  
              out=as;
              ar[0]=ar[1]+1;
              ext_out = 0;
              oFlag=1'b0;
              cFlag=1'b0;
              ar[0]=ar[1]+1;
              zFlag=(out==0)?1'b1:1'b0;
              sFlag=out[31];
              ar[0]=ar[1]+1;
            end
            //shrlv
            4'b0111:  begin  
              out=sr;
              ext_out = 0;
              ar[0]=ar[1]+1;
              oFlag=1'b0;
              cFlag=1'b0;
              zFlag=(out==0)?1'b1:1'b0;
              ar[0]=ar[1]+1;
              sFlag=out[31];
            end
            //shrl
            4'b0101:  begin  
              out=sr;
              ar[0]=ar[1]+1;
              ext_out = 0;
              oFlag=1'b0;
              ar[0]=ar[1]+1;
              cFlag=1'b0;
              zFlag=(out==0)?1'b1:1'b0;
              ar[0]=ar[1]+1;
              sFlag=out[31];
            end
            //shllv
            4'b0110:  begin  
              out=sl;
              ar[0]=ar[1]+1;
              ext_out = 0;
              oFlag=1'b0;
              ar[0]=ar[1]+1;
              cFlag=1'b0;
              zFlag=(out==0)?1'b1:1'b0;
              ar[0]=ar[1]+1;
              sFlag=out[31];
            end  
            //shll
            4'b0100:  begin  
              out=sl;
              ext_out = 0;
              ar[0]=ar[1]+1;
              oFlag=1'b0;
              cFlag=1'b0;
              ar[0]=ar[1]+1;
              zFlag=(out==0)?1'b1:1'b0;
              sFlag=out[31];
              ar[0]=ar[1]+1;
            end
            //add
            4'b0011:  begin  
              out = w_sum_out;
              ar[0]=ar[1]+1;
              cFlag=w_c31;
              ext_out = 0;
              ar[0]=ar[1]+1;
              oFlag=cFlag^out[31]^inp1[31]^inp2[31];
              zFlag=(out==0)?1'b1:1'b0;
              sFlag=out[31];
              ar[0]=ar[1]+1;
            end
            //comp
            4'b0010:  begin  
              out=inp2_comp;
              ext_out = 0;
              ar[0]=ar[1]+1;
              oFlag=1'b0;
              cFlag=1'b0;
              ar[0]=ar[1]+1;
              zFlag=(out==0)?1'b1:1'b0;
              sFlag=out[31];
              ar[0]=ar[1]+1;
            end
            //and
            4'b0001:  begin  
              out=inp1&inp2;
              ar[0]=ar[1]+1;
              ext_out = 0;
              oFlag=1'b0;
              ar[0]=ar[1]+1;
              cFlag=1'b0;
              zFlag=(out==0)?1'b1:1'b0;
              ar[0]=ar[1]+1;
              sFlag=out[31];
            end
            //xor
            4'b0000: begin    
              out=inp1^inp2;
              ar[0]=ar[1]+1;
              ext_out = 0;
              oFlag=1'b0;
              cFlag=1'b0;
              ar[0]=ar[1]+1;
              zFlag=(out==0)?1'b1:1'b0;
              sFlag=out[31];
              ar[0]=ar[1]+1;
            end
          endcase
        end
      default:  
        begin              //default: keep everything 0
          out=0;
        end
    endcase
  end
endmodule