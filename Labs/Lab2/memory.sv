
//This is the RAM module which has a synchronus read and write
//inputs: clk, reset, wren, and address, and data
//output: q
module memory (address, clk, reset, data, wren, q);

	input logic clk, reset, wren;
	input logic [4:0] address;
	input logic [3:0] data;
	output logic [3:0] q;
	
	//ram declaration
	logic [3:0] memory_array [31:0];
	
	
	always_ff @(posedge clk) begin
		if (wren)
			memory_array[address] <= data;
		
		q <= memory_array[address];
	end
	
endmodule

module memory_testbench(); 

	logic clk, reset, wren;
	logic [4:0] address;
	logic [3:0] data;
	logic [3:0] q;
	
	memory dut (.address, .clk, .reset, .data, .wren, .q);
	
	parameter CLOCK_PERIOD=100;
	
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
		
	end
	
	// Design inputs. Each line is a clock cycle.
	
	initial begin
									@(posedge clk);
	reset <= 1;					@(posedge clk);
									@(posedge clk);
									@(posedge clk);
	reset <= 0;					@(posedge clk);
									@(posedge clk);
			//adress					data					enable  	clk
		address <= 5'b00000; data <= 4'b1111; wren <= 0;	@(posedge clk);
																		@(posedge clk);
		address <= 5'b00000; data <= 4'b1111; wren <= 1;	@(posedge clk);
																		@(posedge clk);
		address <= 5'b00001; data <= 4'b0001; wren <= 0;	@(posedge clk);
																		@(posedge clk);
		address <= 5'b00001; data <= 4'b0001; wren <= 1;	@(posedge clk);							@(posedge clk);
									@(posedge clk);
		wren <= 0;	@(posedge clk);							@(posedge clk);
									@(posedge clk);
									
	$stop;
	end
endmodule

