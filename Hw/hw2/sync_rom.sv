
module sync_rom
	(
	input logic clk,
	input logic [7:0] addr,
	output logic [3:0] data
	);
	
	// signal declaration
	logic [3:0] rom [0:255];
	logic [3:0] data_reg;
	
	// load values from a text file
	initial begin
		$readmemh("C:/Users/russe/Desktop/EE371/371hw/hw2/truthtable8.txt", rom);
	end
	


	//assign data_reg = rom[addr];
	always_ff @(posedge clk) 
		data_reg <= rom[addr];
	
	assign data = data_reg;
	
endmodule


module sync_rom_testbench();

	logic clk;
	logic [7:0] addr;
	logic [3:0] data;
	logic [3:0] rom [0:255];
	sync_rom dut (.clk, .addr, .data);
	
	parameter CLOCK_PERIOD=100;
	
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
		
	end
	
	// Design inputs. Each line is a clock cycle.
	
	initial begin
													@(posedge clk);
	$readmemh("C:/Users/russe/Desktop/EE371/371hw/hw2/truthtable8.txt", rom);	@(posedge clk);
	addr <= 7'h0;								@(posedge clk);
	addr <= 7'h1;								@(posedge clk);
	addr <= 7'h2;								@(posedge clk);
	addr <= 7'h3;								@(posedge clk);
	addr <= 7'h4;								@(posedge clk);
	addr <= 7'h5;								@(posedge clk);
	addr <= 7'h6;								@(posedge clk);
	addr <= 7'h7;								@(posedge clk);								
	addr <= 7'h8;								@(posedge clk);
	addr <= 7'h9;								@(posedge clk);
	addr <= 7'hA;								@(posedge clk);
	addr <= 7'hB;								@(posedge clk);								
	addr <= 7'hC;								@(posedge clk);
	addr <= 7'hD;								@(posedge clk);
	addr <= 7'hE;								@(posedge clk);
	addr <= 7'hF;								@(posedge clk);	
	
	$stop;
	end
endmodule