------------------------------------------------
-- Design: controller
-- Entity: controller
-- Author: Lucas Cunha e Luiz Zimmermann
-- Rev.  : 1.0
-- Date  : 08/11/2020
------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controller is
port (i_CLK   			: in std_logic;
	   i_reset_n 		: in std_logic;
      i_limit_reach 	: in std_logic; 
      o_SEL   			: out std_logic_vector(1 downto 0);
      o_CLR_n_Counter 	: out std_logic;
		o_load_counter : out std_logic);
      
end controller;


architecture arch_1 of controller is

	type   t_STATE is (s_Init,s_C1,s_C2,s_C3,s_C4);
	signal r_STATE : t_STATE;
   signal w_NEXT  : t_STATE; 

    
begin
 
  p_STATE: process(i_CLK, i_reset_n) 
  begin
  		 if(i_reset_n = '0') then
         	 r_STATE <= s_Init;	
  		 elsif(rising_edge(i_CLK)) then			
			 r_STATE <= w_NEXT;		  
		 end if;
  	
  end process;  
        
   
  p_NEXT: process (r_STATE, i_limit_reach )
  begin
		case(r_STATE) is
		
			when s_Init => w_NEXT <= s_C1; 
																	
												
			when s_C1 => if(i_limit_reach  = '1') then 
                     w_NEXT <= s_C2;
                     o_CLR_n_Counter <='0';
                 else
                 	   o_CLR_n_Counter <='1';
				     end if;
                 
			when s_C2 => if(i_limit_reach  = '1') then 
                     w_NEXT <= s_C3;
                     o_CLR_n_Counter <='0';
                 else
                 	   o_CLR_n_Counter <='1';
				     end if;
                 
            when s_C3 => if(i_limit_reach  = '1') then 
                     w_NEXT <= s_C4;
                     o_CLR_n_Counter <='0';
                 else
                 	 o_CLR_n_Counter <='1';
					  end if;
                 
            when s_C4 => if(i_limit_reach  = '1') then 
                     w_NEXT <= s_C1;
                     o_CLR_n_Counter <='0';
                 else
                 	 o_CLR_n_Counter <='1';
				     end if;
								 
			when others => w_NEXT <= s_Init;
		 end case;
  end process;
     
   
    o_SEL <= "00" when (r_STATE = s_C1) else 
  		       "01" when (r_STATE = s_C2) else 
             "10" when (r_STATE = s_C3) else 	
             "11" when (r_STATE = s_C4) else 
             "00";
			                       
	o_load_counter  <= '1' when (r_STATE = s_Init) else '0';
    	
      
end arch_1;
