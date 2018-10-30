library verilog;
use verilog.vl_types.all;
entity N_bit_adder is
    generic(
        N               : integer := 16
    );
    port(
        a               : in     vl_logic_vector;
        b               : in     vl_logic_vector;
        cin             : in     vl_logic;
        z               : out    vl_logic_vector;
        cout            : out    vl_logic
    );
end N_bit_adder;
