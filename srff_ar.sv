/*
	SR flip-flop
	
	********************************************************************
	srff_ar
	#(
		.POR_VALUE  (0)
	)
		srff_ar_inst
	(
		.clk		(),
		.rst		(),
		
		.s			(),	// i
		.r			(),	// i
		
		.out		()	// o
	);
*/

module srff_ar
#(
	parameter POR_VALUE = 1
)
(
	input  logic clk,
	input  logic rst,
	
	input  logic s,
	input  logic r,	
	
	output logic out
);

	logic register;
	always_ff @ (posedge clk or posedge rst) begin
		if (rst)
			register <= POR_VALUE[0];
		else if (r)
			register <= 1'd0;
		else if (s)
			register <= 1'd1;		
		else
			register <= register;
	end

	assign out = register;
	
endmodule
