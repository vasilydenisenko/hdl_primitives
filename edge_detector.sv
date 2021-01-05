/*
	Signal edge detector
		
	********************************************************************
	edge_detector
		edge_detector_inst
	(
		.clk	(),
		.rst	(),
		
		.in		(), // i
		.rise	(), // o
		.fall	() // o
	);

*/


module edge_detector
(
	input  logic clk,
	input  logic rst,
	
	input  logic in,
	output logic rise,
	output logic fall
);

	logic in_reg;
	dff_ar
	#(
		.DWIDTH 	(1),
		.POR_VALUE 	(0)
	)
		in_reg_inst
	(
		.clk		(clk),
		.rst		(rst),				
		.in			(in),	// i[DWIDTH - 1 : 0]
		.ena		(1'b1),	// i
		.out		(in_reg)	// o[DWIDTH - 1 : 0]
	);
	
	assign rise =  in && !in_reg;
	assign fall = !in &&  in_reg;


endmodule