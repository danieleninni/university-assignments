library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_uart_transmitter is
--  Port ( );
end tb_uart_transmitter;

architecture Behavioral of tb_uart_transmitter is

  component uart_transmitter is
    port (clock        : in  std_logic;
          data_to_send : in  std_logic_vector(7 downto 0);
          data_valid   : in  std_logic;
          busy         : out std_logic;
          uart_tx      : out std_logic);
  end component;
  
  signal data_to_send : std_logic_vector(7 downto 0) := "01100001";
  signal clock, data_valid, busy, uart_tx : std_logic;

begin

  uut: uart_transmitter port map (clock        => clock,
                                  data_to_send => data_to_send,
                                  data_valid   => data_valid,
                                  busy         => busy,
                                  uart_tx      => uart_tx);

  p_clock : process -- 100 MHz
  begin
    clock <= '0'; wait for 5 ns; clock <= '1'; wait for 5 ns;
  end process;
    
  p_data_valid : process
  begin
    data_valid <= '0'; wait for 25 ns;        
    data_valid <= '1'; wait for 10 ns;        
    data_valid <= '0'; wait;
  end process;

end Behavioral;