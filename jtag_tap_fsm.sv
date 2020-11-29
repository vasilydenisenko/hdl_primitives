/*
	JTAG TAP-controller's FSM
		
	********************************************************************
	jtag_tap_fsm
		jtag_tap_fsm_inst
	(
		.TRST		(),	// i
		.TCK		(),	// i
		.TMS		(),	// i
		
		.state_TLR	(),	// o
		.state_RTI	(),	// o
		.state_SDRS	(),	// o
		.state_SIRS	(),	// o
		.state_CDR	(),	// o
		.state_CIR	(),	// o
		.state_SDR	(),	// o
		.state_SIR	(),	// o
		.state_E1DR	(),	// o
		.state_E1IR	(),	// o
		.state_PDR	(),	// o
		.state_PIR	(),	// o
		.state_E2DR	(),	// o
		.state_E2IR	(),	// o
		.state_UDR	(),	// o
		.state_UIR	()	// o
	);
*/


//`define ONE_HOT_ENCODING

module jtag_tap_fsm
(
	input  logic TRST,
	input  logic TCK,
	input  logic TMS,
	
	output logic state_TLR,
	output logic state_RTI,
	output logic state_SDRS,
	output logic state_SIRS,
	output logic state_CDR,
	output logic state_CIR,
	output logic state_SDR,
	output logic state_SIR,
	output logic state_E1DR,
	output logic state_E1IR,
	output logic state_PDR,
	output logic state_PIR,
	output logic state_E2DR,
	output logic state_E2IR,
	output logic state_UDR,
	output logic state_UIR
);
	
// State Register
`ifdef ONE_HOT_ENCODING
	enum logic [15 : 0] {
		TLR = 	16'b0000_0000_0000_0001,
		RTI = 	16'b0000_0000_0000_0010,
		SDRS = 	16'b0000_0000_0000_0100,
		SIRS = 	16'b0000_0000_0000_1000,
		CDR = 	16'b0000_0000_0001_0000,
		CIR = 	16'b0000_0000_0010_0000,
		SDR = 	16'b0000_0000_0100_0000,
		SIR = 	16'b0000_0000_1000_0000,
		E1DR = 	16'b0000_0001_0000_0000,
		E1IR = 	16'b0000_0010_0000_0000,
		PDR = 	16'b0000_0100_0000_0000,
		PIR = 	16'b0000_1000_0000_0000,
		E2DR = 	16'b0001_0000_0000_0000,
		E2IR = 	16'b0010_0000_0000_0000,
		UDR = 	16'b0100_0000_0000_0000,
		UIR = 	16'b1000_0000_0000_0000
	} cstate, nstate;

	
	dff_ar
	#(
		.DWIDTH 	(16),
		.POR_VALUE 	(TLR)
	)
		state_register_inst
	(
		.clk		(TCK),
		.rst		(TRST),
		
		.in			(nstate),	// i[DWIDTH - 1 : 0]
		.ena		(1'b1),	// i
		.out		(cstate)	// o[DWIDTH - 1 : 0]
	);
`else
	enum logic [3 : 0] {
		TLR = 4'd0,
		RTI = 4'd1,
		SDRS = 4'd2,
		SIRS = 4'd3,
		CDR = 4'd4,
		CIR = 4'd5,
		SDR = 4'd6,
		SIR = 4'd7,
		E1DR = 4'd8,
		E1IR = 4'd9,
		PDR = 4'd10,
		PIR = 4'd11,
		E2DR = 4'd12,
		E2IR = 4'd13,
		UDR = 4'd14,
		UIR = 4'd15
	} cstate, nstate;

	
	dff_ar
	#(
		.DWIDTH 	(4),
		.POR_VALUE 	(TLR)
	)
		state_register_inst
	(
		.clk		(TCK),
		.rst		(TRST),
		
		.in			(nstate),	// i[DWIDTH - 1 : 0]
		.ena		(1'b1),	// i
		.out		(cstate)	// o[DWIDTH - 1 : 0]
	);
`endif
// !State Register




// Next State Logic
	always_comb begin
		case (cstate)
			TLR:		nstate = TMS ? TLR : RTI;
			RTI:		nstate = TMS ? SDRS : RTI;
			SDRS:		nstate = TMS ? SIRS : CDR;
			SIRS:		nstate = TMS ? TLR : CIR;
			CDR:		nstate = TMS ? E1DR : SDR;
			CIR:		nstate = TMS ? E1IR : SIR;
			SDR:		nstate = TMS ? E1DR : SDR;
			SIR:		nstate = TMS ? E1IR : SIR;
			E1DR:		nstate = TMS ? UDR : PDR;
			E1IR:		nstate = TMS ? UIR : PIR;
			PDR:		nstate = TMS ? E2DR : PDR;
			PIR:		nstate = TMS ? E2IR : PIR;
			E2DR:		nstate = TMS ? UDR : SDR;
			E2IR:		nstate = TMS ? UIR : SIR;
			UDR:		nstate = TMS ? SDRS : RTI;
			UIR:		nstate = TMS ? SDRS : RTI;
			default:	nstate = TLR;
		endcase
	end
// !Next State Logic	




// Output Logic
`ifdef ONE_HOT_ENCODING
	assign state_TLR = cstate[0];
	assign state_RTI = cstate[1];
	assign state_SDRS = cstate[2];
	assign state_SIRS = cstate[3];
	assign state_CDR = cstate[4];
	assign state_CIR = cstate[5];
	assign state_SDR = cstate[6];
	assign state_SIR = cstate[7];
	assign state_E1DR = cstate[8];
	assign state_E1IR = cstate[9];
	assign state_PDR = cstate[10];
	assign state_PIR = cstate[11];
	assign state_E2DR = cstate[12];
	assign state_E2IR = cstate[13];
	assign state_UDR = cstate[14];
	assign state_UIR = cstate[15];
`else
	assign state_TLR = (cstate == TLR);
	assign state_RTI = (cstate == RTI);
	assign state_SDRS = (cstate == SDRS);
	assign state_SIRS = (cstate == SIRS);
	assign state_CDR = (cstate == CDR);
	assign state_CIR = (cstate == CIR);
	assign state_SDR = (cstate == SDR);
	assign state_SIR = (cstate == SIR);
	assign state_E1DR = (cstate == E1DR);
	assign state_E1IR = (cstate == E1IR);
	assign state_PDR = (cstate == PDR);
	assign state_PIR = (cstate == PIR);
	assign state_E2DR = (cstate == E2DR);
	assign state_E2IR = (cstate == E2IR);
	assign state_UDR = (cstate == UDR);
	assign state_UIR = (cstate == UIR);
`endif
// !Output Logic


endmodule

	
	
	
	