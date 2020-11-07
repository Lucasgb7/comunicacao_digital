------------------------------------------------
-- Design: voter_trm
-- Entity: voter_trm
-- Author: Lucas Cunha e Luiz Zimmermann
-- Rev.  : 1.0
-- Date  : 07/11/2020
------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity voter_trm is
port ( i_A   : in  std_logic_vector (15 downto 0);  -- data input
       i_B   : in  std_logic_vector (15 downto 0);  -- data input
       i_C   : in  std_logic_vector (15 downto 0);  -- data input
       o_S   : out std_logic_vector (15 downto 0)); -- data output
end voter_trm;


architecture arch_1 of voter_trm is
begin
  process(i_A, i_B, i_C) 
  begin
     
		o_S <= (i_A and i_B) or (i_A and i_C) or (i_B and i_C);   
      
  end process;
end arch_1;
