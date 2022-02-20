library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
  port (btn_in  : in  std_logic_vector(1 downto 0);
        led_out : out std_logic);
end top;

architecture Behavioral of top is

begin

led_out <= btn_in(0) xor btn_in(1);

end Behavioral;