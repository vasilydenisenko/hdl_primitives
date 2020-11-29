/*
	Counter with load and count direction control
	
	********************************************************************
	
	counter_up_dw_ld
	#(
		.DWIDTH 		(4),
		.DEFAULT_COUNT	(5)
	)
		counter_up_dw_ld_inst
	(
		.clk			(),
		.rst			(),
		
		.cntrl__up_dwn	(),	// i
		.cntrl__load	(),	// i
		.cntrl__ena		(),	// i
		.cntrl__data_in	(),	// i[DWIDTH - 1 : 0]
		
		.count			()	// o[DWIDTH - 1 : 0]
	);
*/

module counter_up_dw_ld
#(
	parameter DWIDTH = 4,
	parameter DEFAULT_COUNT = 5
)
(
	input  logic 					clk,
	input  logic 					rst,
	
	input  logic 					cntrl__up_dwn,
	input  logic 					cntrl__load,
	input  logic 					cntrl__ena,
	input  logic [DWIDTH - 1 : 0] 	cntrl__data_in,
	
	output logic [DWIDTH - 1 : 0] 	count
);


	always_ff @ (posedge clk or posedge rst) begin
		if (rst)
				count <= DEFAULT_COUNT[DWIDTH - 1 : 0];
		else if (cntrl__load)
				count <= cntrl__data_in;
		else if (cntrl__ena) begin
			if (cntrl__up_dwn)
				count <= count + 1'd1;
			else
				count <= count - 1'd1;
		end
		else
				count <= count;			
	end
	
	
endmodule
