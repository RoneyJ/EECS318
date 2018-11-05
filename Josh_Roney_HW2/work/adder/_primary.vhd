library verilog;
use verilog.vl_types.all;
entity adder is
    port(
        A               : in     vl_logic_vector(15 downto 0);
        B               : in     vl_logic_vector(15 downto 0);
        CODE            : in     vl_logic_vector(2 downto 0);
        cin             : in     vl_logic;
        coe             : in     vl_logic;
        C               : out    vl_logic_vector(15 downto 0);
        vout            : out    vl_logic;
        cout            : out    vl_logic
    );
end adder;
