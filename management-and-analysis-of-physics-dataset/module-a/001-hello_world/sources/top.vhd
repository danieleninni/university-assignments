library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
  port (btn_in  : in  std_logic;
        led_out : out std_logic);
end top;

architecture Behavioral of top is

begin

led_out <= btn_in;

end Behavioral;