library verilog;
use verilog.vl_types.all;
entity SSP is
    port(
        PCLK            : in     vl_logic;
        CLEAR_B         : in     vl_logic;
        PSEL            : in     vl_logic;
        PWRITE          : in     vl_logic;
        SSPCLKIN        : in     vl_logic;
        SSPFSSIN        : in     vl_logic;
        SSPRXD          : in     vl_logic;
        PWDATA          : in     vl_logic_vector(7 downto 0);
        PRDATA          : out    vl_logic_vector(7 downto 0);
        SSPCLKOUT       : out    vl_logic;
        SSPFSSOUT       : out    vl_logic;
        SSPTXD          : out    vl_logic;
        SSPOE_B         : out    vl_logic;
        SSPTXINTR       : out    vl_logic;
        SSPRXINTR       : out    vl_logic
    );
end SSP;
