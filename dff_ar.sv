/*
	D flip-flop with enable input and asynchronous reset.
		
	********************************************************************
	dff_ar
	#(
		.DWIDTH 	(2),
		.POR_VALUE 	(1)
	)
		dff_ar_inst
	(
		.clk		(),
		.rst		(),
		
		.in			(),	// i[DWIDTH - 1 : 0]
		.ena		(),	// i
		.out		()	// o[DWIDTH - 1 : 0]
	);
*/

module dff_ar
#(
	parameter DWIDTH = 2,
	parameter POR_VALUE = 1
)
(
	input  logic 					clk,
	input  logic 					rst,
	
	input  logic [DWIDTH - 1 : 0] 	in,
	input  logic 					ena,
	output logic [DWIDTH - 1 : 0] 	out
);

	logic [DWIDTH - 1 : 0] register;
	always_ff @ (posedge clk or posedge rst) begin
		if (rst)
			register <= POR_VALUE[DWIDTH - 1 : 0];
		else if (ena)
			register <= in;
		else
			register <= register;
	end

	assign out = register;
	
endmodule
