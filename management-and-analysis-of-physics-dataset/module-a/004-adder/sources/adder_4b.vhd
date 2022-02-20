library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder_4b is
  port (a_in  : in  std_logic_vector(3 downto 0);
        b_in  : in  std_logic_vector(3 downto 0);
        y_out : out std_logic_vector(4 downto 0));
end adder_4b;

architecture rtl of adder_4b is

component adder_1b is
  port (a_in  : in  std_logic;
        b_in  : in  std_logic;
        c_in  : in  std_logic;
        y_out : out std_logic;
        c_out : out std_logic);
end component;

signal y_a1_a2, y_a2_a3, y_a3_a4 : std_logic;

begin

a1: adder_1b port map (a_in  => a_in(0),
                       b_in  => b_in(0),
                       c_in  => '0',
                       y_out => y_out(0),
                       c_out => y_a1_a2);
                       
a2: adder_1b port map (a_in  => a_in(1),
                       b_in  => b_in(1),
                       c_in  => y_a1_a2,
                       y_out => y_out(1),
                       c_out => y_a2_a3);
                       
a3: adder_1b port map (a_in  => a_in(2),
                       b_in  => b_in(2),
                       c_in  => y_a2_a3,
                       y_out => y_out(2),
                       c_out => y_a3_a4);
                       
a4: adder_1b port map (a_in  => a_in(3),
                       b_in  => b_in(3),
                       c_in  => y_a3_a4,
                       y_out => y_out(3),
                       c_out => y_out(4));

end rtl;