-- TOGGLE FLIP-FLOP AS STATE MACHINE

library IEEE;
use IEEE.std_logic_1164.all;

entity sm is
  port (TOG_EN, CLK, CLR : in  std_logic;
        Z1               : out std_logic);
end sm;

architecture rtl of sm is

  type state_type is (ST0, ST1);
  signal state : state_type;
  
begin

  sync_proc : process(CLK)
  begin
    if (rising_edge(CLK)) then
      if (CLR = '1') then
        state <= ST0;
        Z1 <= '0';
      else
        case state is
        
          when ST0 =>
            Z1 <= '0';
            if (TOG_EN = '1') then state <= ST1;
            end if;
            
          when ST1 =>
            Z1 <= '1';
            if (TOG_EN = '1') then state <= ST0;
            end if;
            
          when others =>
            Z1 <= '0';
            state <= ST0;
        
        end case;
      end if;
    end if;
  end process sync_proc;

end rtl;