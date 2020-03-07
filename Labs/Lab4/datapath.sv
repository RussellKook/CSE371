
//datapath for binary search
module datapath(clk, load_A, load_initial_index, dec_index, inc_index, data_from_mem, data_A, found, address_to_mem, val_lower_A, out_of_bounds);
	
	input logic clk, load_A, load_initial_index, dec_index, inc_index;
	input logic [7:0] data_from_mem, data_A;
	output logic found, val_lower_A, out_of_bounds;
	output logic [4:0] address_to_mem;
	
	logic [4:0] index; //index == "mid"
	
	logic [7:0] A;
	
	logic [4:0] min, max;
	
	assign address_to_mem = index;
	
	//outputs of the datapath
	always_ff @(posedge clk) begin
		if(load_A)
			A <= data_A;
		if(load_initial_index) begin 
			index <= 5'b01111; 
			min <= 5'b00000;
			max <= 5'b11111;
		end 
		index <= min + ((max - min) / 2);
		if(A == data_from_mem)
			found <= 1;
		else
			found <= 0;
		if(data_from_mem < A) begin
			val_lower_A <= 1;
		end else begin
			val_lower_A <= 0;
		end
		if(index > 31 || index < 0) 
			out_of_bounds <= 1;
		else 
			out_of_bounds <= 0;
		if(dec_index)
			max <= index;
		if(inc_index)
			min <= index;
		end
endmodule

