/*
	Multiplexor

	********************************************************************
	multiplexor
	#(
		.DWIDTH (2),
		.CH_NUM (3)
	)
		multiplexor_inst
	(
		.in		(),	// i[CH_NUM - 1 : 0][DWIDTH - 1 : 0]
		.addr	(),	// i[$clog2(CH_NUM) - 1 : 0]
		.out	()	// o[DWIDTH - 1 : 0]
	);
*/

module multiplexor
#(
	parameter DWIDTH = 2,
	parameter CH_NUM = 3
)
(
	input  logic [CH_NUM - 1 : 0][DWIDTH - 1 : 0] 	in,
	input  logic [$clog2(CH_NUM) - 1 : 0] 			addr,
	output logic [DWIDTH - 1 : 0] 					out
);

	assign out  = in[addr];		
	
endmodule
