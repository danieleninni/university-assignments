library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_synchronizer is
--  Port ( );
end tb_synchronizer;

architecture Behavioral of tb_synchronizer is

component synchronizer is
  port (clk        : in  std_logic;
        input      : in  std_logic;
        sync_input : out std_logic);
end component;

signal clk, input, sync_input: std_logic;

begin

  uut : synchronizer port map (clk        => clk,
                               input      => input,
                               sync_input => sync_input);

  p_clk : process -- 100 MHz
  begin
    clk <= '0'; wait for 5 ns; clk <= '1'; wait for 5 ns;
  end process;

  p_input : process
  begin
    input <= '0'; wait for 22.5 ns;
    input <= '1'; wait for 20 ns;
    input <= '0'; wait for 10 ns;
    input <= '1'; wait for 5 ns;
    input <= '0'; wait for 5 ns;
    input <= '1'; wait for 5 ns;
    input <= '0'; wait;
  end process;

end Behavioral;