library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_blink is
--  Port ( );
end tb_blink;

architecture Behavioral of tb_blink is

component blink is
  port (clk   : in  std_logic;
        rst   : in  std_logic;
        y_out : out std_logic);
end component;

signal clk, rst, y_out : std_logic;

begin

  uut : blink port map(clk   => clk,
                       rst   => rst,
                       y_out => y_out);

  p_clk : process -- 100 MHz
  begin
    clk <= '0'; wait for 5 ns; clk <= '1'; wait for 5 ns;
  end process;
  
  p_rst : process
  begin
    rst <= '1'; wait for 15 ns; rst <= '0'; wait;
  end process;
  
end Behavioral;