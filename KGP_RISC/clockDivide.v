`timescale 1ns / 1ps



module clockDivide(
    input clock,
    output reg clock1,
    output reg clock2
    );

reg [3:0] counter1;

initial begin
	clock2=0;
	clock1=0;
	counter1=0;
  end
always @(clock)
  begin
  if(counter1==4'd8)
	 begin
		counter1=0;
		clock1=!clock1;
	 end
  else
    begin
      counter1=counter1+1'b1;
    end
  end

always @(clock)
  begin
    clock2=!clock2;
  end
  
endmodule
