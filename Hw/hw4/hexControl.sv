
//This module is for controlling the HEX led outputs based in my counter input
//input: count represents the numbers 0 - 25 the amount of cars in the parking lot
//output: the output is either CLEAr, 1- 24 , or FULL
module hexControl(count, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

	input logic [4:0] count;
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	
	//cominational logic for the HEX based on the count
	always_comb begin
		case(count)
			5'b00000 :	begin 
							HEX0 = 7'b1000000; //0
							HEX1 = 7'b0101111; //R
							HEX2 = 7'b0001000; //A
							HEX3 = 7'b0000110; //E
							HEX4 = 7'b1000111; //L
							HEX5 = 7'b1000110; //C
							end
			5'b00001 :	begin 
							HEX0 = 7'b1111001; //1
							HEX1 = 7'b1111111; //OFF
							HEX2 = 7'b1111111; //OFF
							HEX3 = 7'b1111111; //OFF
							HEX4 = 7'b1111111; //OFF
							HEX5 = 7'b1111111; //OFF
							end
			5'b00010 :	begin
							HEX0 = 7'b0100100; //2
							HEX1 = 7'b1111111; //OFF
							HEX2 = 7'b1111111; //OFF
							HEX3 = 7'b1111111; //OFF
							HEX4 = 7'b1111111; //OFF
							HEX5 = 7'b1111111; //OFF
							end
			5'b00011 :	begin
							HEX0 = 7'b0110000; //3
							HEX1 = 7'b1111111; //OFF
							HEX2 = 7'b1111111; //OFF
							HEX3 = 7'b1111111; //OFF
							HEX4 = 7'b1111111; //OFF
							HEX5 = 7'b1111111; //OFF
							end
			5'b00100 :	begin
							HEX0 = 7'b0011001; //4
							HEX1 = 7'b1111111; //OFF
							HEX2 = 7'b1111111; //OFF
							HEX3 = 7'b1111111; //OFF
							HEX4 = 7'b1111111; //OFF
							HEX5 = 7'b1111111; //OFF
							end
			5'b00101 :	begin
							HEX0 = 7'b0010010; //5
							HEX1 = 7'b1111111; //OFF
							HEX2 = 7'b1111111; //OFF
							HEX3 = 7'b1111111; //OFF
							HEX4 = 7'b1111111; //OFF
							HEX5 = 7'b1111111; //OFF
							end
			5'b00110 :	begin
							HEX0 = 7'b0000011; //6
							HEX1 = 7'b1111111; //OFF
							HEX2 = 7'b1111111; //OFF
							HEX3 = 7'b1111111; //OFF
							HEX4 = 7'b1111111; //OFF
							HEX5 = 7'b1111111; //OFF
							end
			5'b00111 :	begin
							HEX0 = 7'b1111000; //7
							HEX1 = 7'b1111111; //OFF
							HEX2 = 7'b1111111; //OFF
							HEX3 = 7'b1111111; //OFF
							HEX4 = 7'b1111111; //OFF
							HEX5 = 7'b1111111; //OFF
							end
			5'b01000 :	begin
							HEX0 = 7'b0000000; //8
							HEX1 = 7'b1111111; //OFF
							HEX2 = 7'b1111111; //OFF
							HEX3 = 7'b1111111; //OFF
							HEX4 = 7'b1111111; //OFF
							HEX5 = 7'b1111111; //OFF
							end
			5'b01001 :	begin
							HEX0 = 7'b0011000; //9
							HEX1 = 7'b1111111; //OFF
							HEX2 = 7'b1111111; //OFF
							HEX3 = 7'b1111111; //OFF
							HEX4 = 7'b1111111; //OFF
							HEX5 = 7'b1111111; //OFF
							end
			5'b01010 :	begin
							HEX0 = 7'b1000000; //0
							HEX1 = 7'b1111001; //1
							HEX2 = 7'b1111111; //OFF
							HEX3 = 7'b1111111; //OFF
							HEX4 = 7'b1111111; //OFF
							HEX5 = 7'b1111111; //OFF
							end
			5'b01011 :	begin
							HEX0 = 7'b1111001; //1
							HEX1 = 7'b1111001; //1
							HEX2 = 7'b1111111; //OFF
							HEX3 = 7'b1111111; //OFF
							HEX4 = 7'b1111111; //OFF
							HEX5 = 7'b1111111; //OFF
							end
			5'b01100 :	begin 
							HEX0 = 7'b0100100; //2
							HEX1 = 7'b1111001; //1
							HEX2 = 7'b1111111; //OFF
							HEX3 = 7'b1111111; //OFF
							HEX4 = 7'b1111111; //OFF
							HEX5 = 7'b1111111; //OFF
							end
			5'b01101 :	begin
							HEX0 = 7'b0110000; //3
							HEX1 = 7'b1111001; //1
							HEX2 = 7'b1111111; //OFF
							HEX3 = 7'b1111111; //OFF
							HEX4 = 7'b1111111; //OFF
							HEX5 = 7'b1111111; //OFF
							end
			5'b01110 :	begin
							HEX0 = 7'b0011001; //4
							HEX1 = 7'b1111001; //1
							HEX2 = 7'b1111111; //OFF
							HEX3 = 7'b1111111; //OFF
							HEX4 = 7'b1111111; //OFF
							HEX5 = 7'b1111111; //OFF
							end
			5'b01111 :	begin
							HEX0 = 7'b0010010; //5
							HEX1 = 7'b1111001; //1
							HEX2 = 7'b1111111; //OFF
							HEX3 = 7'b1111111; //OFF
							HEX4 = 7'b1111111; //OFF
							HEX5 = 7'b1111111; //OFF
							end
			5'b10000 :	begin
							HEX0 = 7'b0000011; //6
							HEX1 = 7'b1111001; //1
							HEX2 = 7'b1111111; //OFF
							HEX3 = 7'b1111111; //OFF
							HEX4 = 7'b1111111; //OFF
							HEX5 = 7'b1111111; //OFF
							end
			5'b10001 :	begin
							HEX0 = 7'b1111000; //7
							HEX1 = 7'b1111001; //1
							HEX2 = 7'b1111111; //OFF
							HEX3 = 7'b1111111; //OFF
							HEX4 = 7'b1111111; //OFF
							HEX5 = 7'b1111111; //OFF
							end
			5'b10010 :	begin
							HEX0 = 7'b0000000; //8
							HEX1 = 7'b1111001; //1
							HEX2 = 7'b1111111; //OFF
							HEX3 = 7'b1111111; //OFF
							HEX4 = 7'b1111111; //OFF
							HEX5 = 7'b1111111; //OFF
							end
			5'b10011 :	begin
							HEX0 = 7'b0011000; //9
							HEX1 = 7'b1111001; //1
							HEX2 = 7'b1111111; //OFF
							HEX3 = 7'b1111111; //OFF
							HEX4 = 7'b1111111; //OFF
							HEX5 = 7'b1111111; //OFF
							end
			5'b10100 :	begin
							HEX0 = 7'b1000000; //0
							HEX1 = 7'b0100100; //2
							HEX2 = 7'b1111111; //OFF
							HEX3 = 7'b1111111; //OFF
							HEX4 = 7'b1111111; //OFF
							HEX5 = 7'b1111111; //OFF
							end
			5'b10101 :	begin
							HEX0 = 7'b1111001; //1
							HEX1 = 7'b0100100; //2
							HEX2 = 7'b1111111; //OFF
							HEX3 = 7'b1111111; //OFF
							HEX4 = 7'b1111111; //OFF
							HEX5 = 7'b1111111; //OFF
							end
			5'b10110 :	begin
							HEX0 = 7'b0100100; //2
							HEX1 = 7'b0100100; //2
							HEX2 = 7'b1111111; //OFF
							HEX3 = 7'b1111111; //OFF
							HEX4 = 7'b1111111; //OFF
							HEX5 = 7'b1111111; //OFF
							end
			5'b10111 :	begin
							HEX0 = 7'b0110000; //3
							HEX1 = 7'b0100100; //2
							HEX2 = 7'b1111111; //OFF
							HEX3 = 7'b1111111; //OFF
							HEX4 = 7'b1111111; //OFF
							HEX5 = 7'b1111111; //OFF
							end
			5'b11000 :	begin
							HEX0 = 7'b0011001; //4
							HEX1 = 7'b0100100; //2
							HEX2 = 7'b1111111; //OFF
							HEX3 = 7'b1111111; //OFF
							HEX4 = 7'b1111111; //OFF
							HEX5 = 7'b1111111; //OFF
							end
			5'b11001 :	begin
							HEX0 = 7'b1111111; //OFF
							HEX1 = 7'b1111111; //OFF
							HEX2 = 7'b1000111; //L
							HEX3 = 7'b1000111; //L
							HEX4 = 7'b1000001; //U
							HEX5 = 7'b0001110; //F
							end
			default :   begin
							HEX0 = 7'b1111111; //OFF
							HEX1 = 7'b1111111; //OFF
							HEX2 = 7'b1111111; //OFF
							HEX3 = 7'b1111111; //OFF
							HEX4 = 7'b1111111; //OFF
							HEX5 = 7'b1111111; //OFF
							end
		endcase
	end
	
endmodule

module hexControl_testbench();

	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [4:0] count;

	hexControl dut (.count, .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5);
	
	integer i;
	initial begin
		for (i=0; i<2**5; i++) begin
			count[4:0] = i; #10;
		end
	end
endmodule



