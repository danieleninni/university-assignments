library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_d_ff is
-- Port ();
end tb_d_ff;

architecture Behavioral of tb_d_ff is

component d_ff is
  port (clk : in  std_logic;
        rst : in  std_logic;
        d   : in  std_logic;
        q   : out std_logic);
end component;

signal clk, rst, d, q : std_logic;

begin

  uut : d_ff port map (clk => clk,
                       rst => rst,
                       d   => d,
                       q   => q);

  p_clk : process -- 100 MHz
  begin
    clk <= '0'; wait for 5 ns; clk <= '1'; wait for 5 ns;
  end process;

  p_rst : process
  begin
    rst <= '1'; wait for 15 ns; rst <= '0'; wait;
  end process;

  p_d : process
  begin
    d <= '0'; wait for 67 ns;
    d <= '1'; wait for 67 ns;
  end process;

end Behavioral;