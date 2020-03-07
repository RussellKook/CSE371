
module top_level(clk, reset, iVGA_BLANK_N, iVGA_B, iVGA_G, iVGA_R, color);
	input logic clk, reset, iVGA_BLANK_N;
	input logic unsigned [7:0] iVGA_B, iVGA_G, iVGA_R;
	output logic [1:0] color;
	
	
	logic reset_count, count, compare, out_signal;
	
	counter count_module (.clk , .reset, .out_signal);
	
	controller c (.clk, .reset, .iVGA_BLANK_N(out_signal), .reset_count, .count_out(count), .compare_out(compare));
	
	datapath d (.clk, .reset, .iVGA_B, .iVGA_G, .iVGA_R, .count, .compare, .reset_count, .color);
	
endmodule

module top_level_testbench();
	 logic clk, reset, iVGA_BLANK_N;
	 logic [7:0] iVGA_B, iVGA_G, iVGA_R;
	 logic [1:0] color;
	
	top_level dut (.clk, .reset, .iVGA_BLANK_N, .iVGA_B, .iVGA_G, .iVGA_R, .color);
	
	parameter CLOCK_PERIOD=100;
	
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
		
	end
	
	
	initial begin
		reset <= 1; @(posedge clk);
						@(posedge clk);
		reset <=0;  iVGA_BLANK_N <= 1; iVGA_B <= 25; iVGA_G <= 30; iVGA_R <= 25; @(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
													iVGA_BLANK_N <= 0;		      @(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
													iVGA_BLANK_N <= 1;	 iVGA_B <=30; iVGA_G <= 25; iVGA_R <= 25;			@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
													iVGA_BLANK_N <= 0;										@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
																							@(posedge clk);
	$stop;
	end
endmodule
																						
																											