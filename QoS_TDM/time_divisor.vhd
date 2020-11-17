------------------------------------------------
-- Design: time_divisor
-- Entity: time_divisor
-- Author: Lucas Cunha e Luiz Zimmermann
-- Rev.  : 1.0
-- Date  : 08/11/2020
------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity time_divisor is
port (i_CLK_M : in std_logic;
      i_cicles : in std_logic_vector(31 downto 0);
		i_reset_n_M : in std_logic;
		o_SEL_M : out std_logic_vector(1 downto 0)); 
end time_divisor;


architecture arch_1 of time_divisor is

component controller is
port (i_CLK   			: in std_logic;
	   i_reset_n 		: in std_logic;
      i_limit_reach 	: in std_logic; 
      o_SEL   			: out std_logic_vector(1 downto 0);
      o_CLR_n_Counter 	: out std_logic;
		o_load_counter : out std_logic);
end component;

component counter is
port ( i_CLK      : in std_logic;
	    i_CLR_n    : in std_logic;
       i_load     : in std_logic;
       i_limit    : in std_logic_vector(31 downto 0);
	    o_S        : out std_logic);
end component;

signal w_limit_reach, w_clr_counter, w_load  : std_logic;

begin

	u_counter: counter      port map(i_CLK => i_CLK_M,  
												i_CLR_n => w_clr_counter,   
												i_load => w_load, 
												i_limit => i_cicles,   
												o_S => w_limit_reach);

	u_controler: controller port map(i_CLK  => i_CLK_M, 			
												i_reset_n => i_reset_n_M,	
												i_limit_reach => w_limit_reach,
												o_SEL => o_SEL_M,  			
												o_CLR_n_Counter => w_clr_counter,
												o_load_counter => w_load);
                                                 
	
end arch_1;