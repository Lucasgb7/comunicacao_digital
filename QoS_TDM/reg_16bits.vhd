------------------------------------------------
-- Design: Registrador de 16 bits
-- Entity: reg_16bits
-- Author: Lucas Cunha e Luiz Zimmermann
-- Rev.  : 1.0
-- Date  : 10/11/2020
------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity reg_16bits is
port ( i_CLK	: in  std_logic;								-- data input					
       i_D		: in  std_logic_vector (15 downto 0);	-- data input
       o_Q		: out std_logic_vector (15 downto 0));	-- data output
end reg_16bits;


architecture arch_1 of reg_16bits is
begin
  process(i_CLK, i_D)
  begin
  
    if (rising_edge(i_CLK)) then
      o_Q <= i_D;
    end if;
	 
  end process;
end arch_1;