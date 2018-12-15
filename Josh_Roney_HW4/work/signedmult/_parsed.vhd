entity signedmult is
	port(mcand,mplier : in bit_vector (4 downto 0);
	     product : out bit_vector (9 downto 0)
	);
end signedmult;
