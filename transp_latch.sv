/*  
	D latch (transparent latch)
		
	***************************************************************************
	transp_latch
		transp_latch_inst
	(
		.in		(),	// i
		.ena	(),	// i
		.out	()	// o	
	);	
*/

module transp_latch
(
	input  wire in,	// i
	input  wire ena,	// i
	output wire out		// o
);

	
	wire set_nand_1;
	assign set_nand_1 = !(in && ena);
	
	
	wire reset_nand_1;
	assign reset_nand_1 = !(!in && ena);
	
	
	wire set_nand_2;
	assign set_nand_2 = !(set_nand_1 && reset_nand_2);
			
	
	wire reset_nand_2;
	assign reset_nand_2 = !(reset_nand_1 && set_nand_2);
	
	
	assign out = set_nand_2;

	
	
endmodule