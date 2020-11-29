/*	
	JK flip-flop with asynchronous reset.
		
	********************************************************************
	jkff_ar
	#(
		.POR_VALUE 	(0)
	)
		jkff_ar_inst
	(
		.clk		(),	
		.rst		(),
		.j			(),
		.k			(),
		.out		()
	);
*/



module jkff_ar
#(
	parameter POR_VALUE = 1
)
(
	input  logic clk,
	input  logic rst,
	input  logic j,
	input  logic k,
	output logic out
);
	
	
	always_ff @ (posedge clk or posedge rst) begin
		if (rst)
			out <= POR_VALUE[0];
		else if (j && k)
			out <= !out;
		else if (j && !k)
			out <= 1'b1;
		else if (!j && k)
			out <= 1'b0;
		else 			
			out <= out;
	end	

endmodule

	
