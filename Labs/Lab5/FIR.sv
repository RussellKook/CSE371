

module FIR (clk, reset, D, Q, Q_8); 

	input logic clk, reset;
	input logic [23:0] D;
	output logic [23:0] Q, Q_8;
	
	always_ff @(posedge clk) begin
		if(reset) begin
			Q <= 0;
			Q_8 <= 0;
		end else begin
			Q <= D;
			Q_8 <= D / 8;
		end
	end
	
endmodule

