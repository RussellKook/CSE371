module fullAdder(x, y, s, clk, reset);
	input logic x, y, clk, reset;
	output logic s;
	
	enum {s0, s1} ps, ns;
	
	always_comb begin
		case(ps)
			s0: if(x == 0 & y == 0) ns = s0;
				else if(x == 0 & y == 1) ns = s0;
				else if(x == 1 & y == 0) ns = s0;
				else if(x == 1 & y == 1) ns = s1;
				else ns = ps;
			s1: if(x == 0 & y == 0) ns = s0;
				else if(x == 0 & y == 1) ns = s1;
				else if(x == 1 & y == 0) ns = s1;
				else if(x == 1 & y == 1) ns = s1;
				else ns = ps;
		endcase
	end
	
	assign s = (x & ~y & (ps == s0)) | (x & y & (ps == s1)) | (~x & y & (ps == s0)) | (~x & ~y & (ps == s1));

	always_ff @ (posedge clk) begin
		if(reset) 
			ps <= s0;
		else 
			ps <= ns;
	end
endmodule

module fullAdder_testbench();
	logic x, y, s, clk, reset;
	
	fullAdder dut (.x, .y, .s, .clk, .reset);
	
	// Set up the clock.
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
	x <= 0; y <= 0;			@(posedge clk);
	x <= 0; y <= 1;			@(posedge clk);
	x <= 1; y <= 0;			@(posedge clk);
	x <= 1; y <= 1;			@(posedge clk);
	x <= 0; y <= 1;			@(posedge clk);
	x <= 1; y <= 0;			@(posedge clk);
	x <= 1; y <= 1;			@(posedge clk);
	x <= 0; y <= 0;			@(posedge clk);
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
	
	
	
	
	
	
	
	
	
	