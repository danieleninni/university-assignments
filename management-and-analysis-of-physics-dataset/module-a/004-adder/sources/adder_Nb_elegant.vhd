library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity adder_Nb_elegant is
  generic (N : integer := 4);
  port (a_in  : in  std_logic_vector(N-1 downto 0);
        b_in  : in  std_logic_vector(N-1 downto 0);
        y_out : out std_logic_vector(N downto 0));
end adder_Nb_elegant;

architecture rtl of adder_Nb_elegant is

component adder_1b is
  port (a_in  : in  std_logic;
        b_in  : in  std_logic;
        c_in  : in  std_logic;
        y_out : out std_logic;
        c_out : out std_logic);
end component;

signal y_an_an1 : std_logic_vector(N downto 0);

begin

y_an_an1(0) <= '0';
y_out(N)    <= y_an_an1(N);
adders : for i in 0 to N-1 generate
  add : adder_1b port map (a_in  => a_in(i),
                           b_in  => b_in(i),
                           c_in  => y_an_an1(i),
                           y_out => y_out(i),
                           c_out => y_an_an1(i+1));
end generate adders;

end rtl;