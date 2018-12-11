library verilog;
use verilog.vl_types.all;
entity receive is
    port(
        clear_b         : in     vl_logic;
        pclk            : in     vl_logic;
        sspclkin        : in     vl_logic;
        sspfssin        : in     vl_logic;
        ssprxd          : in     vl_logic;
        rxdata          : out    vl_logic_vector(7 downto 0);
        rcv             : out    vl_logic
    );
end receive;
