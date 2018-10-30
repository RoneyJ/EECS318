library verilog;
use verilog.vl_types.all;
entity shift_add_mult is
    generic(
        N               : integer := 4
    );
    port(
        clk             : in     vl_logic;
        carry           : in     vl_logic;
        A               : in     vl_logic_vector;
        B               : in     vl_logic_vector;
        R               : out    vl_logic_vector
    );
end shift_add_mult;
