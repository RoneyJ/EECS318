library verilog;
use verilog.vl_types.all;
entity RxFIFO is
    port(
        psel            : in     vl_logic;
        pwrite          : in     vl_logic;
        clear_b         : in     vl_logic;
        pclk            : in     vl_logic;
        rcv             : in     vl_logic;
        rxdata          : in     vl_logic_vector(7 downto 0);
        ssprxintr       : out    vl_logic;
        prdata          : out    vl_logic_vector(7 downto 0)
    );
end RxFIFO;
