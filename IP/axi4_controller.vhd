------------------------------------------------
-- Design: axi4_controller
-- Entity: axi4_controller
-- Author: Jonath, Lucas, Luiz e Teddy
-- Rev.  : 1.0
-- Date  : 05/12/2020
------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity axi4_controller is
port (	i_CLK			: in std_logic;
        i_VALID			: in std_logic;
        i_TREADY		: in std_logic;
        i_TLAST         : in std_logic;
		o_TVALID		: out std_logic;
        o_RST_COUNTER	: out std_logic;
      	o_CVALID		: out std_logic);		-- Contador
end axi4_controller;


architecture arch_1 of axi4_controller is

	type	t_STATE is (s_Init, s_readBuffer, s_send2SPI, s_Start);
	signal	r_STATE : t_STATE;
	signal 	w_NEXT  : t_STATE; 
  
begin
 
  p_STATE: process(i_CLK, i_RST) 
  begin
  		 if(i_RST = '0') then
         	 r_STATE <= s_Init;
  		 elsif(rising_edge(i_CLK)) then			
			 r_STATE <= w_NEXT;		  
		 end if;
  end process;
        
  p_NEXT: process (r_STATE, i_VALID)
  begin
		case(r_STATE) is
        
			when s_Init => w_NEXT <= s_readBuffer; 
																										
			when s_readBuffer => if(i_VALID = '1') then 
                w_NEXT <= s_send2SPI;
                end if;
                 
			when s_send2SPI => if(i_TREADY = '1') then 
                w_NEXT <= s_Start;
                end if;
                 
            when s_Start => if(o_TVALID  = '1') then 
                w_NEXT <= s_Init;
                end if;
		 
            when others => w_NEXT <= s_Init;
            
        end case;
    end process;

    o_TVALID    <=  '0' when (r_STATE = s_Init or r_STATE = s_readBuffer) else
                    '1' when (r_STATE = s_send2SPI or r_STATE = s_Start);
    
    o_RST_COUNTER    <= '0' when (r_STATE = s_readBuffer or r_STATE = s_send2SPI or r_STATE = s_Start) else
                        '1' when (r_STATE = s_Init);

    o_CVALID    <=  '0' when (r_STATE = s_Init or r_STATE = s_send2SPI or r_STATE = s_Start) else
                    '1' when (r_STATE = s_readBuffer);
                    
end arch_1;