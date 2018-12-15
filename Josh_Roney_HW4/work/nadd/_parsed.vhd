 

--n-bit adder
entity nadd is
	generic(N : integer);
	port(x,y : in bit_vector (N-1 downto 0);
	     z : out bit_vector (N-1 downto 0);
	     cout : out bit
	);
end nadd;
