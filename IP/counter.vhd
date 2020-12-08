------------------------------------------------
-- Design: counter
-- Entity: counter
-- Author: Jonath, Lucas, Luiz e Teddy
-- Rev.  : 1.0
-- Date  : 05/12/2020
------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
port(	i_CLK		: in std_logic;						-- clock
		i_RST		: in std_logic;						-- reset
     	i_CVALID	: in std_logic;						-- sinal de valido
        i_LIMIT		: in std_logic_vector(2 downto 0);	-- limite de palavras
        o_S			: in std_logic);					-- saida de ultima palavra
end counter;
 

architecture arch_1 of counter is

    signal REG_LIMITE	: std_logic_vector(2 downto 0) := (others => '0');
    signal COUNTER		: std_logic_vector(2 downto 0) := (others => '0');

begin
    p_VALID: process(i_CVALID, i_LIMIT) 
    begin	
        if(i_CVALID = '1') then
            REG_LIMITE <= i_LIMIT;
        else
            REG_LIMITE <= REG_LIMITE;               
        end if;
    end process;
    
    p_COUNT: process(i_CLK, i_RST)  
    begin
        if(i_RST = '0') then 
            COUNTER <= (others =>'0');
            o_S <= '0';
        elsif(rising_edge(i_CLK)) then
            if(unsigned(COUNTER) = unsigned(REG_LIMITE) - 1) then  
                o_S <= '1';
            else 
                COUNTER <= std_logic_vector(unsigned(COUNTER) + 1); 
                o_S <= '0';    
            end if;
        end if;        
    end process; 
end arch_1;