library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
  port (CLK100MHZ    : in  std_logic;
        uart_txd_in  : in  std_logic;
        uart_rxd_out : out std_logic);
end entity top;

architecture str of top is

  signal clock        : std_logic;
  signal data_to_send : std_logic_vector(7 downto 0) := X"61";
  signal data_valid   : std_logic;
  signal busy         : std_logic;
  signal uart_tx      : std_logic;

  component uart_transmitter is
    port (clock        : in  std_logic;
          data_to_send : in  std_logic_vector(7 downto 0);
          data_valid   : in  std_logic;
          busy         : out std_logic;
          uart_tx      : out std_logic);
  end component uart_transmitter;

  component uart_receiver is
    port (clock         : in  std_logic;
          uart_rx       : in  std_logic;
          valid         : out std_logic;
          received_data : out std_logic_vector(7 downto 0));
  end component uart_receiver;
  
begin -- architecture str

  uart_receiver_1 : uart_receiver port map (clock         => CLK100MHZ,
                                            uart_rx       => uart_txd_in,
                                            valid         => data_valid,
                                            received_data => data_to_send);
      
  uart_transmitter_1 : uart_transmitter port map (clock        => CLK100MHZ,
                                                  data_to_send => data_to_send,
                                                  data_valid   => data_valid,
                                                  busy         => busy,
                                                  uart_tx      => uart_rxd_out);

end architecture str;