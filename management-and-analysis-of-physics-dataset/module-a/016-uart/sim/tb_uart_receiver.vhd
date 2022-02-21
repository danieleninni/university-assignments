library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_uart_receiver is
--  Port ( );
end tb_uart_receiver;

architecture Behavioral of tb_uart_receiver is

  component uart_receiver is
    port (clock         : in  std_logic;
          uart_rx       : in  std_logic;
          valid         : out std_logic;
          received_data : out std_logic_vector(7 downto 0));
  end component;

  signal received_data : std_logic_vector(7 downto 0);
  signal clock, uart_rx, valid : std_logic;

begin

  uut: uart_receiver port map (clock         => clock,
                               uart_rx       => uart_rx,
                               valid         => valid,
                               received_data => received_data);

  p_clock : process -- 100 MHz
  begin
    clock <= '0'; wait for 5 ns; clock <= '1'; wait for 5 ns;
  end process;

  p_uart_rx : process
  begin
    uart_rx <= '1'; wait for 50 us;   -- idle
    uart_rx <= '0'; wait for 8.68 us; -- start
    uart_rx <= '1'; wait for 8.68 us; -- bit 0 (lsb)
    uart_rx <= '0'; wait for 8.68 us; -- bit 1
    uart_rx <= '0'; wait for 8.68 us; -- bit 2
    uart_rx <= '0'; wait for 8.68 us; -- bit 3
    uart_rx <= '0'; wait for 8.68 us; -- bit 4
    uart_rx <= '1'; wait for 8.68 us; -- bit 5
    uart_rx <= '1'; wait for 8.68 us; -- bit 6
    uart_rx <= '0'; wait for 8.68 us; -- bit 7 (msb)
    uart_rx <= '1'; wait for 8.68 ns; -- stop       
    uart_rx <= '1'; wait;             -- idle
  end process;

end Behavioral;