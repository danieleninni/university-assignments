library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_adder_4b is
--  Port ( );
end tb_adder_4b;

architecture Behavioral of tb_adder_4b is

component adder_4b is
  port (a_in  : in  std_logic_vector(3 downto 0);
        b_in  : in  std_logic_vector(3 downto 0);
        y_out : out std_logic_vector(4 downto 0));
end component;

signal a, b : std_logic_vector(3 downto 0);
signal y : std_logic_vector(4 downto 0);

begin

uut : adder_4b port map (a_in  => a,
                         b_in  => b,
                         y_out => y);

p_ab : process
begin
  a(3) <= '0'; a(2) <= '0'; a(1) <= '1'; a(0) <= '1';
  b(3) <= '1'; b(2) <= '1'; b(1) <= '1'; b(0) <= '1';
  wait for 200 ns;
  a(3) <= '1'; a(2) <= '1'; a(1) <= '0'; a(0) <= '0';
  b(3) <= '0'; b(2) <= '1'; b(1) <= '0'; b(0) <= '1';
  wait for 200 ns;
  a(3) <= '0'; a(2) <= '0'; a(1) <= '1'; a(0) <= '0';
  b(3) <= '1'; b(2) <= '0'; b(1) <= '0'; b(0) <= '1';
  wait for 200 ns;
  a(3) <= '0'; a(2) <= '0'; a(1) <= '0'; a(0) <= '1';
  b(3) <= '1'; b(2) <= '1'; b(1) <= '1'; b(0) <= '0';
  wait for 200 ns;
  a(3) <= '0'; a(2) <= '0'; a(1) <= '0'; a(0) <= '0';
  b(3) <= '0'; b(2) <= '0'; b(1) <= '0'; b(0) <= '1';
  wait for 200 ns;
end process;    
  
end Behavioral;