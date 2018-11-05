library verilog;
use verilog.vl_types.all;
entity signed_mult is
    port(
        Mcand           : in     vl_logic_vector(4 downto 0);
        Mplier          : in     vl_logic_vector(4 downto 0);
        start           : in     vl_logic;
        \out\           : out    vl_logic_vector(9 downto 0)
    );
end signed_mult;
