--Structural FSM for HW4
--Josh Roney (jpr87)

entity structuralFSM is
	port(e,w,clock : in bit;
	     output : out bit);
end structuralFSM;

architecture fsm of structuralFSM is
	component dff
	port(d,clk : in bit;
	     q : out bit);
	end component;

	signal q1,q2 : bit;
	signal ands : bit_vector (3 downto 0);
	signal ors : bit_vector (1 downto 0);

	begin
	ands(0) <= q1 and (not q2);
	ands(1) <= q1 and w;
	ands(2) <= q2 and (not q1);
	ands(3) <= q2 and e;

	ors(0) <= e or ands(0) or ands(1);
	ors(1) <= w or ands(2) or ands(2);

	dff1 : dff port map(d => ors(0), clk => clock, q => q1);
	dff2 : dff port map(d => ors(1), clk => clock, q => q2);

	output <= q1 nor q2;

end fsm;

--testbench for FSM
entity testP5s is
end testP5s;

architecture test of testP5s is
	signal x,y : bit;
	signal clk : bit := '0';
	signal o : bit;

	component structuralFSM
	port(e,w,clock : in bit;
	     output : out bit);
	end component;

	begin
	fsm : structuralFSM port map(e => x, w => y, clock => clk, output => o);

	clock: process is
	begin
	wait for 5 fs;
	clk <= (not clk);
	end process clock;

	process is
	begin
	x <= '0';	y <= '0';

	wait for 2 fs; 
	y <= '1'; --go from State 0 to State 1

	wait for 10 fs; 
	x <= '1'; --go from State 1 to State 2

	wait for 10 fs; 
	x <= '0'; --go from State 2 to State 0
	y <= '0';

	wait for 10 fs; 
	x <= '1'; --go from State 0 to State 3
		
	wait for 10 fs;
	y <= '1'; --go from State 3 to State 2
		
	wait for 10 fs;
	x <= '0'; --go from State 2 to State 0
	y <= '0';

	wait for 20 fs;
	report "simulation finished successfully"
	severity FAILURE;
	end process;
end test;

--D Flip Flop for use by FSM
entity dff is
	port(d,clk : in bit;
	     q : out bit);
end DFF;

architecture basic of DFF is
    begin
	process (clk) is
	begin
	if (clk = '1' and clk'last_value = '0') then
		q <= d;
	end if;
	end process;
	
end basic;
