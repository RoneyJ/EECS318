library verilog;
use verilog.vl_types.all;
entity FA is
    port(
        A               : in     vl_logic;
        B               : in     vl_logic;
        cin             : in     vl_logic;
        sum             : out    vl_logic;
        cout            : out    vl_logic
    );
end FA;
