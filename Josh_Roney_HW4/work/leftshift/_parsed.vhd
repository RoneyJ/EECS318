

--n-bit left shift
--shifts an n-bit register left one bit
--shifts in a '0' bit
entity leftshift is
	generic(M : integer);
	port(d : in bit_vector (M-1 downto 0);
	     en : in bit;
	     q : out bit_vector (M-1 downto 0)
	);
end leftshift;
