library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder_1b is
  port (a_in  : in  std_logic;
        b_in  : in  std_logic;
        c_in  : in  std_logic;
        y_out : out std_logic;
        c_out : out std_logic);
end adder_1b;

architecture rtl of adder_1b is

begin

y_out <= a_in xor b_in xor c_in;
c_out <= (a_in and b_in) or (a_in and c_in) or (b_in and c_in);

end rtl;