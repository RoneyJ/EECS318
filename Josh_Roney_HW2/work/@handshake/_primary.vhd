library verilog;
use verilog.vl_types.all;
entity Handshake is
    port(
        R               : in     vl_logic;
        A               : in     vl_logic;
        RESET           : in     vl_logic;
        clk             : in     vl_logic;
        E               : out    vl_logic
    );
end Handshake;
