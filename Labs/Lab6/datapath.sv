

module datapath (clk, reset, iVGA_B, iVGA_G, iVGA_R, count, compare, reset_count, color);

	input logic clk, reset;
	input logic unsigned [7:0] iVGA_B, iVGA_G, iVGA_R;
	input logic reset_count, compare, count;
	output logic [1:0] color;
	
	logic unsigned [29:0] red, green, blue, white;

	
	always_ff @(posedge clk) begin
		if(reset) begin
			color <= 2'b11;
		end
		if(reset_count || reset) begin
			red <= 0;
			green <= 0;
			blue <= 0;
			white <= 0;
		end 
		if (count) begin
			if (iVGA_R > 200 && iVGA_G > 200 && iVGA_B > 200) begin
				white <= white + 1;
			end else	if (iVGA_R > 200) begin
				red <= red + 1;
			end else if (iVGA_G > 200) begin
				green <= green + 1;
			end else if (iVGA_B > 150) begin
				blue <= blue + 1;
			end
		end
		if (compare) begin
			if ((green > (red + (green/4))) && (green > (blue + (green/4))) && (green > (white + (green/4)))) begin
				color <= 2'b01;
			end else if ((blue > (red + (blue/4))) && (blue > (green + (blue/4))) && (blue > (white + (blue/4)))) begin
				color <= 2'b10;
			end else if ((red > (green + (red/4))) && (red > (blue + (red/4))) && (red > (white + (red/4)))) begin
				color <= 2'b00;
			end else
				color <= 2'b11;
		end
	end
endmodule

module datapath_testbench();
	logic clk, reset;
	logic unsigned [7:0] iVGA_B, iVGA_G, iVGA_R;
	logic reset_count, compare, count;
	logic [1:0] color;
	
	datapath dut (.clk, .reset, .iVGA_B, .iVGA_G, .iVGA_R, .count, .compare, .reset_count, .color);
	
	parameter CLOCK_PERIOD=100;
	
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
		
	end
	
	
	initial begin
		reset <= 1; @(posedge clk);
						@(posedge clk);
		reset <=0;  count <= 1; iVGA_B <= 3; iVGA_G <= 0; iVGA_R <= 0; @(posedge clk);
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
													count <= 0; compare <= 1;		@(posedge clk);
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
																						
																											