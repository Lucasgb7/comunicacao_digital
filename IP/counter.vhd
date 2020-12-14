------------------------------------------------
-- Design: Counter
-- Entity: counter
-- Author: Jonath Herdt e Luiz Zimmerman
-- Rev.  : 1.0
-- Date  : 07/12/2020
------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
port (	i_CLK   : in std_logic;
		i_CLRn  : in std_logic;
        i_UP    : in std_logic;
		o_S	    : out std_logic_vector(3 downto 0));
end counter;

architecture arch_1 of counter is
signal w_S : std_logic_vector (3 downto 0);
begin
  process(i_CLK, i_CLRn, i_UP)
  begin
  	if (i_CLRn = '0') then
        w_S <= "0000";
	elsif (rising_edge(i_CLK)) then
    	if (i_UP = '1') then
        	w_S <= std_logic_vector(unsigned(w_S) + 1);
        end if;
	end if;
    o_S <= w_S;
  end process;
end arch_1;