// Code from "FPGA prototyping by SystemVerilog examples" by P. Chu

module reg_file
   #(
    parameter DATA_WIDTH = 8, // number of bits
              ADDR_WIDTH = 2  // number of address bits
   )
   (
    input  logic clk,
    input  logic wr_en,
    input  logic [ADDR_WIDTH-1:0] w_addr,
	 input  logic [ADDR_WIDTH:0]r_addr,
    input  logic [(DATA_WIDTH * 2)-1:0] w_data,
    output logic [DATA_WIDTH-1:0] r_data
   );

   // signal declaration
   logic [(DATA_WIDTH * 2)-1:0] array_reg [0:2**ADDR_WIDTH];
	logic [DATA_WIDTH-1:0] outa, outb;
   // body
   // write operation
   always_ff @(posedge clk)
      if (wr_en)
         array_reg[w_addr] <= w_data;
   // read operation
	assign outa = array_reg[r_addr[ADDR_WIDTH:1]][(DATA_WIDTH * 2)-1:DATA_WIDTH];
	assign outb = array_reg[r_addr[ADDR_WIDTH:1]][DATA_WIDTH-1:0];
	
	//mux to choose the left half or right half of the register
	always_comb begin
		if(r_addr[0] == 0)
			r_data = outa;
		else
			r_data = outb;
	end
   //assign r_data = array_reg[r_addr];
endmodule

module reg_file_testbench();

	logic clk, wr_en;
	logic [1:0] w_addr; //1bits
	logic [2:0]r_addr; //3bits
   logic [15:0] w_data; //16 bits
   logic [7:0] r_data; //8bits
	
	reg_file dut (.clk, .wr_en, .w_addr, .r_addr, .w_data, .r_data);
	
	
	parameter CLOCK_PERIOD=100;
	
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
		
	end
	
	// Design inputs. Each line is a clock cycle.
	
	initial begin
									@(posedge clk);
	wr_en <= 1; w_addr <= 2'b00; w_data<= 16'b1111000110001111;								@(posedge clk);
									@(posedge clk);
	r_addr <= 3'b000;								@(posedge clk);
									@(posedge clk);
	r_addr <= 3'b001;								@(posedge clk);
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

