library verilog;
use verilog.vl_types.all;
entity freecellPlayer is
    port(
        clock           : in     vl_logic;
        source          : in     vl_logic_vector(3 downto 0);
        dest            : in     vl_logic_vector(3 downto 0);
        win             : out    vl_logic
    );
end freecellPlayer;
