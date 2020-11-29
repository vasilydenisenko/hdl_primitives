/*
	Demultiplexor	
		
	********************************************************************
	demultiplexor
	#(
		.DWIDTH 	(3),
		.CH_NUM 	(2),
		.IDLE_VALUE ('0)
	)
		demultiplexor_inst
	(
		.in			(),	// i[DWIDTH - 1 : 0]
		.addr		(),	// i[$clog2(CH_NUM) - 1 : 0]
		.out		()	// o[CH_NUM - 1 : 0][DWIDTH - 1 : 0]
	);
*/

module demultiplexor
#(
	parameter DWIDTH 		= 3,
	parameter CH_NUM 		= 2,
	parameter IDLE_VALUE 	= 'z
)
(
	input  logic [DWIDTH - 1 : 0] 					in,
	input  logic [$clog2(CH_NUM) - 1 : 0] 			addr,
	output logic [CH_NUM - 1 : 0][DWIDTH - 1 : 0] 	out
);

	genvar i;
	generate
		for (i = 0; i < CH_NUM; i++) begin: out_gen
			assign out[i] = (addr == i) ? in : IDLE_VALUE;
		end
	endgenerate

	
endmodule
