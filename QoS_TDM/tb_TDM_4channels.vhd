------------------------------------------------
-- Design: tb_TDM_4channels
-- Entity: tb_TDM_4channels
-- Author: Lucas Cunha e Luiz Zimmermann
-- Rev.  : 1.0
-- Date  : 08/11/2020
------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
 
entity tb_TDM_4channels is
-- empty
end tb_TDM_4channels; 

architecture arch_1 of tb_TDM_4channels is

-- DUT component
component TDM_4channels is
port (i_CLK_M 		: in std_logic;
      i_cicles_M  : in std_logic_vector(31 downto 0);
		i_reset_n_M : in std_logic;
		i_E1	: 	in std_logic_vector(15 downto 0);
		i_E2	: 	in std_logic_vector(15 downto 0);
		i_E3	: 	in std_logic_vector(15 downto 0);
		i_E4	: 	in std_logic_vector(15 downto 0);
		o_rdy_1 	: out std_logic;
		o_rdy_2 	: out std_logic;
		o_rdy_3 	: out std_logic;
		o_rdy_4 	: out std_logic;
		o_S 	: out std_logic_vector(15 downto 0)); 
end component;

signal w_CLK, w_CLR_n : std_logic;
signal w_rdy1, w_rdy2, w_rdy3, w_rdy4 : std_logic;
signal w_input : std_logic_vector(31 downto 0);
signal w_1, w_2, w_3, w_4 : std_logic_vector(15 downto 0);
signal w_S : std_logic_vector(15 downto 0);

constant c_CLK_PERIOD : time := 2 ns;

begin

  -- Connect DUT
  DUT: TDM_4channels port map (i_CLK_M 		=> w_CLK,
                                   i_cicles_M   => w_input,
                                   i_reset_n_M  => w_CLR_n,
                                   i_E1	 		=> w_1,
                                   i_E2	 		=> w_2,
                                   i_E3	 		=> w_3,
                                   i_E4	 		=> w_4,
                                   o_rdy_1 		=> w_rdy1,
                                   o_rdy_2 		=> w_rdy2,
                                   o_rdy_3 		=> w_rdy3,
                                   o_rdy_4 		=> w_rdy4,
                                   o_S 			=> w_S);                               
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
    w_1 <= "0000111100001111";
    w_2 <= "1111000011110000";
    w_3 <= "0000111111110000";
    w_4 <= "1111000000001111";
    
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