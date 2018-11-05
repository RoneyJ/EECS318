library verilog;
use verilog.vl_types.all;
entity N_shift_R is
    generic(
        M               : integer := 4
    );
    port(
        enable          : in     vl_logic;
        d               : in     vl_logic_vector;
        carry           : in     vl_logic;
        q               : out    vl_logic_vector
    );
end N_shift_R;
