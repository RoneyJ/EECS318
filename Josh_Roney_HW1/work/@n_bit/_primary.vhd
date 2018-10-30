library verilog;
use verilog.vl_types.all;
entity N_bit is
    generic(
        N               : integer := 18
    );
    port(
        A               : in     vl_logic_vector;
        B               : in     vl_logic_vector;
        C               : in     vl_logic_vector;
        sum             : out    vl_logic_vector;
        cout            : out    vl_logic_vector
    );
end N_bit;
