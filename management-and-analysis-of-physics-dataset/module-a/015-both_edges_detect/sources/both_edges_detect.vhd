library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity both_edges_detect is
  port (clk     : in  std_logic;
        rst     : in  std_logic;
        input   : in  std_logic;
        output  : out std_logic);
end both_edges_detect;

architecture rtl of both_edges_detect is

  signal ff1_output : std_logic;
  signal ff2_output : std_logic;

begin

  p : process (clk, rst)
  begin
    if (rst = '1') then
      ff1_output <= '0';
      ff2_output <= '0';
    elsif(rising_edge(clk)) then
      ff1_output <= input;
      ff2_output <= ff1_output;
    end if;
  end process p;

  output <= ff1_output xor ff2_output;

end rtl;