//SSP module for HW 3
//Josh Roney (jpr87)
`include "TxFIFO.v"
`include "RxFIFO.v"
`include "transmit.v"
`include "receive.v"
module SSP(
	input PCLK, CLEAR_B, PSEL, PWRITE, SSPCLKIN, SSPFSSIN, SSPRXD,
	input [7:0] PWDATA,
	output [7:0] PRDATA,
	output SSPCLKOUT, SSPFSSOUT, SSPTXD, SSPOE_B, SSPTXINTR, SSPRXINTR
	);
	
	wire remove,tmit,rcv;
	wire [7:0] txdata, rxdata;
	
	TxFIFO tf (PSEL, PWRITE, CLEAR_B, PCLK, remove, PWDATA, SSPTXINTR, tmit, txdata);
	transmit tr(txdata, CLEAR_B, PCLK, tmit, SSPOE_B, SSPTXD, SSPFSSOUT, SSPCLKOUT, remove);
	receive rc(CLEAR_B, PCLK, SSPCLKIN, SSPFSSIN, SSPRXD, rxdata, rcv);
	RxFIFO rf (PSEL, PWRITE, CLEAR_B, PCLK, rcv, rxdata, SSPRXINTR, PRDATA);

endmodule
