
//This module is a shell for the ram32x8.v file
module ram32_8 (clk, address, data_in, wren, data_out);
	input logic [4:0] address;
	input logic clk;
	input logic [7:0] data_in;
	input wren;
	output [7:0] data_out; //this is equal to q
	
	RAM32x8 ram (address, clk, data_in, wren, data_out);
	

endmodule

`timescale 1ps/1ps
module ram32_4_testbench();
	logic [4:0] address;
	logic clk, wren;
	logic [7:0] data_in, data_out;
	
	ram32_8 dut (clk, address, data_in, wren, data_out);
	
	
	parameter clock_period = 100;
	
	initial begin
		clk <= 0;
		forever #(clock_period / 2) clk <= ~clk;
	end //initial
	
	
	

	initial begin
		address<= 5'b00000; data_in <= 4'b0000; wren <= 1'b0;	@(posedge clk);
															                  @(posedge clk);
		address<= 5'b00001; data_in <= 4'b0001; wren <= 1'b1;	@(posedge clk);
															                  @(posedge clk);
		address<= 5'b00010; data_in <= 4'b0010; wren <= 1'b1;	@(posedge clk);
															                  @(posedge clk);
		address<= 5'b00011; data_in <= 4'b0001; wren <= 1'b1;	@(posedge clk);
															                  @(posedge clk);
		address<= 5'b00100; data_in <= 4'b0011; wren <= 1'b1;	@(posedge clk);
															                  @(posedge clk);
		address<= 5'b00101; data_in <= 4'b1111; wren <= 1'b1;	@(posedge clk);
															                  @(posedge clk);
		address<= 5'b00110; data_in <= 4'b1001; wren <= 1'b1;	@(posedge clk);
															                  @(posedge clk);
		address<= 5'b00111; data_in <= 4'b1001; wren <= 1'b1;	@(posedge clk);
														                     @(posedge clk);
		address<= 5'b01000; data_in <= 4'b1001; wren <= 1'b1;	@(posedge clk);
															                  @(posedge clk);
		address<= 5'b01001; data_in <= 4'b1000; wren <= 1'b1;	@(posedge clk);
															                  @(posedge clk);
		$stop;
		
	end // initial
	
endmodule

