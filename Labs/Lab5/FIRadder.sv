

module FIRadder (in1, in2, read, out);
	input logic read;
	input logic [23:0] in1, in2;
	output logic [23:0] out;
	/*
	always_comb begin
		if (~read) begin
			out = in1;
		end else begin
			out = in1 + in2;
		end
	end
	*/
	assign out = in1 + in2;
	
	
endmodule

