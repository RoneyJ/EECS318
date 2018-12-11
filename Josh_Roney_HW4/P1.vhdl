--4x4 unsigned parallel multipler for HW 4
--Josh Roney(jpr87)

entity mult4x4 is
	port( x : in bit_vector (3 downto 0);	--multiplicand
	      y : in bit_vector (3 downto 0);	--multiplier
	      p : out bit_vector (7 downto 0));
end mult4x4;

architecture multiplier of mult4x4 is
	component fa
	port(a,b,cin : in bit;
	     cout,s : out bit);
	end component;
	
	signal andgate : bit_vector (15 downto 0);
	signal sum : bit_vector (11 downto 0);
	signal carry : bit_vector (11 downto 0);

	begin
	andgate(0) <= x(0) and y(0);
	andgate(1) <= x(0) and y(1);
	andgate(2) <= x(0) and y(2);
	andgate(3) <= x(0) and y(3);
	
	andgate(4) <= x(1) and y(0);
	andgate(5) <= x(1) and y(1);
	andgate(6) <= x(1) and y(2);
	andgate(7) <= x(1) and y(3);

	andgate(8) <= x(2) and y(0);
	andgate(9) <= x(2) and y(1);
	andgate(10) <= x(2) and y(2);
	andgate(11) <= x(2) and y(3);

	andgate(12) <= x(3) and y(0);
	andgate(13) <= x(3) and y(1);
	andgate(14) <= x(3) and y(2);
	andgate(15) <= x(3) and y(3);

	fa0 : fa port map(a => andgate(1),b => andgate(4),cin => '0',cout => carry(0),s => sum(0));
	fa1 : fa port map(a => andgate(2),b => andgate(5),cin => '0',cout => carry(1),s => sum(1));
	fa2 : fa port map(a => andgate(3),b => andgate(6),cin => '0',cout => carry(2),s => sum(2));

	fa3 : fa port map(a => andgate(8),b => sum(1),cin => carry(0),cout => carry(3),s => sum(3));
	fa4 : fa port map(a => andgate(9),b => sum(2),cin => carry(1),cout => carry(4),s => sum(4));
	fa5 : fa port map(a => andgate(10),b => andgate(7),cin => carry(2),cout => carry(5),s => sum(5));

	fa6 : fa port map(a => andgate(12),b => sum(4),cin => carry(3),cout => carry(6),s => sum(6));
	fa7 : fa port map(a => andgate(13),b => sum(5),cin => carry(4),cout => carry(7),s => sum(7));
	fa8 : fa port map(a => andgate(14),b => andgate(11),cin => carry(5),cout => carry(8),s => sum(8));

	fa9 : fa port map(a => sum(7),b => carry(6),cin => '0',cout => carry(9),s => sum(9));
	fa10 : fa port map(a => sum(8),b => carry(7),cin => carry(9),cout => carry(10),s => sum(10));
	fa11 : fa port map(a => andgate(15),b => carry(8),cin => carry(10),cout => carry(11),s => sum(11));

	p(0) <= andgate(0);
	p(1) <= sum(0);
	p(2) <= sum(3);
	p(3) <= sum(6);
	p(4) <= sum(9);
	p(5) <= sum(10);
	p(6) <= sum(11);
	p(7) <= carry(11);
end multiplier;

--testbench for multiplier
entity testP1 is
end testP1;

architecture test of testP1 is
	signal m,n : bit_vector (3 downto 0);
	signal product : bit_vector (7 downto 0); 

	component mult4x4 is
		port (x : in bit_vector (3 downto 0);
		      y : in bit_vector (3 downto 0);
		      p : out bit_vector (7 downto 0));
	end component mult4x4;

	begin
	mult : mult4x4 port map(x => m, y => n, p => product);

	process is
	begin
	m <= "0010";
	n <= "0100";
	wait for 10 fs;
	m <= "1111";
	n <= "0011";
	wait for 10 fs;
	report "simulation finished successfully"
	severity FAILURE;
	end process;

end test; 


--full adder for use of multiplier
entity fa is
	port(a,b,cin : in bit;
	     cout,s : out bit);
end entity;

architecture structural of fa is
begin
	cout <= (a and b) or (a and cin) or (b and cin);
	s <= a xor b xor cin;
end structural;
