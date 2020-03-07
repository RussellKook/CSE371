
module d_ff (clk, reset, d, q);

	input logic signed [23:0] d;
	input logic clk, reset;
	output logic signed [23:0] q;
	
	always_ff @(posedge clk) begin
		if(reset) 
			q <= 0;
		else
			q <= d;
	end

endmodule
