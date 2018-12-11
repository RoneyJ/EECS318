library verilog;
use verilog.vl_types.all;
entity transmit is
    port(
        txdata          : in     vl_logic_vector(7 downto 0);
        clear_b         : in     vl_logic;
        pclk            : in     vl_logic;
        tmit            : in     vl_logic;
        sspoe_b         : out    vl_logic;
        ssptxd          : out    vl_logic;
        sspfssout       : out    vl_logic;
        sspclkout       : out    vl_logic;
        remove          : out    vl_logic
    );
end transmit;
