
module line_drawer(
	input logic color, clk, reset,
	input logic [10:0]	x0, y0, x1, y1, //the end points of the line
	output logic [10:0]	x, y, //outputs corresponding to the pair (x, y)
	output logic done);
	
	/*
	 * You'll need to create some registers to keep track of things
	 * such as error and direction
	 * Example: */
	logic signed [11:0] error; // 2's complement
	logic [10:0] tempx0, tempy0, tempx1, tempy1, X0, Y0, X1, Y1, deltax, deltay, yStart, oldx0, oldy0, oldx1, oldy1;
	logic yStep, isSteep, oldColor;
	logic [9:0] counter; 
	
	
	enum {idle, draw} ps, ns;
	
	always_ff @(posedge clk or posedge reset) begin
		if(reset) begin
			oldx0 <= 0;
			oldy0 <= 0;
			oldx1 <= 0;
			oldy1 <= 0;
		end else if(ps == idle && ns == draw) begin
			oldx0 <= x0;
			oldy0 <= y0;
			oldx1 <= x1;
			oldy1 <= y1;
			oldColor <= color;
		end
	end
	
	always_comb begin
		case(ps)
		idle: if(oldx0 != x0 || oldy0 != y0 || oldx1 != x1 || oldy1 != y1 || oldColor != color)  ns = draw;
		else ns = idle;
		draw: if(counter > 10'b0000000101 && X0 > X1) ns = idle;
		else ns = draw;
		endcase
	end

	
	always_ff @(posedge clk or posedge reset) begin
		if(reset) begin
			ps <= idle;
		end else
			ps <= ns;
	end
	
	always_ff @(posedge clk or posedge reset) begin
		if(reset)
			done <= 1;
		else if(ps == draw && ns == idle) 
			done <= 1;
		else if(ps == idle && ns == draw)
			done <= 0;
		else
			done <= 0;
	end
	
	always_ff @(posedge clk) begin
		if((ps == idle && ns == idle) || (ps == idle && ns == draw))
			counter <= '0;
		else
			counter <= counter + 1'b1;
		//logic to get absolute value
		if(counter == 1) begin	
			if(oldy1 > oldy0) begin
				tempy0 <= oldy0;
				tempy1 <= oldy1;
			end else begin
				tempy0 <= oldy1;
				tempy1 <= oldy0;
			end
		
			if(oldx1 > oldx0) begin
				tempx0 <= oldx0;
				tempx1 <= oldx1;
			end else begin
				tempx0 <= oldx1;
				tempx1 <= oldx0;
			end
		end else if(counter == 2) begin //swaping for absolute value
			if((tempy1 - tempy0) > (tempx1 - tempx0)) begin
				isSteep <= 1;
				X0 <= oldy0;
				Y0 <= oldx0;
				X1 <= oldy1;
				Y1 <= oldx1;
			end else begin
				isSteep <= 0;
				X0 <= oldx0;
				Y0 <= oldy0;
				X1 <= oldx1;
				Y1 <= oldy1;
			end
		end else	if(counter == 3) begin //swapping for x0 >x1 to ensure drawing from left to right
			if(X0 > X1) begin
				X0 <= X1;
				X1 <= X0;
				Y0 <= Y1;
				Y1 <= Y0;
			end
		end else if(counter == 4 || counter == 5) begin //initialize variables //counter -- 4 or 5
			deltax <= X1 - X0;
			deltay <= Y1 - Y0;
			error <= -(deltax >>> 1) + deltay;
			yStart <= Y0;
			if(Y0 < Y1) 
				yStep <= 1;
			else 
				yStep <= 0;
		end else if(counter > 10'b0000000101 && X0 <= X1) begin //drawing the actual line
			if(isSteep) begin
				y <= X0;
				x <= yStart;
			end else begin
				y <= yStart;
				x <= X0;
			end			
			if(error >= 0) begin
				if(yStep) 
					yStart <= yStart + 1;
				else 
					yStart <= yStart - 1;
				error <= error + deltay - deltax;
			end else begin
				error <= error + deltay;
			end
			X0 <= X0 + 1;
		end
	end

	
endmodule

module line_drawer_testbench();
	logic color, clk, reset, done;
	logic [10:0]	x0, y0, x1, y1; //the end points of the line
	logic [10:0]	x, y;
	 
	line_drawer dut (.color, .clk, .reset, .x0, .y0, .x1, .y1, .x, .y, .done);
	
	parameter CLOCK_PERIOD=100;
	
	initial begin
		clk<=0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
		
	end
	
	
	initial begin
								@(posedge clk);
	reset <= 1;							@(posedge clk);
								@(posedge clk);
											@(posedge clk);
													@(posedge clk);
													@(posedge clk);
													@(posedge clk);
													@(posedge clk);
										@(posedge clk);
		reset <= 0;		x0 <= 0; y0 <= 0; x1 <= 10; y1 <= 0; color<=1;		@(posedge clk); //(0,0),(10,0)
		//reset <= 0;		x0 <= 0; y0 <= 0; x1 <= 0; y1 <= 10;		@(posedge clk); //(0,0),(0,10)
		//reset <= 0;		x0 <= 10; y0 <= 0; x1 <= 0; y1 <= 0;		@(posedge clk); //(10,0),(0,0)
		//reset <= 0;		x0 <= 0; y0 <= 10; x1 <= 0; y1 <= 0;		@(posedge clk); //(0,10),(0,0)
		
		//reset <= 0;		x0 <= 0; y0 <= 0; x1 <= 10; y1 <= 10;		@(posedge clk); //(0,0),(10,10)
		//reset <= 0;		x0 <= 10; y0 <= 10; x1 <= 0; y1 <= 0;		@(posedge clk); //(10,10),(0,0)
		//reset <= 0;		x0 <= 0; y0 <= 0; x1 <= 10; y1 <= 20;		@(posedge clk); //(0,0),(10,20)
		//reset <= 0;		x0 <= 10; y0 <= 20; x1 <= 0; y1 <= 0;		@(posedge clk); //(10,20),(0,0)
		
		//reset <= 0;		x0 <= 0; y0 <= 0; x1 <= 10; y1 <= 0;		@(posedge clk); //(0,0),(10,0)
		//x0 <= 0; y0 <= 10; x1 <= 0; y1 <= 0;		@(posedge clk); //(0,10),(0,0)
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
			//start <= 1;						@(posedge clk);
		//start <= 0;						@(posedge clk);
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
								@(posedge clk);
								@(posedge clk);
								@(posedge clk);
			color <= 0;					@(posedge clk);
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

