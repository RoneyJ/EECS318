--Behavioral FSM for HW4
--Josh Roney (jpr87)
entity behavioralFSM is
	port(e,w,clk : in bit;
	     o : out bit);
end entity;

architecture fsm of behavioralFSM is
	variable state : bit_vector (1 downto 0) := "00";
	
	begin
	process (clk) is
	case state is
      when "00" => 
			o <= '1';
			
			if(e = '0' and w = '1') then
				state := "01";
			elsif(e = '1' and w = '1') then
				state := "10";
			elsif(e = '1' and w = '0') then
				state := "11";
			end if;
			
      when "01" => 
			o <= '0';
			
			if(e = '1') then
				state := "10";
			end if;
			
      when "10" => 
			o <= '0';
			
			if(e = '0' and w = '0') then
				state := "00";
			end if;
			
      when "11" => 
			o <= '0';
			
			if(w = '0') then
				state := "10";
			end if;
			
  end case;
	end process;
end architecture;

--testbench for FSM
entity testP5b is
end testP5b;

architecture test of testP5b is
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
