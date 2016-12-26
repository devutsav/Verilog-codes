module mealy( clk, rst, inp, outp, state, nextstate);

   input clk, rst, inp;
   //output outp;

   output reg [1:0] state; 
   output reg [1:0] nextstate;
   output reg [1:0] outp;
   parameter A=2'b00,
             B=2'b01,
             C=2'b10,
             D=2'b11; 

  always @(state , inp , nextstate) begin
      // assign state <= A;
       case(state)
       A: begin
            if(inp) begin
               nextstate <= D;
               outp  <= 2'b11;
            end
            else begin
                nextstate <= D;
                outp <= 2'b11;
            end
       end

       B: begin
            if(inp) begin
                nextstate <= C;
                outp  <= 2'b01;
            end
            else  begin
               nextstate <= D;
               outp <= 2'b10;
            end

       end

       C: begin
            if(inp) begin
                nextstate <= B;
                outp  <= 2'b01;
            end
            else begin
               nextstate <= D;
               outp <= 2'b00;
            end

       end
       
	D: begin
            if(inp) begin
                nextstate <= C;
                outp  <= 2'b01;
            end
            else begin
               nextstate <= D;
               outp <= 2'b00;
            end

       end
       default: begin
          state <= A;
       end
     endcase
  end
  always @( posedge clk or rst ) begin
   if(rst==1'b1) begin
       state <= A;
       nextstate <= A;
   end
   else begin
	state <= nextstate;
    end
   end

endmodule

module tg(clk, rst, inp, outp,state,nextstate);
        output reg clk, rst, inp;
	input [1:0] state; 
   	input [1:0] nextstate;
   	input [1:0] outp;
	integer i;
	output reg [0:11] seq;
          initial begin 
		clk=0;
		   //#5 rst=1;
			seq=12'b100101101111;
			clk=1;
			#5 rst=1;
			#5 rst=0;
			//#1 state=2'b00;
			for(i=0;i<12;i=i+1)
			begin
				inp=seq[i];
				#10 clk=1;
				//#10 clk=0;
		          $display("clk= %b, rst= %b, state= %b, inp= %b, nextstate= %b, outp= %b",clk,rst,state,inp,nextstate,outp);
			end
	
		$finish;
			
	end
	always@ (clk) 
			#5 clk=~clk;

endmodule

module wb;
	wire w1,w2,w3,w4,w5;
	wire [1:0] ww1,ww2;
	wire [1:0] ww;
	tg t1(w1, w2, w3, ww, ww1, ww2);
	mealy m1(w1, w2, w3, ww, ww1, ww2);
	
endmodule
