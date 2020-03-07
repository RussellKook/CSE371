
//Task 4 top verilog file to read and write into memory
module DE1_SoC_Task4 (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW, CLOCK_50, GPIO_0, data_s, q_s, addr_r_s);

	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	output logic [4:0] addr_r_s;
	output logic [3:0] data_s, q_s;
	input logic [3:0] KEY;
	input logic [9:0] SW;
	input logic CLOCK_50; //50MHz clock
	inout logic [35:0] GPIO_0;
	
	
	logic [3:0] ram_out;
	logic [4:0] counter_addr_r;
	
	//logic for clock divider
	logic [31:0] clk_1sec;
	parameter whichClock = 25; // clk is .75 second
	clock_divider cdiv (.clock(CLOCK_50), .divided_clocks(clk_1sec)); //example .clk(clk_1sec[whichClock])
	//
	
	
	hexControlTask4 hex0 (.count(ram_out), .HEX(HEX0)); //displays the ram data output
	hexControlTask4 hex1 (.count(SW[3:0]), .HEX(HEX1)); //write data input
	twoHexControlTask4 hex3_2 (.count(counter_addr_r), .HEX0(HEX3), .HEX1(HEX2)); //displays the current addr_r
	twoHexControlTask4 hex5_4 (.count(SW[8:4]), .HEX0(HEX5), .HEX1(HEX4)); //displays current write address
	
	ram32x4_task4 ram (.clock(CLOCK_50), .data(SW[3:0]),	.rdaddress(counter_addr_r),	.wraddress(SW[8:4]),	.wren(SW[9]),	.q(ram_out));
	
	
	counter count (.clk(clk_1sec[whichClock]), .reset(~KEY[0]), .addr_r(counter_addr_r));
	
	assign addr_r_s = counter_addr_r;
	assign data_s = SW[3:0];
	assign q_s = ram_out;
	

	
endmodule

// divided_clocks[0] = 25MHz, [1] = 12.5Mhz, ... [23] = 3Hz, [24] = 1.5Hz,
//[25] = 0.75Hz, ...
module clock_divider (clock, divided_clocks);
 input logic clock;
 output logic [31:0] divided_clocks;

 always_ff @(posedge clock) begin
 divided_clocks <= divided_clocks + 1;
 end

endmodule 

`timescale 1 ps / 1 ps
module DE1_SoC_Task4testbench();

	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;
	logic CLOCK_50;
	
	DE1_SoC_Task4 dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW, .CLOCK_50);
	
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
		SW[8:4] = 5'b00000; SW[3:0]= 4'b1111; SW[9]= 1;	#100
																						#100
		SW[8:4] = 5'b00000; SW[3:0]= 4'b1111; SW[9]= 1;	 #100
																						#100
		SW[8:4] = 5'b00001; SW[3:0]= 4'b0001; SW[9]= 1;	 #100
																						#100
		SW[8:4] = 5'b00001; SW[3:0]= 4'b0001; SW[9]= 1;	 #100
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

