library verilog;
use verilog.vl_types.all;
entity DFF is
    port(
        Q               : out    vl_logic;
        D               : in     vl_logic;
        clk             : in     vl_logic
    );
end DFF;
