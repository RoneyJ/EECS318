library verilog;
use verilog.vl_types.all;
entity CSA is
    port(
        a               : in     vl_logic_vector(7 downto 0);
        b               : in     vl_logic_vector(7 downto 0);
        c               : in     vl_logic_vector(7 downto 0);
        d               : in     vl_logic_vector(7 downto 0);
        e               : in     vl_logic_vector(7 downto 0);
        f               : in     vl_logic_vector(7 downto 0);
        g               : in     vl_logic_vector(7 downto 0);
        h               : in     vl_logic_vector(7 downto 0);
        i               : in     vl_logic_vector(7 downto 0);
        j               : in     vl_logic_vector(7 downto 0);
        cin             : in     vl_logic;
        z               : out    vl_logic_vector(15 downto 0);
        cout            : out    vl_logic
    );
end CSA;
