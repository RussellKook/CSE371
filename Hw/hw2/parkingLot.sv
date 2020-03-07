
//This module is to represent a parking lot with inputs and outputs as stated
//Input: A and B are proximity sensors for the car
//Output: enter and exit tell if a car is entering the parking lot or exiting the parking lot

module parkingLot (A, B, enter, exit, reset, clk);
	
	input logic A, B, reset, clk;
	output logic enter, exit;

	enum {s0, s1, s2, s3, s4, s5, s6} ns, ps;
	
	//states of the sensors to tell if a car is entering or exiting
	always_comb begin
		case(ps)
			s0: if (~A & ~B) ns = s0;
			else if (~A & B) ns = s4;
			else if (A & ~B) ns = s1;
			else ns = s0;
			s1: if (~A & ~B) ns = s0;
			else if (~A & B) ns = s0;
			else if (A & ~B) ns = s1;
			else ns = s2;
			s2: if (~A & ~B) ns = s0;
			else if (~A & B) ns = s3;
			else if (A & ~B) ns = s0;
			else ns = s2;
			s3: if (~A & ~B) ns = s0;
			else if (~A & B) ns = s3;
			else if (A & ~B) ns = s0;
			else ns = s0;
			s4: if (~A & ~B) ns = s0;
			else if (~A & B) ns = s4;
			else if (A & ~B) ns = s0;
			else ns = s5;
			s5: if (~A & ~B) ns = s0;
			else if (~A & B) ns = s0;
			else if (A & ~B) ns = s6;
			else ns = s5;
			s6: if (~A & ~B) ns = s0;
			else if (~A & B) ns = s0;
			else if (A & ~B) ns = s6;
			else ns = s0;
		endcase
	end
	
	//output logic to tell if car is entering or exiting
	assign enter = ((ps == s3) & (A == 0) & (B == 0));
	assign exit = ((ps == s6) & (A == 0) & (B == 0));
	
	//dff for the FSM with reset
	always_ff @(posedge clk) begin
		if (reset) 
			ps <= s0;
		else 
			ps <= ns;
	end


endmodule

module parkingLot_testbench();

	logic A, B, enter, exit, reset, clk;
	
	parkingLot dut (.A, .B, .enter, .exit, .reset, .clk);
	
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
	reset <= 0;	A <= 1; B<= 0;				@(posedge clk);
	A <= 1; B<= 1;								@(posedge clk);								
	A <= 0; B<= 1;								@(posedge clk);
	A <= 0; B<= 0;								@(posedge clk);
												@(posedge clk);
	A <= 0; B<= 1;								@(posedge clk);
	A <= 1; B<= 1;								@(posedge clk);
	A <= 1; B<= 0;								@(posedge clk);
	A <= 0; B<= 0;								@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									
	$stop;
	end
endmodule