
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW, CLOCK_50, GPIO_0);

	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;
	input logic CLOCK_50; //50MHz clock
	inout logic [35:0] GPIO_0;
	
	logic a, b, reset, enter_wire, exit_wire;
	logic [4:0] count_wire;
	
	parkingLot parkinglot (.A(a), .B(b), .enter(enter_wire), .exit(exit_wire), .reset, .clk(CLOCK_50));
	
	parkingLotCounter parkinglotcounter (.inc(enter_wire), .dec(exit_wire), .out(count_wire), .reset, .clk(CLOCK_50));

	hexControl hexcontrol (.count(count_wire), .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5);
	
	assign a = ~KEY[3];
	assign b = ~KEY[2];
	assign GPIO_0[18] = a;
	assign GPIO_0[19] = b;
	assign reset = SW[0];
	
endmodule

module DE1_SoC_testbench();

	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;
	logic CLOCK_50;
	DE1_SoC dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW, .CLOCK_50);
	
	parameter CLOCK_PERIOD = 50; //10 ns
	
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
		
	end
	/*
	integer i;
	initial begin
		SW[9] = 1'b0;
		SW[8] = 1'b0;
		for (i=0; i<2**8; i++) begin
			SW[7:0] = i; #10;
		end
	end
	*/
	initial begin
			SW[0] = 1; #100
			SW[0] = 0; #100
			KEY[3] = 1; KEY[2] = 1;  #100;
			KEY[3] = 0; KEY[2] = 1;  #100;
			KEY[3] = 0; KEY[2] = 0;  #100;
			KEY[3] = 1; KEY[2] = 0;  #100;
			KEY[3] = 1; KEY[2] = 1;  #100;
			KEY[3] = 1; KEY[2] = 1;  #100;
			KEY[3] = 0; KEY[2] = 1;  #100;
			KEY[3] = 0; KEY[2] = 0;  #100;
			KEY[3] = 1; KEY[2] = 0;  #100;
			KEY[3] = 1; KEY[2] = 1;  #100;
			KEY[3] = 1; KEY[2] = 1;  #100;
			KEY[3] = 0; KEY[2] = 1;  #100;
			KEY[3] = 0; KEY[2] = 0;  #100;
			KEY[3] = 1; KEY[2] = 0;  #100;
			KEY[3] = 1; KEY[2] = 1;  #100;
			KEY[3] = 1; KEY[2] = 1;  #100;
			KEY[3] = 0; KEY[2] = 1;  #100;
			KEY[3] = 0; KEY[2] = 0;  #100;
			KEY[3] = 1; KEY[2] = 0;  #100;
			KEY[3] = 1; KEY[2] = 1;  #100;
			KEY[3] = 1; KEY[2] = 1;  #100;
			KEY[3] = 0; KEY[2] = 1;  #100;
			KEY[3] = 0; KEY[2] = 0;  #100;
			KEY[3] = 1; KEY[2] = 0;  #100;
			KEY[3] = 1; KEY[2] = 1;  #100;
			KEY[3] = 1; KEY[2] = 1;  #100;
			KEY[3] = 0; KEY[2] = 1;  #100;
			KEY[3] = 0; KEY[2] = 0;  #100;
			KEY[3] = 1; KEY[2] = 0;  #100;
			KEY[3] = 1; KEY[2] = 1;  #100;
			
		$stop;
		
		end 
endmodule

