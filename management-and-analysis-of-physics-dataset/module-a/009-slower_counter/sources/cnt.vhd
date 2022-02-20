library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity cnt is
  port (clk         : in  std_logic;
        rst         : in  std_logic;
        updown      : in  std_logic;
        freeze      : in  std_logic;
        double_freq : in  std_logic;
        half_freq   : in  std_logic;
        y_out       : out std_logic_vector(3 downto 0));
end cnt;

architecture rtl of cnt is

signal slow_clk : std_logic;
signal slow_clk_p : std_logic; -- previous value of "slow_clk"
signal counter : unsigned(27 downto 0);
signal slow_counter : unsigned(3 downto 0);

begin

  p_cnt : process(clk, rst) is
    begin
    if rst = '1' then
      counter <= (others => '0');
    elsif rising_edge(clk) then
      if freeze = '0' then
        if updown = '0' then
          counter <= counter + 1;
        else
          counter <= counter - 1;
        end if;
      end if;
    end if;
  end process;
  
  p_slw_clk : process(clk, double_freq, half_freq) is
    begin
    if double_freq = '1' and half_freq = '0' then
      slow_clk <= counter(2); -- the counter doubles its blinking frequency
    elsif double_freq = '0' and half_freq = '1' then
      slow_clk <= counter(4); -- the counter halves its blinking frequency
    else
      slow_clk <= counter(3);
    end if;
  end process;
  
  p_slw_cnt : process(clk, rst, slow_clk) is
    begin
    if rst = '1' then
      slow_counter <= (others => '0');
    elsif rising_edge(clk) then
      slow_clk_p <= slow_clk; -- assignment that occurs only at the end of the process "p_slw_cnt"!
      if slow_clk = '1' and slow_clk_p = '0' then -- "RISING EDGE" (if "slow_clk" has changed from 0 to 1, then...)
        if freeze = '0' then
          if updown = '0' then
            slow_counter <= slow_counter + 1;
          else
            slow_counter <= slow_counter - 1;
          end if;
        end if;
      end if;
    end if;
  end process;
  
  y_out <= std_logic_vector(slow_counter);

end rtl;