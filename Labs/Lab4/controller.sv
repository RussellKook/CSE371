
//controller for binary search
module controller(start, reset, clk, found, load_A, load_initial_index, dec_index, inc_index, val_lower_A, out_of_bounds, done);
	input logic start, reset, clk, found, val_lower_A, out_of_bounds;
	output logic load_A, load_initial_index, dec_index, inc_index, done;
	enum {s1, s2, s3, s4, s5, s6, delay, delay2} ps, ns;
	
	//FSM combinational logic
	always_comb begin
		case (ps)
			s1: if (start) ns = s2;
				 else ns = s1;
			s2: ns = delay2;
			delay2: ns = delay;
			delay: if (found) ns = s3;
				 else ns = s4;
			s3: if (start) ns = s3;
			    else ns = s1;
			s4: if (out_of_bounds) ns = s3;
			    else ns = s5;
			s5: ns = s6;
			s6: ns = s2;
		endcase
	end
	
	//FSM clocked logic
	always_ff @(posedge clk) begin
		if (reset) begin
			ps <= s1;
		end else begin
			ps <= ns;
		end
	end 
	
	//outputs that go into the datapath
	assign load_A = (ps == s1) && ~start;
	
	assign load_initial_index = (ps == s1) && ~start;
	
	assign inc_index = (ps == s5) && val_lower_A;
	
	assign dec_index = (ps == s5) && ~val_lower_A;		
	
	assign done = (ps == s3);
	
endmodule