
//This module is high level for a binary search in a 32 word sorted array
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW, CLOCK_50);

	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;
	input logic CLOCK_50; //50MHz clock
	
	
	logic load_A, load_initial_index, dec_index, inc_index, found;
	
	logic val_lower_A, out_of_bounds, done;
	
	logic [4:0] index;
	
	logic [7:0] data_from_mem;

	
	assign HEX2 = 7'b1111111;
	assign HEX3 = 7'b1111111;
	assign HEX4 = 7'b1111111;
	assign HEX5 = 7'b1111111;
	
	//hex controls for hex 0 and hex 1 displaying the address in hex
	hex_display hex0 (.num(index[3:0]), .HEX(HEX0), .found);
	
	hex_display hex1 (.num(index[4]), .HEX(HEX1), .found);
	
	//ram 32x8 shell which connects to the ram32_8.v file
	ram32_8 ram (.clk(CLOCK_50), .address(index), .data_in(8'b00000000), .wren(1'b0), .data_out(data_from_mem));
	
	//controller
	controller c (.start(SW[9]), .reset(~KEY[0]), .clk(CLOCK_50), .found, .load_A, .load_initial_index, .dec_index, .inc_index, .val_lower_A, .out_of_bounds, .done);
	
	//datapath
	datapath d (.clk(CLOCK_50), .load_A, .load_initial_index, .dec_index, .inc_index, .data_from_mem, .data_A(SW[7:0]), .found, .address_to_mem(index), .val_lower_A, .out_of_bounds);
	
	assign LEDR[9] = found;
	

	
endmodule


`timescale 1ps/1ps
module DE1_SoC_testbench();

	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;
	logic CLOCK_50;
	DE1_SoC dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW, .CLOCK_50);
	
	parameter CLOCK_PERIOD = 50; //10 ns
	
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
		
	end
	
	initial begin
		KEY[0] <= 0;  @(posedge CLOCK_50);  //reset clock
		KEY[0] <= 1; @(posedge CLOCK_50);
						 @(posedge CLOCK_50);	//trying to find 32
		SW[7:0] <= 8'b00011111; SW[9] <= 1'b0;@(posedge CLOCK_50);
		SW[9] <= 1'b1; @(posedge CLOCK_50);
						   @(posedge CLOCK_50);
							@(posedge CLOCK_50); 
							@(posedge CLOCK_50);
							@(posedge CLOCK_50); 
							@(posedge CLOCK_50);
							@(posedge CLOCK_50); 
							@(posedge CLOCK_50);
							@(posedge CLOCK_50); 
							@(posedge CLOCK_50); 
							@(posedge CLOCK_50);
							@(posedge CLOCK_50); 
							@(posedge CLOCK_50);
							@(posedge CLOCK_50); 
							@(posedge CLOCK_50);
							@(posedge CLOCK_50); 
							@(posedge CLOCK_50); 
							@(posedge CLOCK_50);
							@(posedge CLOCK_50); 
							@(posedge CLOCK_50);
							@(posedge CLOCK_50); 
							@(posedge CLOCK_50);
							@(posedge CLOCK_50); 
							@(posedge CLOCK_50); 
							@(posedge CLOCK_50);
							@(posedge CLOCK_50); 
							@(posedge CLOCK_50);
							@(posedge CLOCK_50); 
							@(posedge CLOCK_50);
							@(posedge CLOCK_50); 
							@(posedge CLOCK_50); 
							@(posedge CLOCK_50);
							@(posedge CLOCK_50); 
							@(posedge CLOCK_50);
							@(posedge CLOCK_50); 
							@(posedge CLOCK_50);
							@(posedge CLOCK_50); 
							@(posedge CLOCK_50); 
							@(posedge CLOCK_50);
							@(posedge CLOCK_50); 
							@(posedge CLOCK_50);
							@(posedge CLOCK_50); 
							@(posedge CLOCK_50);
							@(posedge CLOCK_50); 
							@(posedge CLOCK_50); 
							@(posedge CLOCK_50);
							@(posedge CLOCK_50); 
							@(posedge CLOCK_50);
							@(posedge CLOCK_50); 
							@(posedge CLOCK_50);
							@(posedge CLOCK_50); 
							@(posedge CLOCK_50); 
							@(posedge CLOCK_50);
							@(posedge CLOCK_50); 
							@(posedge CLOCK_50);
							@(posedge CLOCK_50); 
							@(posedge CLOCK_50);
							@(posedge CLOCK_50); 
		$stop;
	end
	
		
endmodule

