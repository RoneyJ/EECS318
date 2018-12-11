--4x4 unsigned parallel multipler for HW 4
--Josh Roney(jpr87)

entity mult4x4 is
	port( x : in bit_vector (3 downto 0);	--multiplicand
	      y : in bit_vector (3 downto 0);	--multiplier
	      p : out bit_vector (7 downto 0));
end mult4x4;
