/*
	Tri-state buffer
	
	********************************************************************
	tri_state_buff
		tri_state_buff_inst
	(
		.io		(),	// io
		
		.rxd	(),	// o
		.txd	(),	// i
		.oe		()	// i
	);
*/

module tri_state_buff
(
	inout  wire io,
	output logic rxd,
	input  logic txd,
	input  logic oe
);
	
	assign io = oe ? txd : 1'bz;
	
	assign rxd = io;
	
endmodule