------------------------------------------------
-- Design: Mux12x8
-- Entity: mux12_1
-- Author: Luiz Zimmermann e Jonath Herdt
-- Rev.  : 1.0
-- Date  : 07/12/2020
------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity mux12_1 is
port ( i_Msg : in  std_logic_vector (11 downto 0);  -- data input
	   i_Sel : in std_logic_vector (3 downto 0); -- seletor
       o_S   : out std_logic); -- data output
end mux12_1;


architecture arch_1 of mux12_1 is
begin
  process(i_Msg, i_Sel) 
  begin
	if (i_SEL="0000") then
      o_S <= i_Msg(11);
    elsif (i_SEL="0001") then
      o_S <= i_Msg(10);
    elsif (i_SEL="0010") then
      o_S <= i_Msg(9);
    elsif (i_SEL="0011") then
      o_S <= i_Msg(8);
    elsif (i_SEL="0100") then
      o_S <= i_Msg(7);
    elsif (i_SEL="0101") then
      o_S <= i_Msg(6);
    elsif (i_SEL="0110") then
      o_S <= i_Msg(5);
    elsif (i_SEL="0111") then
      o_S <= i_Msg(4);
    elsif (i_SEL="1000") then
      o_S <= i_Msg(3);
    elsif (i_SEL="1001") then
      o_S <= i_Msg(2);
    elsif (i_SEL="1010") then
      o_S <= i_Msg(1);
    elsif (i_SEL="1011") then
      o_S <= i_Msg(0);
    else
      o_S <= '0';
    end if;
  end process;
end arch_1;
