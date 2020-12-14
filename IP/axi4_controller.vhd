------------------------------------------------
-- Design: Controller
-- Entity: controller
-- Author: Lucas e Teddy
-- Rev.  : 1.0
-- Date  : 07/12/2020
------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity axi4_controller is
port (  i_CLRn   : in  std_logic;
		i_CLK    : in  std_logic;
		i_Valid  : in  std_logic;
		i_Tready : in  std_logic;
        i_Buffer : in  std_logic_vector(7 downto 0);
        o_Tvalid : out std_logic;
        o_Tdata  : out std_logic_vector(7 downto 0));
end axi4_controller;

architecture arch_1 of axi4_controller is
  type 	 t_STATE is (s_0, s_1, s_2);
  signal r_STATE :	t_STATE;
  signal w_NEXT	 :	t_STATE;

begin
	p_STATE: process(i_CLK, i_CLRn)
    begin 
    	if (i_CLRn = '0') then
        	r_STATE <= s_0;
      	elsif (rising_edge(i_CLK)) then
        	r_STATE	<= w_NEXT;
        end if;
     end process;
     
     p_NEXT: process(r_STATE, i_Valid, i_Tready)
     begin
     	case (r_STATE) is
        	when s_0    =>  if (i_Valid = '1') then w_NEXT <= s_1; end if;
            when s_1    =>  if (i_Tready = '1') then w_NEXT <= s_2; end if;
            when s_2    =>  if (i_Valid = '0') then w_NEXT <= s_0; else w_NEXT <= s_2; end if;
            when others => w_NEXT <= s_0;
         end case;
      end process;
      
      o_Tvalid <= '0' when (r_STATE = s_0) else '1';
      o_Tdata  <= i_Buffer when (r_STATE = s_2) else "00000000";
      
end arch_1;