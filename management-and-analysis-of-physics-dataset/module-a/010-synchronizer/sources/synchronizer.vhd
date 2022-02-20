library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity synchronizer is
  port (clk        : in  std_logic;
        input      : in  std_logic;
        sync_input : out std_logic);
end entity synchronizer;

architecture rtl of synchronizer is

signal internal : std_logic;

begin

  p_ff1 : process (clk) is
  begin
    if rising_edge(clk) then
      internal <= input;
    end if;
  end process;
  
  p_ff2 : process (clk) is
  begin
    if rising_edge(clk) then
      sync_input <= internal;
    end if;
  end process;

end architecture rtl;