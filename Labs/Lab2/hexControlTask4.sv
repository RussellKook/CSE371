
//This module is for controlling the HEX led outputs on SW input 4 bit
//input: 4 bit SW
//output: the output is in hex
module hexControlTask4(count, HEX);

	input logic [3:0] count;
	output logic [6:0] HEX;
	
	//cominational logic for the HEX based on the count
	always_comb begin
		case(count)
			//					 6		 0
			4'h0 : HEX = 7'b1000000; //0
			4'h1 : HEX = 7'b1111001; //1
			4'h2 : HEX = 7'b0100100; //2
			4'h3 : HEX = 7'b0110000; //3
			4'h4 : HEX = 7'b0011001; //4
			4'h5 : HEX = 7'b0010010; //5
			4'h6 : HEX = 7'b0000010; //6
			4'h7 : HEX = 7'b1111000; //7
			4'h8 : HEX = 7'b0000000; //8
			4'h9 : HEX = 7'b0011000; //9
			4'hA : HEX = 7'b0001000; //A
			4'hB : HEX = 7'b0000011; //b
			4'hC : HEX = 7'b1000110; //C
			4'hD : HEX = 7'b0100001; //d
			4'hE : HEX = 7'b0000110; //E
			4'hF : HEX = 7'b0001110; //F
		endcase
	end
	
endmodule

module hexControlTask4_testbench();

	logic [6:0] HEX;
	logic [3:0] count;

	hexControlTask4 dut (.count, .HEX);
	
	integer i;
	initial begin
		for (i=0; i<2**4; i++) begin
			count[3:0] = i; #10;
		end
	end
endmodule
