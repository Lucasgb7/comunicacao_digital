------------------------------------------------
-- Design: axi4_design
-- Entity: axi4_design
-- Author: Jonath, Lucas, Luiz e Teddy
-- Rev.  : 1.0
-- Date  : 07/12/2020
------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity axi4_design is
port(   i_CLK       : in std_logic;
        i_RST       : in std_logic;
        i_VALID     : in std_logic;
        i_READY     : in std_logic;
        i_TDATA     : in std_logic_vector(7 downto 0);
        i_LIMIT     : in std_logic;
        o_ACLK      : in std_logic;
        o_TVALID    : out std_logic;
        o_TLAST     : out std_logic;
        o_TDATA     : out std_logic_vector(7 downto 0);
end axi4_design;


architecture arch_1 of axi4_design is

component axi4_controller is
port (	i_CLK			: in std_logic;
        i_VALID			: in std_logic;
        i_TREADY		: in std_logic;
        o_TVALID		: out std_logic;
        o_RST_COUNTER	: out std_logic;
        o_CVALID		: out std_logic);   -- contador
end axi4_controller;

component counter is
port (	i_CLK		: in std_logic;						-- clock
        i_RST		: in std_logic;						-- reset
        i_CVALID	: in std_logic;						-- sinal de valido
        i_LIMIT		: in std_logic_vector(2 downto 0);	-- limite de palavras
        o_S			: in std_logic);					-- saida de ultima palavra
end counter;

signal w_RST_COUNTER, w_CVALID : std_logic;

begin

    u_counter: counter  port map(   i_CLK       =>  i_CLK,
                                    i_RST       =>  w_RST_COUNTER,
                                    i_CVALID    =>  w_CVALID,
                                    i_LIMT      =>  i_LIMIT,
                                    o_S         =>  o_TLAST);

	u_counter: axi4_controller  port map(   i_CLK           =>  i_CLK,
                                            i_RST           =>  i_RST,
                                            i_TREADY        =>  i_TREADY,
                                            o_TVALID        =>  o_TVALID,
                                            o_RST_COUNTER   =>  w_RST_COUNTER
                                            o_CVALID        =>  w_CVALID);

end arch_1;