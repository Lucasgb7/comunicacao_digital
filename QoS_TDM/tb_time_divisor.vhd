------------------------------------------------
-- Design: Projeto 2
-- Entity: tb_controller
-- Author: Lucas Cunha e Luiz Zimmermann
-- Rev.  : 1.0
-- Date  : 08/11/2020
------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
 
entity tb_time_divisor is
-- empty
end tb_time_divisor; 

architecture arch_1 of tb_time_divisor is

-- DUT component
component time_divisor is
port (i_CLK_M 		: in std_logic;
      i_cicles 	: in std_logic_vector(31 downto 0);
		i_reset_n_M : in std_logic;
		o_SEL_M 		: out std_logic_vector(1 downto 0));
end component;

signal w_CLK, w_CLR_n	: std_logic;
signal w_S 					: std_logic_vector(1 downto 0);
signal w_input				: std_logic_vector(31 downto 0);
constant c_CLK_PERIOD	: time := 2 ns;

begin

  -- Connect DUT
  DUT: time_divisor port map(i_CLK_M => w_CLK,
									  i_cicles => w_input,
									  i_reset_n_M => w_CLR_n,
									  o_SEL_M => w_S);                               
  p_CLK: process
  begin
  	w_CLK <= '0';
    wait for c_CLK_PERIOD/2;  
    w_CLK <= '1';
    wait for c_CLK_PERIOD/2;  
  end process p_CLK;
  
  
  p_INPUT: process
  begin
    -- A + B
    
    w_CLR_n <= '0';
    wait  for c_CLK_PERIOD; 
    w_CLR_n <= '1';   
    w_input <= "00000000000000000000000000000111";
    
    wait  for c_CLK_PERIOD;   
    wait  for c_CLK_PERIOD;
    wait  for c_CLK_PERIOD;
    wait  for c_CLK_PERIOD;
    wait  for c_CLK_PERIOD;
    wait  for c_CLK_PERIOD;
    wait  for c_CLK_PERIOD;
    wait  for c_CLK_PERIOD;
    
    wait  for c_CLK_PERIOD;
    wait  for c_CLK_PERIOD;   
    wait  for c_CLK_PERIOD;
    wait  for c_CLK_PERIOD;
    wait  for c_CLK_PERIOD;
    wait  for c_CLK_PERIOD;
    
    wait  for c_CLK_PERIOD;
    wait  for c_CLK_PERIOD;
    wait  for c_CLK_PERIOD;
    wait  for c_CLK_PERIOD;
    wait  for c_CLK_PERIOD;   
    wait  for c_CLK_PERIOD;
    wait  for c_CLK_PERIOD;
    wait  for c_CLK_PERIOD;
   
    wait  for c_CLK_PERIOD;
    wait  for c_CLK_PERIOD;
    wait  for c_CLK_PERIOD;
    wait  for c_CLK_PERIOD;
    wait  for c_CLK_PERIOD;
    wait  for c_CLK_PERIOD;   
    wait  for c_CLK_PERIOD;
    wait  for c_CLK_PERIOD;
    wait  for c_CLK_PERIOD;
    wait  for c_CLK_PERIOD;
    wait  for c_CLK_PERIOD;
    wait  for c_CLK_PERIOD;
    wait  for c_CLK_PERIOD;
    wait  for c_CLK_PERIOD;
 
    
    assert false report "Test done." severity note;
    wait;
  end process p_INPUT;
end arch_1;