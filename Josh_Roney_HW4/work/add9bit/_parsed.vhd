

--9-bit adder
entity add9bit is
	port(x,y : in bit_vector (8 downto 0);
	     z : out bit_vector (8 downto 0)
	);
end add9bit;
