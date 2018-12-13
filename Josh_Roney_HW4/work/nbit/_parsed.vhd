

--n-bit adder
entity nbit is
	generic(M : integer);
	port(s,t : in bit_vector (M-1 downto 0);
	     cin : in bit;
	     sum : out bit_vector (M downto 0)
	);
end nbit;
