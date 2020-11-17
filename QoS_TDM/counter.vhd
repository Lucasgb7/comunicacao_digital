------------------------------------------------
-- Design: counter
-- Entity: counter
-- Author: Lucas Cunha e Luiz Zimmermann
-- Rev.  : 1.0
-- Date  : 08/11/2020
------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is 
port ( i_CLK      : in std_logic;
	    i_CLR_n    : in std_logic;
       i_load     : in std_logic;
       i_limit    : in std_logic_vector(31 downto 0);
	    o_S        : out std_logic);
end counter;


architecture arch_1 of counter is

    signal registrador_limite : std_logic_vector(31 downto 0) := (others => '0');
    signal contador           : std_logic_vector(31 downto 0) := (others => '0');

begin
    
    
    p_load: process(i_load, i_limit) 
    begin
				
			if(i_load = '1') then
               registrador_limite <= i_limit;
			else
			   registrador_limite <= registrador_limite;
                    	  
           end if;

    end process;
    
	p_count: process(i_CLK, i_CLR_n)  
    begin
	 
    	if(i_CLR_n = '0') then 
        
        	contador <= (others =>'0');
			o_S <= '0';
			
      elsif(rising_edge(i_CLK)) then
        
        	if(unsigned(contador) >= unsigned(registrador_limite) - 1) then  
            	o_S <= '1';
         	else 
        		contador <= std_logic_vector(unsigned(contador) + 1); 
				o_S <= '0';
                
         end if;
            
      end if;        
    end process; 
end arch_1;