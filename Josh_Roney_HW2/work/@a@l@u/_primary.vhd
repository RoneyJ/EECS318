library verilog;
use verilog.vl_types.all;
entity ALU is
    port(
        A               : in     vl_logic_vector(15 downto 0);
        B               : in     vl_logic_vector(15 downto 0);
        alu_code        : in     vl_logic_vector(4 downto 0);
        C               : out    vl_logic_vector(15 downto 0);
        overflow        : out    vl_logic
    );
end ALU;
