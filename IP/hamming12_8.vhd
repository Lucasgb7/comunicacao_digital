------------------------------------------------
-- Design: Hamming12x8
-- Entity: hamming12_8
-- Author: Luiz Zimmermann e Jonath Herdt
-- Rev.  : 1.0
-- Date  : 07/12/2020
------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity hamming12_8 is
port ( i_Msg : in  std_logic_vector (7 downto 0);  -- data input
       o_S   : out std_logic_vector (11 downto 0)); -- data output
end hamming12_8;


architecture arch_1 of hamming12_8 is
begin
  process(i_Msg) 
  begin
	--x0  x1  x2 x3 x4 x5 x6 x7 x8 x9 x10 x11
    --        b7    b6 b5 b4    b3 b2 b1  b0
    
    --x11 x10 x9 x8 x7 x6 x5 x4 x3 x2 x1  x0

	o_S(11) <= i_Msg(7) XOR i_Msg(6) XOR i_Msg(4) XOR i_Msg(3) XOR i_Msg(1);
    o_S(10) <= i_Msg(7) XOR i_Msg(5) XOR i_Msg(4) XOR i_Msg(2) XOR i_Msg(1);
    o_S(9)  <= i_Msg(7);
    o_S(8)  <= i_Msg(6) XOR i_Msg(5) XOR i_Msg(4) XOR i_Msg(0);
    o_S(7 downto 5) <= i_Msg(6 downto 4);
    o_S(4) <= i_Msg(3) XOR i_Msg(2) XOR i_Msg(1) XOR i_Msg(0);
    o_S(3 downto 0) <= i_Msg(3 downto 0);
  end process;
end arch_1;
