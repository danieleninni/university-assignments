library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_pattern_detect is
--  Port ( );
end tb_pattern_detect;

architecture test of tb_pattern_detect is

  signal a   : std_logic;
  signal clk : std_logic :='0';
  signal rst : std_logic;
  signal y   : std_logic;

begin -- architecture test

  DUT : entity work.pattern_detect port map (a   => a,
                                             clk => clk,
                                             rst => rst,
                                             y   => y);
      
  clk <= not clk after 2 ns;
  
  WaveGen_Proc : process
  begin
    a   <= '0';
    rst <= '1'; wait for 10 ns; wait until rising_edge(clk);
    rst <= '0'; wait for 10 ns; wait until rising_edge(clk);
    rst <= '1';
    wait until rising_edge(clk);
    a <= '0';
    wait until rising_edge(clk);
    a <= '1';
    wait until rising_edge(clk);
    a <= '0';
    wait until rising_edge(clk);
    a <= '1';
    wait for 100 ns;
    wait;
  end process WaveGen_Proc;
  
end architecture test;