library verilog;
use verilog.vl_types.all;
entity Mult_4x4 is
    port(
        X               : in     vl_logic_vector(3 downto 0);
        Y               : in     vl_logic_vector(3 downto 0);
        P               : out    vl_logic_vector(7 downto 0)
    );
end Mult_4x4;
