library verilog;
use verilog.vl_types.all;
entity NA is
    generic(
        M               : integer := 8
    );
    port(
        enable          : in     vl_logic;
        a               : in     vl_logic_vector;
        b               : in     vl_logic;
        \out\           : out    vl_logic_vector
    );
end NA;
