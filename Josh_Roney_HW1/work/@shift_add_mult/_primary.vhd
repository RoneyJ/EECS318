library verilog;
use verilog.vl_types.all;
entity Shift_add_mult is
    generic(
        M               : integer := 4
    );
    port(
        clk             : in     vl_logic;
        A               : in     vl_logic_vector;
        B               : in     vl_logic_vector;
        R               : out    vl_logic_vector;
        start           : in     vl_logic;
        done            : out    vl_logic
    );
end Shift_add_mult;
