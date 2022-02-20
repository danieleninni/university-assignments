library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity adder_Nb_common is
  generic (N : integer := 4);
  port (a_in  : in  std_logic_vector(N-1 downto 0);
        b_in  : in  std_logic_vector(N-1 downto 0);
        y_out : out std_logic_vector(N downto 0));
end adder_Nb_common;

architecture rtl of adder_Nb_common is

begin

y_out <= std_logic_vector(unsigned('0' & a_in) + unsigned('0' & b_in));

end rtl;