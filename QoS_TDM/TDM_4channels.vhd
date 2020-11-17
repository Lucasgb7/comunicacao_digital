------------------------------------------------
-- Design: TDM_4channels
-- Entity: TDM_4channels
-- Author: Lucas Cunha e Luiz Zimmermann
-- Rev.  : 1.0
-- Date  : 08/11/2020
------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity TDM_4channels is
port (i_CLK_M 		: in std_logic;
      i_cicles_M  : in std_logic_vector(31 downto 0);
		i_reset_n_M : in std_logic;
		i_E1			: 	in std_logic_vector(15 downto 0);
		i_E2			: 	in std_logic_vector(15 downto 0);
		i_E3			: 	in std_logic_vector(15 downto 0);
		i_E4			: 	in std_logic_vector(15 downto 0);
		o_rdy_1 		: out std_logic;
		o_rdy_2 		: out std_logic;
		o_rdy_3 		: out std_logic;
		o_rdy_4 		: out std_logic;
		o_S 			: out std_logic_vector(15 downto 0)); 
end TDM_4channels;


architecture arch_1 of TDM_4channels is

component time_divisor is
port (i_CLK_M 		: in std_logic;
      i_cicles 	: in std_logic_vector(31 downto 0);
		i_reset_n_M : in std_logic;
		o_SEL_M 		: out std_logic_vector(1 downto 0)); 
end component;

component multiplexer_4channels is
port (i_A 		: in  std_logic_vector (15 downto 0); 
	   i_B 		: in  std_logic_vector (15 downto 0); 
      i_C 		: in  std_logic_vector (15 downto 0); 
      i_D 		: in  std_logic_vector (15 downto 0);
      o_rdy_A	: out std_logic;
      o_rdy_B	: out std_logic;
      o_rdy_C	: out std_logic;
      o_rdy_D	: out std_logic;
      i_seletor: in std_logic_vector(1 downto 0);
      o_S 		: out std_logic_vector (15 downto 0));
end component;

		
signal w_limit_reach, w_clr_counter, w_load  : std_logic;
signal w_SEL : std_logic_vector(1 downto 0);

begin

	u_td: time_divisor port map (i_CLK_M 		=> i_CLK_M,
										  i_cicles 		=> i_cicles_M,
										  i_reset_n_M 	=> i_reset_n_M,
										  o_SEL_M 		=> w_SEL);
												
		
	u_mult: multiplexer_4channels port map(i_A 		=> i_E1,
														i_B 		=> i_E2,
														i_C 		=> i_E3,
														i_D 		=> i_E4,
														o_rdy_A 	=> o_rdy_1,
														o_rdy_B	=> o_rdy_2,
														o_rdy_C	=> o_rdy_3,
														o_rdy_D	=> o_rdy_4,
														i_seletor=> w_SEL,
														o_S 		=> o_S);
                                                 
	
end arch_1;