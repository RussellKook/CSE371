

module FIR_high_level (clk, reset, dataIn, dataOut);

	input logic clk, reset;
	input logic [23:0] dataIn;
	output logic [23:0] dataOut;
	
	logic [23:0] raw0, raw1, raw2, raw3, raw4, raw5, raw6, raw7;
	logic [23:0] d_raw0, d_raw1, d_raw2, d_raw3, d_raw4, d_raw5, d_raw6, d_raw7;
	logic [23:0] sum1, sum2, sum3, sum4, sum5, sum6, sum7;
	
	assign raw0 = dataIn;
	assign d_raw0 = dataIn / 8;
	assign dataOut = sum7;
	
	FIR fir1 (.clk, .reset, .D(raw0), .Q(raw1), .Q_8(d_raw1)); 
	FIR fir2 (.clk, .reset, .D(raw1), .Q(raw2), .Q_8(d_raw2)); 
	FIR fir3 (.clk, .reset, .D(raw2), .Q(raw3), .Q_8(d_raw3)); 
	FIR fir4 (.clk, .reset, .D(raw3), .Q(raw4), .Q_8(d_raw4)); 
	FIR fir5 (.clk, .reset, .D(raw4), .Q(raw5), .Q_8(d_raw5)); 
	FIR fir6 (.clk, .reset, .D(raw5), .Q(raw6), .Q_8(d_raw6)); 
	FIR fir7 (.clk, .reset, .D(raw6), .Q(raw7), .Q_8(d_raw7)); 
	
	FIRadder add1 (.in1(d_raw0), .in2(d_raw1), .out(sum1));
	FIRadder add2 (.in1(sum1), .in2(d_raw2), .out(sum2));
	FIRadder add3 (.in1(sum2), .in2(d_raw3), .out(sum3));
	FIRadder add4 (.in1(sum3), .in2(d_raw4), .out(sum4));
	FIRadder add5 (.in1(sum4), .in2(d_raw5), .out(sum5));
	FIRadder add6 (.in1(sum5), .in2(d_raw6), .out(sum6));
	FIRadder add7 (.in1(sum6), .in2(d_raw7), .out(sum7));
	
endmodule


