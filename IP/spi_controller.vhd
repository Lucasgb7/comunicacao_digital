------------------------------------------------
-- Design: Controller
-- Entity: controller
-- Author: Jonath Herdt e Luiz Zimmerman
-- Rev.  : 1.0
-- Date  : 07/12/2020
------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity spi_controller is
port (	i_CLK     : in std_logic;
		i_Tvalid  : in std_logic;
        i_Sel     : in std_logic_vector(3 downto 0);
        o_RE      : out std_logic;
        o_CCLRn   : out std_logic;
        o_CUP     : out std_logic;
        o_SCK     : out std_logic;
        o_Tready  : out std_logic;
        o_SSn     : out std_logic);
end spi_controller;

architecture arch_1 of spi_controller is
  type 	 t_STATE is (s_0, s_1, s_2);
  signal r_STATE :	t_STATE;
  signal w_NEXT	 :	t_STATE;

begin
	p_STATE: process(i_CLK, i_Tvalid)
    begin 
    	if (i_Tvalid = '0') then
        	r_STATE <= s_0;
      	elsif (rising_edge(i_CLK)) then
        	r_STATE	<= w_NEXT;
        end if;
     end process;
     
     p_NEXT: process(r_STATE, i_Tvalid, i_Sel)
     begin
     	case (r_STATE) is
        	when s_0    =>  if (i_Tvalid = '1') then w_NEXT <= s_1; end if;
            when s_1    =>  w_NEXT <= s_2;
            when s_2    =>  if (i_Sel = "1011") then w_NEXT <= s_0; else w_NEXT <= s_2; end if;
            when others => w_NEXT <= s_0;
         end case;
      end process;
      
      o_Tready <= '1' when (r_STATE = s_0) else '0';
      o_SSn    <= '0' when (r_STATE = s_0 or r_STATE = s_1) else '1';
      o_CCLRn  <= '0' when (r_STATE = s_1) else '1';
      o_RE     <= '1' when (r_STATE = s_1) else '0';
      o_CUP    <= '1' when (r_STATE = s_2) else '0';
      o_SCK    <= i_CLK when (r_STATE = s_2) else '1';
      
end arch_1;