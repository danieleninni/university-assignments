library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_both_edges_detect is
--  Port ( );
end tb_both_edges_detect;

architecture Behavioral of tb_both_edges_detect is

component both_edges_detect is
  port (clk     : in  std_logic;
        rst     : in  std_logic;
        input   : in  std_logic;
        output  : out std_logic);
end component;

signal clk, rst, input, output : std_logic;

begin

  uut : both_edges_detect port map (clk    => clk,
                                  rst    => rst,
                                  input  => input,
                                  output => output);

  p_clk : process -- 100 MHz
  begin
    clk <= '0'; wait for 5 ns; clk <= '1'; wait for 5 ns;
  end process;
  
  p_rst : process
  begin
    rst <= '1'; wait for 15 ns; rst <= '0'; wait;
  end process;

  p_input : process
  begin
    input <= '0'; wait for 50 ns; input <= '1'; wait for 100 ns; input <= '0'; wait;
  end process;

end Behavioral;