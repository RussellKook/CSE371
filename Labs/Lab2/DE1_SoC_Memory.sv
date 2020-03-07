
//Task 1 top verilog file to read and write into memory
module DE1_SoC_Memory (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW, CLOCK_50, GPIO_0);

	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;
	input logic CLOCK_50; //50MHz clock
	inout logic [35:0] GPIO_0;
	
	
	ram32x4 ram (.address(SW[9:5]), .clock(CLOCK_50), .data(SW[4:1]), .wren(SW[0]), .q(LEDR[3:0]));
	
	
endmodule


`timescale 1 ps / 1 ps
module DE1_SoC_Memory_testbench();

	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;
	logic CLOCK_50;
	
	DE1_SoC_Memory dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW, .CLOCK_50);
	
	parameter CLOCK_PERIOD = 50; //10 ns
	
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
		
	end
	/*
	integer i;
	initial begin
		SW[9] = 1'b0;
		SW[8] = 1'b0;
		for (i=0; i<2**8; i++) begin
			SW[7:0] = i; #10;
		end
	end
	*/
	initial begin
			#100
		//adress					data					enable
		SW[9:5] = 5'b00000; SW[4:1]= 4'b1111; SW[0]= 0;	#100
		SW[9:5] = 5'b00000; SW[4:1]= 4'b1111; SW[0]= 1;	#100
			#100
		SW[9:5] = 5'b00001; SW[4:1]= 4'b1101; SW[0]= 0;	#100
		SW[9:5] = 5'b00001; SW[4:1]= 4'b1101; SW[0]= 1;	#100	
			#100
		SW[0]= 0;	#100
			#100
			#100
			#100
			#100
			#100
			#100
			#100
			#100
			#100
			#100
			#100
			#100
			#100
			#100
			
			
		$stop;
		
		end 
endmodule

