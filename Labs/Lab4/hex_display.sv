
//hexdisplay, requires an enable found and outputs hexadecimal
module hex_display(num, HEX, found);
	input logic [3:0] num;
	input logic found;
	output logic [6:0] HEX;
	
	
	always_comb
		begin
				case(num)
					4'h0: begin
									if (found) HEX = 7'b1000000;
									else HEX = 7'b1111111;
								end
					4'h1: begin
									if (found) HEX = 7'b1111001;
									else HEX = 7'b1111111;
								end
					4'h2: begin
									if (found) HEX = 7'b0100100;
									else HEX = 7'b1111111;
								end
					4'h3: begin
									if (found) HEX = 7'b0110000;
									else HEX = 7'b1111111;
								end
					4'h4: begin
									if (found) HEX = 7'b0011001;
									else HEX = 7'b1111111;
								end
					4'h5: begin
									if (found) HEX = 7'b0010010;
									else HEX = 7'b1111111;
								end
					4'h6: begin
									if (found) HEX = 7'b0000010;
									else HEX = 7'b1111111;
								end
					4'h7: begin
									if (found) HEX = 7'b1111000;
									else HEX = 7'b1111111;
								end
					4'h8: begin
									if (found) HEX = 7'b0000000;
									else HEX = 7'b1111111;
								end
					4'h9: begin
									if (found) HEX = 7'b0011000;
									else HEX = 7'b1111111;
								end
					4'hA: begin
									if (found) HEX = 7'b0001000;
									else HEX = 7'b1111111;
								end
					4'hB: begin
									if (found) HEX = 7'b0000011;
									else HEX = 7'b1111111;
								end
					4'hC: begin
									if (found) HEX = 7'b0100111;
									else HEX = 7'b1111111;
								end
					4'hD: begin
									if (found) HEX = 7'b0100001;
									else HEX = 7'b1111111;
								end
					4'hE: begin
									if (found) HEX = 7'b0000110;
									else HEX = 7'b1111111;
								end
					4'hF: begin
									if (found) HEX = 7'b0001110;
									else HEX = 7'b1111111;
								end
			endcase
		end
		
endmodule

module hex_display_testbench();
	logic [3:0] num;
	logic [6:0] HEX;
	logic found;
	
	hex_display dut (num, HEX, found);
	
	initial begin
		num = 4'b0000; #10;
							#10;
		num = 4'b0001; #10;
							#10;
		num = 4'b0010; #10;
							#10;
		num = 4'b0011; #10;
							#10;
		num = 4'b0100; #10;
							#10;
		num = 4'b0101; #10;
							#10;
		num = 4'b0110; #10;
							#10;
		num = 4'b0111; #10;
							#10;
		num = 4'b1000; #10;
							#10;
		num = 4'b1001; #10;
							#10;
		num = 4'b1010; #10;
							#10;
		num = 4'b1011; #10;
							#10;
		num = 4'b1100; #10;
							#10;
		num = 4'b1101; #10;
							#10;
		num = 4'b1110; #10;
							#10;
		num = 4'b1111; #10;
							#10;
		
		$stop;
	end
endmodule