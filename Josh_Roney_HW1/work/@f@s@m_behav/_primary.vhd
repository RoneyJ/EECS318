library verilog;
use verilog.vl_types.all;
entity FSM_behav is
    port(
        \out\           : out    vl_logic;
        reset           : in     vl_logic;
        E               : in     vl_logic;
        W               : in     vl_logic;
        clk             : in     vl_logic
    );
end FSM_behav;
