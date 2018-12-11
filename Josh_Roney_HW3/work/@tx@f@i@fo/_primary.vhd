library verilog;
use verilog.vl_types.all;
entity TxFIFo is
    port(
        psel            : in     vl_logic;
        pwrite          : in     vl_logic;
        clear_b         : in     vl_logic;
        pclk            : in     vl_logic;
        remove          : in     vl_logic;
        pwdata          : in     vl_logic_vector(7 downto 0);
        ssptxintr       : out    vl_logic;
        tmit            : out    vl_logic;
        txdata          : out    vl_logic_vector(7 downto 0)
    );
end TxFIFo;
