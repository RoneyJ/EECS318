

--n-bit and entity
--and every bit of n-bit input x with 1-bit input y
entity nbitand is
	generic(N : integer);
	port(x : in bit_vector (N-1 downto 0);
	     y,en : in bit;
	     z : out bit_vector (N-1 downto 0)
	);
end nbitand;
