library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_sm is
--  Port ( );
end tb_sm;

architecture Behavioral of tb_sm is

component sm is
  port (TOG_EN, CLK, CLR : in  std_logic;
        Z1               : out std_logic);
end component;

signal TOG_EN, CLK, CLR, Z1 : std_logic;

begin

  uut : sm port map (TOG_EN => TOG_EN,
                     CLK    => CLK,
                     CLR    => CLR,
                     Z1     => Z1);

  p_CLK : process -- 100 MHz
  begin
    CLK <= '0'; wait for 5 ns; CLK <= '1'; wait for 5 ns;
  end process;

  p_CLR : process
  begin
    CLR <= '1'; wait for 15 ns; CLR <= '0'; wait;
  end process;

  p_TOG_EN : process
  begin
    TOG_EN <= '0'; wait for 100 ns; TOG_EN <= '1'; wait for 100 ns;
  end process;

end Behavioral;