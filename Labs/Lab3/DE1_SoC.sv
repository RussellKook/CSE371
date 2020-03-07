module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW, CLOCK_50, 
	VGA_R, VGA_G, VGA_B, VGA_BLANK_N, VGA_CLK, VGA_HS, VGA_SYNC_N, VGA_VS);
	
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;

	input CLOCK_50;
	output [7:0] VGA_R;
	output [7:0] VGA_G;
	output [7:0] VGA_B;
	output VGA_BLANK_N;
	output VGA_CLK;
	output VGA_HS;
	output VGA_SYNC_N;
	output VGA_VS;
	
	assign HEX0 = '1;
	assign HEX1 = '1;
	assign HEX2 = '1;
	assign HEX3 = '1;
	assign HEX4 = '1;
	assign HEX5 = '1;
	assign LEDR = SW;
	logic reset, resetScreen, animateScreen;
	logic [10:0] x0, y0, x1, y1, x, y, x0clear, x1clear, y0clear, y1clear, x0input, x1input, y0input, y1input, x0current, x1current, y0current, y1current;
	logic erase, white, move, cw, write1, write2, start, done;
	logic animate, still;
	logic [9:0] counter, vcounter; //0-1023
	//logic [1:0] S;
	logic [7:0] VGA_R1, VGA_G1, VGA_B1, VGA_R2, VGA_G2, VGA_B2, VGA_Rtemp, VGA_Gtemp, VGA_Btemp;
	logic VGA_BLANK_N1, VGA_CLK1, VGA_HS1, VGA_SYNC_N1, VGA_VS1, VGA_BLANK_N2, VGA_CLK2, VGA_HS2, VGA_SYNC_N2, VGA_VS2, VGA_BLANK_Ntemp, VGA_CLKtemp, VGA_HStemp, VGA_SYNC_Ntemp, VGA_VStemp, S;
	
	//logic for clock divider
	logic [31:0] slow_clk;
	parameter whichClock = 23; 
	

	//
	enum {resetState, normal, clear, update, idle} ns, ps;

	assign resetScreen = SW[0];
	assign reset = SW[9];
	assign animate = SW[1];
	assign still = SW[2];
	
	//ck_divider cdiv (.clock(CLOCK_50), .divided_clocks(slow_clk), .reset); //example .clk(clk_1sec[whichClock])
	
	line_drawer lines (.color(white), .clk(CLOCK_50), .reset,
				.x0, .y0, .x1, .y1, .x, .y, .done);
	
	drawer draw (.clk(CLOCK_50), .reset, .animate, .done, .white, .x0, .y0, .x1, .y1, .resetScreen);
	
	VGA_framebuffer fb1 (.clk50(CLOCK_50), .reset, .x, .y,
				.pixel_color(white), .pixel_write(1'b1),
				.VGA_R, .VGA_G, .VGA_B, .VGA_CLK, .VGA_HS, .VGA_VS,
				.VGA_BLANK_n(VGA_BLANK_N), .VGA_SYNC_n(VGA_SYNC_N));








	
	
endmodule
	// divided_clocks[0] = 25MHz, [1] = 12.5Mhz, ... [23] = 3Hz, [24] = 1.5Hz,
	//[25] = 0.75Hz, ...
module clock_divider (clock, divided_clocks, reset);
		input logic clock, reset;
		output logic [31:0] divided_clocks;

		always_ff @(posedge clock) begin
			if(reset) 
				divided_clocks <= 0;
			else
				divided_clocks <= divided_clocks + 1;
		end

endmodule			

	
module DE1_SoC_testbench();
	 logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	 logic [9:0] LEDR;
	 logic [3:0] KEY;
	 logic [9:0] SW;

	 logic CLOCK_50;
	logic [7:0] VGA_R;
	logic [7:0] VGA_G;
	logic [7:0] VGA_B;
	logic VGA_BLANK_N;
	logic VGA_CLK;
	logic VGA_HS;
	logic VGA_SYNC_N;
	logic VGA_VS;
	
	integer i;
	DE1_SoC dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW, .CLOCK_50, 
		.VGA_R, .VGA_G, .VGA_B, .VGA_BLANK_N, .VGA_CLK, .VGA_HS, .VGA_SYNC_N, .VGA_VS);
	
	parameter CLOCK_PERIOD=40;
	
	initial begin
		CLOCK_50<=0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
		
	end
	
	
	initial begin
								@(posedge CLOCK_50);
	SW[9] <= 1;							@(posedge CLOCK_50);
								@(posedge CLOCK_50);
	SW[9] <= 0;	 SW[1] <= 0; 									@(posedge CLOCK_50);
	//x0 <= 0; y0 <= 0; x1 <= 10; y1 <= 0;		@(posedge clk); //(0,0),(10,0)
	//x0 <= 0; y0 <= 0; x1 <= 0; y1 <= 10;		@(posedge clk); //(0,0),(0,10)
	//x0 <= 10; y0 <= 0; x1 <= 0; y1 <= 0;		@(posedge clk); //(10,0),(0,0)
	//x0 <= 0; y0 <= 10; x1 <= 0; y1 <= 0;		@(posedge clk); //(0,10),(0,0)
	//x0 <= 0; y0 <= 0; x1 <= 10; y1 <= 10;		@(posedge clk); //(0,0),(10,10)
	//x0 <= 10; y0 <= 10; x1 <= 0; y1 <= 0;		@(posedge clk); //(10,10),(0,0)
	//x0 <= 0; y0 <= 0; x1 <= 30; y1 <= 10;		@(posedge clk); //(0,0),(30,10)
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
		SW[1] <= 1;			@(posedge CLOCK_50);
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

									for(i = 0; i < 1000000; i++) begin
										@(posedge CLOCK_50);
									end
									$stop;
								end


endmodule
