library verilog;
use verilog.vl_types.all;
entity mux is
    port(
        a               : in     vl_logic;
        b               : in     vl_logic;
        c               : in     vl_logic;
        d               : in     vl_logic;
        sel             : in     vl_logic_vector(1 downto 0);
        y               : out    vl_logic
    );
end mux;
