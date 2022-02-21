library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_baudrate_generator is
--  Port ( );
end tb_baudrate_generator;

architecture Behavioral of tb_baudrate_generator is

  component baudrate_generator is
    port (clock        : in  std_logic;
          baudrate_out : out std_logic);
  end component;

  signal clock, baudrate_out : std_logic;

begin

  uut : baudrate_generator port map (clock        => clock,
                                     baudrate_out => baudrate_out);

  p_clock : process -- 100 MHz
  begin
    clock <= '0'; wait for 5 ns; clock <= '1'; wait for 5 ns;
  end process;

end Behavioral;