library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity t_ff is
  port (clk : in  std_logic;
        rst : in  std_logic;
        t   : in  std_logic;
        q   : out std_logic);
end entity t_ff;

architecture rtl of t_ff is
begin

  flipflop : process (clk) is
  variable tmp : std_logic;
  begin
    if rising_edge(clk) then
      if rst = '1' then
        tmp := '0';
      else
        tmp := t xor tmp;
      end if;
    end if;
    q <= tmp;
  end process flipflop;

end architecture rtl;