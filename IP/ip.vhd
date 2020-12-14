------------------------------------------------
-- Design: IP
-- Entity: ip
-- Author: Jonath, Lucas, Luiz e Teddy
-- Rev.  : 1.0
-- Date  : 13/12/2020
------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity ip is
port (  i_CLRn   : in  std_logic;
		i_CLK    : in  std_logic;
		i_Valid  : in  std_logic;
        i_Buffer : in  std_logic_vector(7 downto 0);
        o_SCK    : out std_logic;
        o_SSn    : out std_logic;
        o_MOSI   : out std_logic);
end ip;

architecture arch_1 of ip is

  component spi
  port ( i_CLK    : in  std_logic;
		 i_Tvalid : in  std_logic;
         i_Tdata  : in  std_logic_vector(7 downto 0);
         o_Tready : out std_logic;
         o_SCK    : out std_logic;
         o_SSn    : out std_logic;
         o_S      : out std_logic);
  end component;
  
  component axi4_controller
  port ( i_CLRn   : in  std_logic;
		 i_CLK    : in  std_logic;
		 i_Valid  : in  std_logic;
		 i_Tready : in  std_logic;
         i_Buffer : in  std_logic_vector(7 downto 0);
         o_Tvalid : out std_logic;
         o_Tdata  : out std_logic_vector(7 downto 0));
  end component;


signal w_Tready, w_Tvalid : std_logic;
signal w_Tdata : std_logic_vector(7 downto 0);

begin

  u_spi : spi port map ( i_CLK    => i_CLK,
                         i_Tvalid => w_Tvalid,
                         i_Tdata  => w_Tdata,
                         o_Tready => w_Tready,
                         o_SCK    => o_SCK,
                         o_SSn    => o_SSn,
                         o_S      => o_MOSI);
                                                 
  u_axi4_controller : axi4_controller port map ( i_CLRn   => i_CLRn,
                                                 i_CLK    => i_CLK,
                                                 i_Valid  => i_Valid,
                                                 i_Tready => w_Tready,
                                                 i_Buffer => i_Buffer,
                                                 o_Tvalid => w_Tvalid,
                                                 o_Tdata  => w_Tdata);

end arch_1;
