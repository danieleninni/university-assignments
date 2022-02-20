library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_mux21 is
--  Port ( );
end tb_mux21;

architecture Behavioral of tb_mux21 is

component mux21 is
  port (a_in   : in  std_logic;
        b_in   : in  std_logic;
        sel_in : in  std_logic;
        y_out  : out std_logic);
end component;

signal a, b, sel, y : std_logic;

begin

uut : mux21 port map (a_in   => a,
                      b_in   => b,
                      sel_in => sel,
                      y_out  => y);

p_sel : process
begin
  sel <= '0'; wait for 200 ns;
  sel <= '1'; wait for 200 ns;
end process;

p_ab : process
begin
  a <= '0'; b <= '0'; wait for 125 ns;
  a <= '0'; b <= '1'; wait for 125 ns;
  a <= '1'; b <= '0'; wait for 125 ns;
  a <= '1'; b <= '1'; wait for 125 ns;
end process;

end Behavioral;