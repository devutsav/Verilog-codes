module sipo(a,clk,rst,q);
	input clk,rst;
	input a;
	output [7:0]q;
	reg [7:0]temp;
	always@(posedge clk,posedge rst)
	begin
		if(rst==1'b1)
			temp<=8'b00000000;
		else begin
			temp<=temp<<1'b1;
			temp[0]<=a;
		end
	end
	assign q=temp;
endmodule

module tg(a,clk,rst,q);
	output reg clk,rst;
	output reg a;
	input [7:0]q;
	reg [7:0]temp;
     		initial
			clk=1'b1;
		always #5 clk=~clk;
		initial begin
			$monitor($time,,"clk= %b, rst= %b, inp= %b , q= %b ,output= %b",clk,rst,a,q,q[0]);
			rst=1'b0; a=1'b1;
			//#10 rst=1'b0;
			#10 a=1'b1;
			#10 a=1'b1;
			#10 a=1'b0;
			#10 a=1'b0;
			#10 a=1'b1;
			#10 a=1'b0;
			#10 a=1'b1;
			#10 a=1'b1;
			#10 a=1'b0;
			#10 rst=1'b1;a=1'b1;
			$finish;
		end

 endmodule

module wb;
	wire w1,w2,w3,w5;
	wire [7:0] w4;
	sipo ss(w1,w2,w3,w4);
	tg t1(w1,w2,w3,w4);
endmodule
