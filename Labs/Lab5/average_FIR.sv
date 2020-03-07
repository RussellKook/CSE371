
module average_FIR #(parameter N = 8, parameter ADDER_WIDTH = 3) (clk, reset, dataIn, dataOut);

	input logic clk, reset;
	input logic signed [23:0] dataIn;
	output logic signed [23:0] dataOut;
	
	
	logic signed [23:0] divided_dataIn;
	
	assign divided_dataIn = dataIn / N;
	
	logic read, read_temp, full, empty, write;
	
	logic signed [23:0] fifo_out, fifo_out_negative, add1_out, add2_out, accumulator, mux_out, mux_out_temp;
	
	logic [2:0] fifo_size;
	
	logic signed [23:0] dff1out, dff2out, dff3out, dff4out;
	
	logic signed [N:0][23: 0] dff_wire;
	
	assign read = full;
	
	assign write = 1'b1;
	
	//assign fifo_out_negative = (~fifo_out) + 1;
	assign fifo_out_negative = (~dff_wire[N]) + 1;
	
	assign dff_wire[0] = divided_dataIn;
	
	generate
		genvar i;
		for (i = 0; i < N; i = i + 1)
			begin : gen1
			d_ff dffN (.clk, .reset, .d(dff_wire[i]), .q(dff_wire[i + 1]));
			end
	endgenerate
	 
	
//	d_ff dff1 (.clk, .reset, .d(divided_dataIn), .q(dff1out));
//	d_ff dff2 (.clk, .reset, .d(dff1out), .q(dff2out));
//	d_ff dff3 (.clk, .reset, .d(dff2out), .q(dff3out));
//	d_ff dff4 (.clk, .reset, .d(dff3out), .q(dff4out));
	//fifo #(24,ADDER_WIDTH) buffer (.clk(clk), .reset(reset), .rd(read), .wr(write), .w_data(divided_dataIn), .empty(empty), .full(full), .r_data(fifo_out));
	//fifo_altera (.clock(clk), .data(divided_dataIn), .rdreq(read), .wrreq(write), .empty(empty), .full(full), .q(fifo_out), .usedw(fifo_size));
	
	always_ff @(posedge clk) begin
		if (reset) 
			accumulator <= 0;
		else 
			accumulator <= add2_out;
	end
	
	assign dataOut = add2_out;
	// clk, reset, in1, in2, read, out
	FIRadder add1 ( .in1(divided_dataIn), .in2(fifo_out_negative), .read(read), .out(add1_out));
	FIRadder add2 ( .in1(add1_out), .in2(accumulator), .read(1), .out(add2_out));
endmodule


module average_FIR_testbench();
	logic clk, reset;
	logic signed[23:0] dataIn, dataOut;
	
	
	parameter CLOCK_PERIOD=100;
	
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
		
	end
	
	
	average_FIR dut (.clk, .reset, .dataIn, .dataOut);
	
	initial begin
									@(posedge clk);
	reset <= 1;							@(posedge clk);
	//reset <= 0;								@(posedge clk);
	reset <= 0;dataIn <= 8;								@(posedge clk);
	dataIn <= 16;								@(posedge clk);
	dataIn <= 8;								@(posedge clk);
	dataIn <= 16;								@(posedge clk);
	dataIn <= 8;								@(posedge clk);
	dataIn <= 16;								@(posedge clk);
	dataIn <= 8;								@(posedge clk);
	dataIn <= 16;								@(posedge clk);
	dataIn <= 8;								@(posedge clk);
	dataIn <= 16;								@(posedge clk);
	dataIn <= 8;								@(posedge clk);
	dataIn <= 16;								@(posedge clk);
	dataIn <= 8;								@(posedge clk);
	dataIn <= 16;								@(posedge clk);
	dataIn <= 8;								@(posedge clk);
	dataIn <= 16;								@(posedge clk);
	dataIn <= 8;								@(posedge clk);
									@(posedge clk);
									/*@(posedge clk);
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
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									*/
									
	$stop;
	end
endmodule



