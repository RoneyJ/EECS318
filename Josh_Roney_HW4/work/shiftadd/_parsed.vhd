--n-bit shift add multipler for HW 4
--Josh Roney(jpr87)
entity shiftadd is
	generic(M : integer);
	port(clk,start : in bit;
	     a,b : in bit_vector (M-1 downto 0);
	     p : out bit_vector (M*2-1 downto 0);
	     done : out bit
	);
end shiftadd;
