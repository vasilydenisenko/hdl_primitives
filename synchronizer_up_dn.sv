/*
	Synchroniser
	
	If async_in pulse is shorter than clk period then set UnD = 0,
	otherwise set UnD = 1
		
	********************************************************************
	synchronizer_up_dn
	#(
		.UnD 		(1)	
	)
		synchronizer_up_dn_inst
	(
		.clk		(),
		.rst		(),
		
		.async_in	(),
		.sync_out	()
	);
*/


module synchronizer_up_dn
#(
	parameter UnD = 0
)
(
	input  logic clk,
	input  logic rst,
	
	input  logic async_in,
	output logic sync_out
);

	generate
		if (UnD) begin: synchronizer_up
			logic demet_in;
			
			dff_ar
			#(
				.DWIDTH 	(1),
				.POR_VALUE 	(0)
			)
				demet_reg_inst
			(
				.clk		(clk),
				.rst		(rst),
				
				.in			(async_in),	// i[DWIDTH - 1 : 0]
				.ena		(1'b1),	// i
				.out		(demet_in)	// o[DWIDTH - 1 : 0]
			);
			
				
				
				
			dff_ar
			#(
				.DWIDTH 	(1),
				.POR_VALUE 	(0)
			)
				sync_reg_inst
			(
				.clk		(clk),
				.rst		(rst),
				
				.in			(demet_in),	// i[DWIDTH - 1 : 0]
				.ena		(1'b1),	// i
				.out		(sync_out)	// o[DWIDTH - 1 : 0]
			);
		end: synchronizer_up
		else begin: synchronizer_down
			logic q1;
			
			dff_ar
			#(
				.DWIDTH 	(1),
				.POR_VALUE 	(1'b0)
			)
				stage_1_reg_inst
			(
				.clk		(async_in),
				.rst		(!async_in && sync_out),
				
				.in			(1'b1),	// i[DWIDTH - 1 : 0]
				.ena		(1'b1),	// i
				.out		(q1)	// o[DWIDTH - 1 : 0]
			);

			
			
			
			
			logic q2;
			
			dff_ar
			#(
				.DWIDTH 	(1),
				.POR_VALUE 	(0)
			)
				stage_2_reg_inst
			(
				.clk		(clk),
				.rst		(rst),
				
				.in			(q1),	// i[DWIDTH - 1 : 0]
				.ena		(1'b1),	// i
				.out		(q2)	// o[DWIDTH - 1 : 0]
			);
			
				
				
				
			dff_ar
			#(
				.DWIDTH 	(1),
				.POR_VALUE 	(0)
			)
				stage_3_reg_inst
			(
				.clk		(clk),
				.rst		(rst),
				
				.in			(q2),	// i[DWIDTH - 1 : 0]
				.ena		(1'b1),	// i
				.out		(sync_out)	// o[DWIDTH - 1 : 0]
			);
		end: synchronizer_down
	endgenerate

endmodule