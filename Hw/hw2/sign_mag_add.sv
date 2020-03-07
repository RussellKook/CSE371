// Code from "FPGA prototyping by SystemVerilog examples" by P. Chu
 
module sign_mag_add
   #(parameter N=4)
   (
    input  logic [N-1:0] a, b,
    output logic [N-1:0] sum
   );

   // signal declaration
   logic [N-2:0]  mag_a, mag_b, mag_sum, max, min;
   logic sign_a, sign_b, sign_sum;

   //body
   always_comb
   begin
      // separate magnitude and sign
      mag_a = a[N-2:0];
      mag_b = b[N-2:0];
      sign_a = a[N-1];
      sign_b = b[N-1];
      // sort according to magnitude
      if (mag_a > mag_b)
         begin
            max = mag_a;
            min = mag_b;
            sign_sum = sign_a;
         end
      else
         begin
            max = mag_b;
            min = mag_a;
            sign_sum = sign_b;
         end
      // add/sub magnitude
      if (sign_a==sign_b)
         mag_sum = max + min;
      else
         mag_sum = max - min;
      // form output
      sum = {sign_sum, mag_sum};
   end
endmodule


module sign_mag_add_testbench();
	
		logic [3:0] a,b,sum;

		sign_mag_add dut (a,b,sum);
		integer i;
		initial begin
		
			for(i=0; i<2**8; i++) begin
				{a,b} = i; #10;
			end	
		
		end
		/*
		initial begin		
		
		a = 4'b0000; b = 4'b0100; #10;
		a = 4'b0001; b = 4'b0111; #10;
		a = 4'b0001; b = 4'b1000; #10;
		a = 4'b0001; b = 4'b1001; #10;
		a = 4'b0011; b = 4'b1111; #10;
		a = 4'b1000; b = 4'b0000; #10;
		a = 4'b1000; b = 4'b0110; #10;
		a = 4'b1000; b = 4'b1000; #10;
		a = 4'b1001; b = 4'b0011; #10;
		a = 4'b1110; b = 4'b0010; #10;
		a = 4'b1110; b = 4'b0110; #10;
		a = 4'b1110; b = 4'b1111; #10;
			
		$stop;
		
		end 
		*/
endmodule
