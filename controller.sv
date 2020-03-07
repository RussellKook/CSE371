

module controller (clk, reset, iVGA_BLANK_N, reset_count, count_out, compare_out);

	input logic clk, reset, iVGA_BLANK_N;
	output logic reset_count, count_out, compare_out;
	
	enum {start, count, compare, delay} ps, ns;
	
	always_comb begin
		case(ps) 
			start: if(~iVGA_BLANK_N) ns = start;
					else ns = count;
			count: if(~iVGA_BLANK_N) ns = delay;
					else ns = count;
			delay: if(~iVGA_BLANK_N) ns = compare;
					else ns = delay;
			compare: ns = start;
		endcase
	end
	
	always_ff @(posedge clk) begin
		if(reset) ps <= start;
		else ps <= ns;
	end
	
	assign reset_count = ((ps == start) && (~iVGA_BLANK_N));
	
	assign count_out = (ps == count);
	
	assign compare_out = (ps == compare);
	
endmodule


