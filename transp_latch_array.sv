/*  
	D latch array
	
	***************************************************************************
	transp_latch_array
	#(
		.DWIDTH	()
	)
		transp_latch_array_inst
	(
		.in		(),	// i[DWIDTH - 1 : 0]
		.ena	(),	// i
		.out	()	// o[DWIDTH - 1 : 0]	
	);		
*/

module transp_latch_array
#(
	parameter DWIDTH = 3
)
(
	input  wire [DWIDTH - 1 : 0] 	in,	// i[DWIDTH - 1 : 0]
	input  wire 					ena,	// i
	output wire [DWIDTH - 1 : 0] 	out		// o[DWIDTH - 1 : 0]
);

	
	generate
		genvar i;
		for (i = 0; i < DWIDTH; i++) begin: latch_arr
			transp_latch
				transp_latch_inst
			(
				.in		(in[i]),	// i
				.ena	(ena),	// i
				.out	(out[i])	// o	
			);
		end
	endgenerate
	
	
endmodule