library verilog;
use verilog.vl_types.all;
entity Full_Add is
    port(
        A               : in     vl_logic;
        B               : in     vl_logic;
        cin             : in     vl_logic;
        sum             : out    vl_logic;
        cout            : out    vl_logic
    );
end Full_Add;
