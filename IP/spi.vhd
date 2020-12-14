------------------------------------------------
-- Design: SPI
-- Entity: spi
-- Author: Luiz Zimmermann e Jonath Herdt
-- Rev.  : 1.0
-- Date  : 07/12/2020
------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity spi is
port (  i_CLK    : in  std_logic;
		i_Tvalid : in  std_logic;
        i_Tdata  : in  std_logic_vector(7 downto 0);
        o_Tready : out std_logic;
        o_SCK    : out std_logic;
        o_SSn    : out std_logic;
        o_S      : out std_logic);--_vector(11 downto 0));
end spi;

architecture arch_1 of spi is

  component spi_controller
  port ( i_CLK     : in std_logic;
		 i_Tvalid  : in std_logic;
         i_Sel     : in std_logic_vector(3 downto 0);
         o_RE      : out std_logic;
         o_CCLRn   : out std_logic;
         o_CUP     : out std_logic;
         o_SCK     : out std_logic;
         o_Tready  : out std_logic;
         o_SSn     : out std_logic);
  end component;
  
  component register_12bits
  port ( i_CLK  : in std_logic;
		 i_E	: in std_logic;
		 i_D	: in std_logic_vector(11 downto 0);
		 o_S	: out std_logic_vector(11 downto 0));
  end component;
  
  component counter
  port ( i_CLK   : in std_logic;
		 i_CLRn  : in std_logic;
         i_UP    : in std_logic;
		 o_S	 : out std_logic_vector(3 downto 0));
  end component;

  component hamming12_8
  port( i_Msg  : in  std_logic_vector(7 downto 0);
        o_S    : out std_logic_vector(11 downto 0));
  end component;

  component mux12_1
  port( i_Sel  : in  std_logic_vector(3 downto 0);
        i_Msg  : in  std_logic_vector(11 downto 0);
        o_S    : out std_logic);
  end component;

signal w_RE, w_CUP, w_CCLRn : std_logic;
signal w_CS : std_logic_vector(3 downto 0);
signal w_HS, w_RS : std_logic_vector(11 downto 0);

begin

  u_spi_controller : spi_controller port map ( i_CLK    => i_CLK,
                                               i_Tvalid => i_Tvalid,
                                               i_Sel    => w_CS,
                                               o_RE     => w_RE,
                                               o_CCLRn  => w_CCLRn,
                                               o_CUP    => w_CUP,
                                               o_SCK    => o_SCK,
                                               o_Tready => o_Tready,
                                               o_SSn    => o_SSn);
                                                 
  u_register_12bits : register_12bits port map ( i_CLK => i_CLK,
                        					     i_E   => w_RE,
                                                 i_D   => w_HS,
                                                 o_S   => w_RS);
                                                   
  u_counter : counter port map ( i_CLK  => i_CLK,
                                 i_CLRn => w_CCLRn,
                                 i_UP   => w_CUP,
                                 o_S    => w_CS);
 
  u_hamming12_8 : hamming12_8 port map ( i_Msg => i_Tdata,
                        				 o_S   => w_HS);
                                            
  u_mux12_1 : mux12_1 port map ( i_Sel => w_CS,
  						  		 i_Msg => w_RS,
                        		 o_S   => o_S);

end arch_1;
