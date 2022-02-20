library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_top is
--  Port ( );
end tb_top;

architecture Behavioral of tb_top is

component top is
  port (btn_in  : in  std_logic;
        led_out : out std_logic);
end component;

signal btn, led : std_logic;

begin

uut : top port map (btn_in => btn, led_out => led);

pl : process
  begin
    btn <= '0';
    wait for 200 ns;
    btn <= '1';
    wait for 200 ns;    
    btn <= '0';
    wait for 200 ns;
  end process;

end Behavioral;