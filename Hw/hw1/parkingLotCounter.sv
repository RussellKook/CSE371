
//This module is a parking lot counter that counts from 0 to 25 in binary and will go no lower then 0 and no higher then 25
//Inputs: inc and dec represent logic to increment or decrement the counter.
//Output: 5 bit out logic represents the number of cars in the parking lot

module parkingLotCounter (inc, dec, out, reset, clk);
	
	input logic inc, dec, reset, clk;
	output logic [4:0] out;
	
	//counter with a dff
	always_ff @(posedge clk) begin
		if(reset)
			out <= 5'b00000;
		else if(inc & ~dec & out < 5'b11001)
			out <= out + 1'b1;
		else if(~inc & dec & out > 5'b00000)
			out <= out - 1'b1;
		else 
			out <= out;
	end
	
endmodule


module parkingLotCounter_testbench();

	logic inc, dec, reset, clk;
	logic [4:0] out;
	
	parkingLotCounter dut (.inc, .dec, .out, .reset, .clk);
	
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
	inc <= 0; dec <= 1;		@(posedge clk);
	inc <= 1; dec <= 0;		@(posedge clk);
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
		inc <= 0; dec <= 1;	@(posedge clk);
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