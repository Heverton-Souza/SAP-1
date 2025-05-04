`timescale 1ns/1ps
module SimSomadorSubtrator;
reg [7:0] a; 
reg [7:0] b;
reg  eu, su;
wire o;

SomadorSubtrator DUT(a,b,eu,su,o);

initial 
	begin
		a=1'd0;b=1'd0;eu=0;su=0;
		#20 a=1'd4;
		#20 b=1'd4;
		#20 eu=1;
		#20 eu=0;
		#20 a=1'd4;
		#20 b=1'd2;
		#20 su=1;
		#20 eu=1;
	end
endmodule
