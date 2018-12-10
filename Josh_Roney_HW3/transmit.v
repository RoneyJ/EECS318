//transmit logic module for the SSP of HW 3
//Josh Roney (jpr87)
module transmit(
	input [7:0] txdata,
	input clear_b, pclk, sspclkin, sspfssin, ssprxd,
	output sspoe_b, ssptxd, sspfssout, sspclkout,
	output remove		//signal to TxFIFO to shift its reg and output new data
	);
endmodule 