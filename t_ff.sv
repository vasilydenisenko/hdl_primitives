/*
	T flip-flop
	
	********************************************************************
	t_ff
	#(
		.POR_VALUE 	(0)
	)
		t_ff_inst
	(
		.clk		(),	
		.toggle		(),
		.out		()
	);
*/



module t_ff
#(
	parameter POR_VALUE = 1
)
(
	input  logic clk,	
	input  logic toggle,
	output logic out
);


	initial begin
		out <= POR_VALUE[0];
	end


	
	
	always_ff @ (posedge clk) begin
		if (toggle)
			out <= !out;
		else
			out <= out;
	end
	
	

endmodule

	
