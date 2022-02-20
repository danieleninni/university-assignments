library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_top is
--  Port ( );
end tb_top;

architecture Behavioral of tb_top is

component top is
  port (btn_in  : in  std_logic_vector(1 downto 0);
        led_out : out std_logic);
end component;

signal btn : std_logic_vector(1 downto 0);
signal led : std_logic;

begin

uut : top port map (btn_in(0) => btn(0),
                    btn_in(1) => btn(1),
                    led_out   => led);

pl : process
  begin
    btn(1) <= '0';
    btn(0) <= '0';    
    wait for 200 ns;
    btn(1) <= '0';
    btn(0) <= '1';    
    wait for 200 ns;
    btn(1) <= '1';
    btn(0) <= '0';    
    wait for 200 ns;
    btn(1) <= '1';
    btn(0) <= '1';    
    wait for 200 ns;
  end process;

end Behavioral;