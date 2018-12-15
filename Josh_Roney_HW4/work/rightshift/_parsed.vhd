

--n-bit right shift
--shifts an n-bit register right one bit
--shifts in a '0' bit
entity rightshift is
	generic(N : integer);
	port(d : in bit_vector (N-1 downto 0);
	     cin,en : in bit;
	     q : out bit_vector (N-1 downto 0)
	);
end rightshift;
