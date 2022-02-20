library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity d_ff is
  port (clk : in  std_logic;
        rst : in  std_logic;
        d   : in  std_logic;
        q   : out std_logic);
end entity d_ff;

architecture rtl of d_ff is
begin

  flipflop : process (clk) is
  begin
    if rising_edge(clk) then
      if rst = '1' then
        q <= '0';
      else
        q <= d;
      end if;
    end if;
  end process flipflop;

end architecture rtl;