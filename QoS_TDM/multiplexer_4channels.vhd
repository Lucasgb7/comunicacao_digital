------------------------------------------------
-- Design: multiplexer_4channels
-- Entity: multiplexer_4channels
-- Author: Lucas Cunha e Luiz Zimmermann
-- Rev.  : 1.0
-- Date  : 08/11/2020
------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity multiplexer_4channels is
port (i_A : in  std_logic_vector (15 downto 0); 
	   i_B : in  std_logic_vector (15 downto 0); 
      i_C : in  std_logic_vector (15 downto 0); 
      i_D : in  std_logic_vector (15 downto 0);
      o_rdy_A : out std_logic;
      o_rdy_B : out std_logic;
      o_rdy_C : out std_logic;
      o_rdy_D : out std_logic;
      i_seletor : in std_logic_vector(1 downto 0);
      o_S : out std_logic_vector (15 downto 0));
      
end multiplexer_4channels;

architecture arch_1 of multiplexer_4channels is
begin

	 process(all)
    begin
    
	
    	if (i_seletor = "00") then o_S <= i_A;  
        elsif (i_seletor = "01") then o_S <= i_B; 
        elsif (i_seletor = "10") then o_S <= i_C; 
        elsif (i_seletor = "11") then o_S <= i_D; 
        else  o_S <= i_A;
		  
		  
		  
		
      end if;

	end process;
							
		o_rdy_A <= '1' when (i_seletor = "00") else '0';
		o_rdy_B <= '1' when (i_seletor = "01") else '0';
		o_rdy_C <= '1' when (i_seletor = "10") else '0';
		o_rdy_D <= '1' when (i_seletor = "11") else '0';
	
end arch_1;