

--combines 2 n-bit vectors into on 2*n-bit vector
entity ncombine is
	generic(N : integer);
	port(a,b : in bit_vector (N-1 downto 0);
	     en : in bit;
	     c : out bit_vector (N*2-1 downto 0)
	);
end ncombine;
