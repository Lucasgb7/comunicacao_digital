------------------------------------------------
-- Design: Projeto 2
-- Entity: tb_controller
-- Author: Lucas Cunha e Luiz Zimmermann
-- Rev.  : 1.0
-- Date  : 08/11/2020
------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
 
entity tb_controller is
-- empty
end tb_controller; 

architecture arch_1 of tb_controller is

-- DUT component
component controller is
port (	i_CLK			: in std_logic;
		i_reset_n		: in std_logic;
        i_count			: in std_logic_vector(7 downto 0);
        o_SEL			: out std_logic_vector(1 downto 0);
        o_CLR_n_counter : out std_logic);
end component;

signal w_CLK, w_reset_n, w_CLR_n_counter: std_logic;
signal w_count : std_logic_vector(7 downto 0);
signal w_SEL : std_logic_vector(1 downto 0);
constant c_CLK_PERIOD : time := 2 ns;

begin

  -- Connect DUT
  DUT: controller port map(	i_CLK 			=> w_CLK,
  							i_reset_n		=> w_reset_n,
                            i_count			=> w_count,
                            o_SEL			=> w_SEL,
                            o_CLR_n_counter => w_CLR_n_counter);                               
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
    
    w_reset_n <= '0';
    wait  for c_CLK_PERIOD; 
    w_reset_n <= '1';   
	w_count <="00010000";
    
    wait  for c_CLK_PERIOD;   
    wait  for c_CLK_PERIOD;
    wait  for c_CLK_PERIOD;
    wait  for c_CLK_PERIOD;
    wait  for c_CLK_PERIOD;
    w_count <="00000100";
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