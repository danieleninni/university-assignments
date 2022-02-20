library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cmb_clk is
  port (clk      : in  std_logic;
        rst      : in  std_logic;
        a_in     : in  std_logic;
        ab_in    : in  std_logic;
        cmb_out  : out std_logic;
        ltch_out : out std_logic;
        ff_out   : out std_logic);
end cmb_clk;

architecture rtl of cmb_clk is
begin

  p_ff : process(clk, rst, a_in, ab_in) is
    begin
    if rst = '1' then
      ff_out <= '0';
    elsif rising_edge(clk) then
      ff_out <= a_in and ab_in;
    end if;
  end process;

  p_ltch : process(clk, rst, a_in, ab_in) is
    begin
    if rst = '1' then
      ltch_out <= '0';
    elsif clk = '1' then
      ltch_out <= a_in and ab_in;
    end if;
  end process;

  cmb_out <= a_in and ab_in;

end architecture rtl;