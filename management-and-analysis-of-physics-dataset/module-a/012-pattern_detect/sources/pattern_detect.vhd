library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pattern_detect is
  port (a     : in  std_logic;
        clk   : in  std_logic;
        rst   : in  std_logic;
        y     : out std_logic);
end entity pattern_detect;

architecture rtl of pattern_detect is

  type state_t is (S0, S1, S2, S3, Detect);
  signal state : state_t := S0;

begin -- architecture rtl

  main : process (clk) is
  begin -- process main
    if rising_edge(clk) then -- rising clock edge
      if rst = '0' then -- synchronous reset (active low)
        state <= S0;
        y     <= '0';
      else
        case state is
        
          when S0 =>
            y <= '0';
            if a = '0' then
              state <= S1;
            end if;

          when S1 =>
            y <= '0';
            if a = '0' then
              state <= S1;
            elsif a = '1' then
              state <= S2;
            end if;

          when S2 =>
            y <= '0';
            if a = '0' then
              state <= S3;
            elsif a = '1' then
              state <= S0;
            else
              null;
            end if;

          when S3 =>
            y <= '0';
            if a = '0' then
              state <= S1;
            elsif a = '1' then
              state <= Detect;
            else
              null;
            end if;

          when Detect =>
            y <= '1';
            state <= S0;

          when others => null;

        end case;
      end if;
    end if;
  end process main;
  
end architecture rtl;