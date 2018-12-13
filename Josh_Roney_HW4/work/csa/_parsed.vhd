--Carry save adder module for HW 4
--Josh Roney(jpr87)
entity csa is
	port(a,b,c,d,e,f,g,h,i,j : in bit_vector (7 downto 0);	--10 8-bit values to add
	     sum : out bit_vector (16 downto 0)			--sum value
	);
end csa;
