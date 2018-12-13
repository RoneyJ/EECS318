


--carry save adder entity
entity add is
	generic (N : integer);
	port (w,x,y : in bit_vector (N-1 downto 0);
	      sum,carry : out bit_vector (N downto 0)
	);
end entity;
