------------------------------------------------
-- Design: Register_12bits
-- Entity: register_12bits
-- Author: Jonath Herdt e Luiz Zimmerman
-- Rev.  : 1.0
-- Date  : 07/12/2020
------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity register_12bits is
port (	i_CLK  : in std_logic;
		i_E	   : in std_logic;
		i_D	   : in  std_logic_vector(11 downto 0);
		o_S	   : out std_logic_vector(11 downto 0));
end register_12bits;

architecture arch_1 of register_12bits is
begin
  process(i_CLK, i_E, i_D)
  begin
	if (rising_edge(i_CLK)) then
    	if (i_E = '1') then
        	o_S <= i_D;
        end if;
	end if;
  end process;
end arch_1;