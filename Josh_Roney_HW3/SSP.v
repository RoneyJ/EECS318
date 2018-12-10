//SSP module for HW 3
//Josh Roney (jpr87)
'include "Tx_FIFO.v"
'include "Rx_FIFO.v"
'include "transmit.v"
'include "receive.v"
module SSP;
	input pclk, clear_b, psel, pwrite, sspclkin, sspfssin, ssprxd;
	input [7:0] pwdata;
	output sspoe_b, ssptxd, sspclkout, sspfssout, ssptxintr, ssprxintr; 
	output [7:0] prdata;
	
	wire remove;
	wire [7:0] txdata, rxdata;
	
	Tx_FIFO tf(psel, pwrite, clear_b, pclk, remove,	pwdata, ssptxintr, txdata);
	Rx_FIFO rf(psel, pwrite, clear_b, pclk, rxdata, ssprxintr, prdata);
	transmit tr(txdata, clear_b, pclk, sspclkin, sspfssin, ssprxd, sspoe_b, ssptxd, sspfssout, sspclkout, remove);
	receive rc (clear_b, pclk, sspclkin, sspfssin, ssprxd, rxdata, sspoe_b, ssptxd, sspfssout, sspclkout);
	
endmodule
