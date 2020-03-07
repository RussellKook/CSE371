
//this is my top level
module drawer (clk, reset, animate, done, white, x0, y0, x1, y1, resetScreen);

	input logic clk, reset, animate, done, resetScreen;
	output logic white;
	output logic [10:0] x0, y0, x1, y1;
	logic [10:0] x0past, y0past, x1past, y1past;
	logic color;
	
	enum {s0, rightErase, rightUpdate, rightHold, downErase, downUpdate, downHold, leftErase, leftUpdate, leftHold, upErase, upUpdate, upHold} ns, ps;
	logic [31:0] delayClk;
	parameter whichClk = 1;
	
	
	always_comb begin
		case(ps) 
			s0: if(animate) ns = rightErase;
				else ns = s0;
			
			rightErase:
				if(~animate) ns = s0;
				else ns = rightUpdate;
			rightUpdate:  
				if(~animate) ns = s0;
				else ns = rightHold;
			rightHold:
				if(delayClk[whichClk] && x0past == 210) ns = downErase;
				else if(delayClk[whichClk] && x0past != 210) ns = rightErase;
				else ns = rightHold;
			
			downErase:
				if(~animate) ns = s0;
				else ns = downUpdate;
			downUpdate:  
				if(~animate) ns = s0;
				else ns = downHold;
			downHold:
				if(delayClk[whichClk] && y0past == 125) ns = leftErase;
				else if(delayClk[whichClk] && y0past != 125) ns = downErase;
				else ns = downHold;
			
			leftErase:
				if(~animate) ns = s0;
				else ns = leftUpdate;
			leftUpdate:  
				if(~animate) ns = s0;
				else ns = leftHold;
			leftHold:
				if(delayClk[whichClk] && x0past == 110) ns = upErase;
				else if(delayClk[whichClk] && x0past != 110) ns = leftErase;
				else ns = leftHold;
			
			upErase:
				if(~animate) ns = s0;
				else ns = upUpdate;
			upUpdate:  
				if(~animate) ns = s0;
				else ns = upHold;
			upHold:
				if(delayClk[whichClk] && y0past == 25) ns = rightErase;
				else if(delayClk[whichClk] && y0past != 25) ns = upErase;
				else ns = upHold;	
			
		endcase
	end
	
	always_ff @(posedge clk) begin
		if(reset || (ps == rightUpdate && ns == rightHold)|| (ps == downUpdate && ns == downHold)|| (ps == leftUpdate && ns == leftHold)|| (ps == upUpdate && ns == upHold)) 
			delayClk <= 0;
		else
			delayClk <= delayClk + 1;
	end
	
	always_ff @(posedge clk) begin
		if(reset)
			ps <= s0;
		else if(done) 
			ps <= ns;
		else 
			ps <= ps; //this should be automatic
	end
	
	assign x0 = x0past;
	assign y0 = y0past;
	assign x1 = x1past;
	assign y1 = y1past;
	assign white = color;
	
	always_ff @(posedge clk) begin
		if(reset) begin
			x0past <= 160; 
			y0past <= 25; 
			x1past <= 160; 
			y1past <= 75;
			color <= 1;
		end else if(ps == s0) begin
			x0past <= 160; 
			y0past <= 25; 
			x1past <= 160; 
			y1past <= 75;
			color <= 1;
		end else if(ps == rightErase) begin
			color <= color + 1;
		end else if(ps == rightUpdate) begin
			x0past <= x0past + 1;
			color <= color + 1;
		end else if(ps == downErase) begin
			color <= color + 1;
		end else if(ps == downUpdate) begin
			y0past <= y0past + 1;
			color <= color + 1;
		end  else if(ps == leftErase) begin
			color <= color + 1;
		end else if(ps == leftUpdate) begin
			x0past <= x0past - 1;
			color <= color + 1;
		end  else if(ps == upErase) begin
			color <= color + 1;
		end else if(ps == upUpdate) begin
			y0past <= y0past - 1;
			color <= color + 1;
		end
	end

	
endmodule


module drawer_testbench();
	 logic clk, reset, animate, done, white, resetScreen;
	 logic [10:0] x0, y0, x1, y1;

	drawer dut (.clk, .reset, .animate, .done, .white, .x0, .y0, .x1, .y1, .resetScreen); 	
	
	parameter CLOCK_PERIOD=40;
	integer i;
	initial begin
		clk<=0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
		
	end
	
	
	initial begin
	
	reset <= 1;							@(posedge clk);
	reset <= 0;					@(posedge clk);
								@(posedge clk);
	animate <= 1;							@(posedge clk);
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
								for(i = 0; i < 50000; i++) begin
										@(posedge clk);
									end
									$stop;
								end

endmodule
