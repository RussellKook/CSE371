
//This module is for controlling the HEX led outputs to represent memory address
//input: SW8-4
//output: the output is 2 hex displays
module twoHexControlTask4 (count, HEX0, HEX1);

	input logic [4:0] count;
	output logic [6:0] HEX0, HEX1;
	
	//cominational logic for the HEX based on the count
	always_comb begin
		case(count)
			//					    6		 0
			5'h00 :  begin  
						HEX0 = 7'b1000000; //0
						HEX1 = 7'b1000000; //0
					   end
			5'h01 :  begin  
						HEX0 = 7'b1000000; //0
						HEX1 = 7'b1111001; //1
					   end
			5'h02 :  begin  
						HEX0 = 7'b1000000; //0
						HEX1 = 7'b0100100; //2
					   end
			5'h03 :  begin  
						HEX0 = 7'b1000000; //0
						HEX1 = 7'b0110000; //3
					   end
			5'h04 :  begin  
						HEX0 = 7'b1000000; //0
						HEX1 = 7'b0011001; //4
					   end
			5'h05 :  begin  
						HEX0 = 7'b1000000; //0
						HEX1 = 7'b0010010; //5
					   end
			5'h06 :  begin  
						HEX0 = 7'b1000000; //0
						HEX1 = 7'b0000010; //6
					   end
			5'h07 :  begin  
						HEX0 = 7'b1000000; //0
						HEX1 = 7'b1111000; //7
					   end
			5'h08 :  begin  
						HEX0 = 7'b1000000; //0
						HEX1 = 7'b0000000; //8
					   end
			4'h09 :  begin  
						HEX0 = 7'b1000000; //0
						HEX1 = 7'b0011000; //9
					   end
			5'h0A :  begin  
						HEX0 = 7'b1000000; //0
						HEX1 = 7'b0001000; //A
					   end
			5'h0B :  begin  
						HEX0 = 7'b1000000; //0
						HEX1 = 7'b0000011; //b
					   end
			5'h0C :  begin  
						HEX0 = 7'b1000000; //0
						HEX1 = 7'b1000110; //C
					   end
			5'h0D :  begin  
						HEX0 = 7'b1000000; //0
						HEX1 = 7'b0100001; //d
					   end
			5'h0E :  begin  
						HEX0 = 7'b1000000; //0
						HEX1 = 7'b0000110; //E
					   end
			5'h0F :  begin  
						HEX0 = 7'b1000000; //0
						HEX1 = 7'b0001110; //F
					   end
			5'h10 :  begin  
						HEX0 = 7'b1111001; //1
						HEX1 = 7'b1000000; //0
					   end
			5'h11 :  begin  
						HEX0 = 7'b1111001; //1
						HEX1 = 7'b1111001; //1
					   end
			5'h12 :  begin  
						HEX0 = 7'b1111001; //1
						HEX1 = 7'b0100100; //2
					   end
			5'h13 :  begin  
						HEX0 = 7'b1111001; //1
						HEX1 = 7'b0110000; //3
					   end
			5'h14 :  begin  
						HEX0 = 7'b1111001; //1
						HEX1 = 7'b0011001; //4
					   end
			5'h15 :  begin  
						HEX0 = 7'b1111001; //1
						HEX1 = 7'b0010010; //5
					   end
			5'h16 :  begin  
						HEX0 = 7'b1111001; //1
						HEX1 = 7'b0000010; //6
					   end
			5'h17 :  begin  
						HEX0 = 7'b1111001; //1
						HEX1 = 7'b1111000; //7
					   end
			5'h18 :  begin  
						HEX0 = 7'b1111001; //1
						HEX1 = 7'b0000000; //8
					   end
			5'h19 :  begin  
						HEX0 = 7'b1111001; //1
						HEX1 = 7'b0011000; //9
					   end
			5'h1A :  begin  
						HEX0 = 7'b1111001; //1
						HEX1 = 7'b0001000; //A
					   end
			5'h1B :  begin  
						HEX0 = 7'b1111001; //1
						HEX1 = 7'b0000011; //b
					   end
			5'h1C :  begin  
						HEX0 = 7'b1111001; //1
						HEX1 = 7'b1000110; //C
					   end
			5'h1D :  begin  
						HEX0 = 7'b1111001; //1
						HEX1 = 7'b0100001; //d
					   end
			5'h1E :  begin  
						HEX0 = 7'b1111001; //1
						HEX1 = 7'b0000110; //E
					   end
			5'h1F :  begin  
						HEX0 = 7'b1111001; //1
						HEX1 = 7'b0001110; //F
					   end
		endcase
	end
	
endmodule

module twoHexControlTask4_testbench();

	logic [6:0] HEX0, HEX1;
	logic [4:0] count;

	twoHexControlTask4 dut (.count, .HEX0, .HEX1);
	
	integer i;
	initial begin
		for (i=0; i<2**5; i++) begin
			count[4:0] = i; #10;
		end
	end
endmodule
