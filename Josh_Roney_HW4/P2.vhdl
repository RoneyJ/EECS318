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
architecture mult of shiftadd is
	component nbitand is
	generic(N : integer);
	port(x : in bit_vector (N-1 downto 0);
	     y,en : in bit;
	     z : out bit_vector (N-1 downto 0)
	);
	end component;

	component ncombine is
	generic(N : integer);
	port(a,b : in bit_vector (N-1 downto 0);
	     en : in bit;
	     c : out bit_vector (N*2-1 downto 0)
	);
	end component;

	component rightshift is
	generic(N : integer);
	port(d : in bit_vector (N-1 downto 0);
	     cin,en : in bit;
	     q : out bit_vector (N-1 downto 0)
	);
	end component;

	component nadd is
	generic(N : integer);
	port(x,y : in bit_vector (N-1 downto 0);
	     z : out bit_vector (N-1 downto 0);
	     cout : out bit
	);
	end component;

	signal v,w : bit_vector (M-1 downto 0);
	signal w1,w2 : bit_vector (M-1 downto 0);
	signal w3,fin : bit;
	signal w4,w6 : bit_vector (M*2-1 downto 0);
	signal w5 : bit_vector (M downto 0);

	begin
	nbit : nbitand
	generic map(N => M)
	port map(x => a, y => w(0), en => clk, z => w1);

	n1 : nadd
	generic map(N => M)
	port map(x => w1, y => v, z => w2, cout => w3);

	c1 : ncombine
	generic map(N => M)
	port map(a => w2, b => w, en => clk, c => w6);

	r1 : rightshift
	generic map(N => M*2)
	port map(d => w6, cin => w3, en => clk, q => w4);

	process (start,clk) is
	variable i : integer := 0;
	begin
	if(start = '1') then
		w <= b;
		v <= (others => '0');
		i := 0;
		fin <= '0';
	else
	if(clk = '1' and clk'last_value = '0') then
		i := i + 1;
	
	elsif(clk = '0' and clk'last_value = '1') then
		if(i = M) then
			fin <= '1';
			done <= '1';
			p <= w4;
		else
		w <= w4(M-1 downto 0);
		v <= w4(M*2-1 downto M);
		end if;
	end if;
	
	end if;
	end process;

	

end mult;

--test bench
entity testp2 is
end testp2;
architecture test of testp2 is
	component shiftadd is
	generic(M : integer);
	port(clk,start : in bit;
	     a,b : in bit_vector (M-1 downto 0);
	     p : out bit_vector (M*2-1 downto 0);
	     done : out bit
	);
	end component;

	signal x,y : bit_vector (3 downto 0);
	signal s,d : bit;
	signal clock : bit := '0';
	signal c : bit_vector (7 downto 0);

	begin
	add : shiftadd
	generic map(M => 4)
	port map(clk => clock, start => s, a => x, b => y, p => c, done => d);

	code : process is
	begin
	x <= "0010";	y <= "0100"; clock <= '0';	
	wait for 1 fs;
	s <= '1';

	wait for 1 fs;
	s <= '0';

	wait for 3 fs;
	clock <= '1';

	wait for 5 fs;
	clock <= '0';
	
	wait for 1 fs;
	s <= '0';
	
	wait for 4 fs;
	clock <= '1';

	wait for 5 fs;
	clock <= '0';

	wait for 5 fs;
	clock <= '1';

	wait for 5 fs;
	clock <= '0';

	wait for 5 fs;
	clock <= '1';

	wait for 5 fs;
	clock <= '0';

	wait for 5 fs;
	clock <= '1';

	wait for 5 fs;
	clock <= '0';

	wait for 5 fs;
	clock <= '1';

	wait for 5 fs;
	clock <= '0';

	wait for 1 fs;
	s <= '1';
	x <= "1111";	y <= "0011";

	wait for 4 fs;
	clock <= '1';
	
	wait for 1 fs;
	s <= '0';

	wait for 4 fs;
	clock <= '0';

	wait for 5 fs;
	clock <= '1';

	wait for 5 fs;
	clock <= '0';

	wait for 5 fs;
	clock <= '1';

	wait for 5 fs;
	clock <= '0';

	wait for 5 fs;
	clock <= '1';

	wait for 5 fs;
	clock <= '0';

	wait for 5 fs;
	clock <= '1';

	wait for 5 fs;
	clock <= '0';

	wait for 10 fs;
	report "simulation finished successfully"
	severity FAILURE;
	end process;
	
end test;

--n-bit and entity
--and every bit of n-bit input x with 1-bit input y
entity nbitand is
	generic(N : integer);
	port(x : in bit_vector (N-1 downto 0);
	     y,en : in bit;
	     z : out bit_vector (N-1 downto 0)
	);
end nbitand;
architecture arch of nbitand is

	begin
	process (x,y,en) is
	begin
	if(en = '1') then
		for i in 0 to N-1 loop
		z(i) <= x(i) and y; 
		end loop;
	end if;
	end process;
end arch;

--combines 2 n-bit vectors into on 2*n-bit vector
entity ncombine is
	generic(N : integer);
	port(a,b : in bit_vector (N-1 downto 0);
	     en : in bit;
	     c : out bit_vector (N*2-1 downto 0)
	);
end ncombine;
architecture combine of ncombine is
	begin
	process (a,b,en) is
	begin
	if(en = '1') then
		c <= a & b;
	end if;
	end process;
end combine;

--n-bit right shift
--shifts an n-bit register right one bit
--shifts in a '0' bit
entity rightshift is
	generic(N : integer);
	port(d : in bit_vector (N-1 downto 0);
	     cin,en : in bit;
	     q : out bit_vector (N-1 downto 0)
	);
end rightshift;
architecture rshift of rightshift is
	begin
	process (d,cin,en) is
	begin
	if(en = '1') then
		q(N-1) <= cin;
		for i in 0 to N-2 loop
			q(i) <= d(i+1);
		end loop;
	end if;
	end process;
end rshift; 

--n-bit adder
entity nadd is
	generic(N : integer);
	port(x,y : in bit_vector (N-1 downto 0);
	     z : out bit_vector (N-1 downto 0);
	     cout : out bit
	);
end nadd;
architecture add of nadd is
	signal carry : bit_vector (N downto 0);

	begin
	carry(0) <= '0';
	f : for i in 0 to N-1 generate
		z(i) <= x(i) xor y(i) xor carry(i);
		carry(i+1) <= (x(i) and y(i)) or (x(i) and carry(i)) or (y(i) and carry(i));
	end generate;
	cout <= carry(N);
end add;
