library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_t_ff is
-- Port ();
end tb_t_ff;

architecture Behavioral of tb_t_ff is

component t_ff is
  port (clk : in  std_logic;
        rst : in  std_logic;
        t   : in  std_logic;
        q   : out std_logic);
end component;

signal clk, rst, t, q : std_logic;

begin

  uut : t_ff port map (clk => clk,
                       rst => rst,
                       t   => t,
                       q   => q);

  p_clk : process -- 100 MHz
  begin
    clk <= '0'; wait for 5 ns; clk <= '1'; wait for 5 ns;
  end process;

  p_rst : process
  begin
    rst <= '1'; wait for 15 ns; rst <= '0'; wait;
  end process;

  p_t : process
  begin
    t <= '0'; wait for 67 ns;
    t <= '1'; wait for 67 ns;
  end process;

end Behavioral;