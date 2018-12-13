--Carry save adder module for HW 4
--Josh Roney(jpr87)
entity csa is
	port(a,b,c,d,e,f,g,h,i,j : in bit_vector (7 downto 0);	--10 8-bit values to add
	     sum : out bit_vector (16 downto 0)			--sum value
	);
end csa;

architecture carrysave of csa is
	component add is
	generic(N : integer);
	port(w,x,y : in bit_vector (N-1 downto 0);
	     sum,carry : out bit_vector (N downto 0)
	);
	end component;

	signal s1,c1 : bit_vector (8 downto 0);
	signal s2,c2 : bit_vector (9 downto 0);
	signal s3,c3 : bit_vector (10 downto 0);
	signal s4,c4 : bit_vector (11 downto 0);
	signal s5,c5 : bit_vector (12 downto 0);
	signal s6,c6 : bit_vector (13 downto 0);
	signal s7,c7 : bit_vector (14 downto 0);
	signal s8,c8 : bit_vector (15 downto 0);

	signal i1 : bit_vector (8 downto 0);
	signal i2 : bit_vector (9 downto 0);
	signal i3 : bit_vector (10 downto 0);
	signal i4 : bit_vector (11 downto 0);
	signal i5 : bit_vector (12 downto 0);
	signal i6 : bit_vector (13 downto 0);
	signal i7 : bit_vector (14 downto 0);

	signal carry : bit_vector (15 downto 0);

	begin
	i1 <= '0' & d;	
	i2 <= "00" & e;	
	i3 <= "000" & f;	
	i4 <= "0000" & g;	
	i5 <= "00000" & h;	
	i6 <= "000000" & i;	
	i7 <= "0000000" & j;
	add1 : add 
	generic map(N => 8)
	port map(w => a, x => b, y => c, sum => s1, carry => c1);

	add2 : add 
	generic map(N => 9)
	port map(w => s1, x => c1, y => i1, sum => s2, carry => c2);

	add3 : add 
	generic map(N => 10)
	port map(w => s2, x => c2, y => i2, sum => s3, carry => c3);

	add4 : add 
	generic map(N => 11)
	port map(w => s3, x => c3, y => i3, sum => s4, carry => c4);

	add5 : add 
	generic map(N => 12)
	port map(w => s4, x => c4, y => i4, sum => s5, carry => c5);

	add6 : add 
	generic map(N => 13)
	port map(w => s5, x => c5, y => i5, sum => s6, carry => c6);

	add7 : add 
	generic map(N => 14)
	port map(w => s6, x => c6, y => i6, sum => s7, carry => c7);

	add8 : add 
	generic map(N => 15)
	port map(w => s7, x => c7, y => i7, sum => s8, carry => c8);

	sum(0) <= s8(0) xor c8(0) xor '0';
	sum(1) <= s8(1) xor c8(1) xor carry(0);
	sum(2) <= s8(2) xor c8(2) xor carry(1);
	sum(3) <= s8(3) xor c8(3) xor carry(2);
	sum(4) <= s8(4) xor c8(4) xor carry(3);
	sum(5) <= s8(5) xor c8(5) xor carry(4);
	sum(6) <= s8(6) xor c8(6) xor carry(5);
	sum(7) <= s8(7) xor c8(7) xor carry(6);
	sum(8) <= s8(8) xor c8(8) xor carry(7);
	sum(9) <= s8(9) xor c8(9) xor carry(8);
	sum(10) <= s8(10) xor c8(10) xor carry(9);
	sum(11) <= s8(11) xor c8(11) xor carry(10);
	sum(12) <= s8(12) xor c8(12) xor carry(11);
	sum(13) <= s8(13) xor c8(13) xor carry(12);
	sum(14) <= s8(14) xor c8(14) xor carry(13);
	sum(15) <= s8(15) xor c8(15) xor carry(14);
	sum(16) <= carry(15);
end carrysave;

--test for CSA
entity testp4 is
end testp4;
architecture test of testp4 is
	signal a1,b1,c1,d1,e1,f1,g1,h1,i1,j1 : bit_vector (7 downto 0);
	signal z : bit_vector (16 downto 0); 

	component csa is
		port(a,b,c,d,e,f,g,h,i,j : in bit_vector (7 downto 0);	--10 8-bit values to add
	    	     sum : out bit_vector (16 downto 0)			--sum value
		);
	end component csa;

	begin
	csa1 : csa 
	port map(a => a1, b => b1, c => c1, d => d1, e => e1, f => f1, g => g1, h => h1, i => i1, j => j1, sum => z);

	process is
	begin
	a1<="00000001";	b1<="00000010";	c1<="00000011";	d1<="00000100";
	e1<="00000101";	f1<="00000110";	g1<="00000111";	h1<="00001000";
	i1<="00001001";	j1<="00001010";
	wait for 20 fs;
	a1<="00000000";	b1<="00000000";	c1<="00000011";	d1<="00000100";
	e1<="00000101";	f1<="00000110";	g1<="00000111";	h1<="00001000";
	i1<="00001001";	j1<="00001010";
	wait for 20 fs;
	report "simulation finished successfully"
	severity FAILURE;
	end process;

end test;


--carry save adder entity
entity add is
	generic (N : integer);
	port (w,x,y : in bit_vector (N-1 downto 0);
	      sum,carry : out bit_vector (N downto 0)
	);
end entity;
architecture arch of add is
begin
	process (w,x,y)
	begin
	carry(0) <= '0';
	sum(N) <= '0';
	for i in 0 to N-1 loop
		sum(i) <= w(i) xor x(i) xor y(i);
		carry(i+1) <= (w(i) and x(i)) or (w(i) and y(i)) or (x(i) and y(i));
	end loop;
	end process;
end architecture;
