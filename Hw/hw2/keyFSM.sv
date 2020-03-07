
//This module is to turn a KEY into a FSM to get 1 output on the lift up of the key
//Input: input logic in is the key itself
//Output: output logic out is the output when the key if lifted
module keyFSM (in, out, clk, reset);
	
	input logic in, clk, reset;
	output logic out;
	
	enum{s0, s1} ps, ns;
	
	//states of the key s0 is up and s1 is down
	always_comb begin
		case(ps)
			s0: if(in) ns = s0;
			else ns = s1;
			s1: if(in) ns = s0;
			else ns = s1;
		endcase
	end
	
	assign out = (ps == s1);
	
	//dff for my FSM
	always_ff @(posedge clk) begin
		if(reset) 
			ps <= s0;
		else
			ps <= ns;
	end
	
endmodule

module keyFSM_testbench();

	logic in, out, clk, reset;
	
	keyFSM dut (.in, .out, .clk, .reset);
	
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
	reset <= 0;	in <= 1;				@(posedge clk);
					@(posedge clk);
							@(posedge clk);
	in <= 0;								@(posedge clk);
									@(posedge clk);
	in <= 1;								@(posedge clk);
									@(posedge clk);
								@(posedge clk);
									@(posedge clk);
									
	$stop;
	end
	
	
endmodule
