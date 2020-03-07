module hw1_2(in, out, clk, reset);
	input logic in, clk, reset;
	output logic out;
	
	enum {s0, s1, s2, s3, s4} ns, ps;
	
	always_comb begin
		case(ps)
			s0: if(in) ns = s4;
			else ns = s3;
			s1: if(in) ns = s4;
			else ns = s1;
			s2: if(in) ns = s0;
			else ns = s2;
			s3: if(in) ns = s2;
			else ns = s1;
			s4: if(in) ns = s3;
			else ns = s2;
		endcase
	end
	
	assign out = (in & (ps == s0)) | (in & (ps == s1)) | (in & (ps == s2)) | (in & (ps == s3));

	always_ff @ (posedge clk) begin
		if(reset) 
			ps <= s0;
		else 
			ps <= ns;
	end
	
	
endmodule

module hw1_2_testbench();
	logic in, out, clk, reset;
	
	hw1_2 dut (.in, .out, .clk, .reset);
	
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
	reset <= 0;	in <= 0;		@(posedge clk);
	in <= 0;						@(posedge clk);
	in <= 0;						@(posedge clk);
	in <= 1;						@(posedge clk);
	in <= 1;						@(posedge clk);
	in <= 1;						@(posedge clk);
	in <= 0;						@(posedge clk);
	in <= 1;						@(posedge clk);
	in <= 1;						@(posedge clk);
	in <= 0;						@(posedge clk);			
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


