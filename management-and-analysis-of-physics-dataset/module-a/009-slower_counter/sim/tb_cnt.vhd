library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_cnt is
--  Port ( );
end tb_cnt;

architecture Behavioral of tb_cnt is

component cnt is
  port (clk         : in  std_logic;
        rst         : in  std_logic;
        updown      : in  std_logic;
        freeze      : in  std_logic;
        double_freq : in  std_logic;
        half_freq   : in  std_logic;
        y_out       : out std_logic_vector(3 downto 0));
end component;

signal clk, rst, updown, freeze, double_freq, half_freq : std_logic;
signal y_out : std_logic_vector(3 downto 0);

begin

  uut : cnt port map(clk         => clk,
                     rst         => rst,
                     updown      => updown,
                     freeze      => freeze,
                     double_freq => double_freq,
                     half_freq   => half_freq,
                     y_out       => y_out);

  p_clk : process -- 100 MHz
  begin
    clk <= '0'; wait for 5 ns; clk <= '1'; wait for 5 ns;
  end process;
  
  p_rst : process
  begin
    rst <= '1'; wait for 15 ns; rst <= '0'; wait;
  end process;
  
  p_updown : process
  begin
    updown <= '0'; wait for 2000 ns; updown <= '1'; wait for 2000 ns; updown <= '0'; wait;
  end process;
  
  p_freeze : process
  begin
    freeze <= '0'; wait for 2500 ns; freeze <= '1'; wait for 1000 ns; freeze <= '0'; wait;
  end process;
  
  p_double_freq : process
  begin
    double_freq <= '0'; wait for 5000 ns; double_freq <= '1'; wait for 1000 ns; double_freq <= '0'; wait;
  end process;
  
  p_half_freq : process
  begin
    half_freq <= '0'; wait for 7000 ns; half_freq <= '1'; wait for 1000 ns; half_freq <= '0'; wait;
  end process;
  
end Behavioral;