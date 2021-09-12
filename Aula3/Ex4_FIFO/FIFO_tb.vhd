-- Project : FIFO testbench adapted from https://www.nandland.com/vhdl/modules/module-fifo-regs-with-flags.html
-- Author  : Renan de Brito Leme
-- Date    : 10/08/2021

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
 
entity FIFO_tb is
end FIFO_tb;
 
architecture stimulus of FIFO_tb is
 
  constant c_WIDTH    : integer := 8;
  constant c_DEPTH    : integer := 4;
  constant c_AF_LEVEL : integer := 2;
  constant c_AE_LEVEL : integer := 2;
 
  signal r_RESET   : std_logic := '0';
  signal r_CLOCK   : std_logic := '0';
  signal r_WR_EN   : std_logic := '0';
  signal r_WR_DATA : std_logic_vector(c_WIDTH-1 downto 0) := X"A5";
  signal w_AF      : std_logic;
  signal w_FULL    : std_logic;
  signal r_RD_EN   : std_logic := '0';
  signal w_RD_DATA : std_logic_vector(c_WIDTH-1 downto 0);
  signal w_AE      : std_logic;
  signal w_EMPTY   : std_logic;
   
  component FIFO is
    generic (
      g_WIDTH    : natural := 8;
      g_DEPTH    : integer := 32;
      g_AF_LEVEL : integer := 28;
      g_AE_LEVEL : integer := 4
      );
    port (
      i_rst_sync : in std_logic;
      i_clk      : in std_logic;
 
      -- FIFO Write Interface
      i_wr_en   : in  std_logic;
      i_wr_data : in  std_logic_vector(g_WIDTH-1 downto 0);
      o_af      : out std_logic;
      o_full    : out std_logic;
 
      -- FIFO Read Interface
      i_rd_en   : in  std_logic;
      o_rd_data : out std_logic_vector(g_WIDTH-1 downto 0);
      o_ae      : out std_logic;
      o_empty   : out std_logic
      );
  end component FIFO;
 
   
begin
 
  fifo_map : FIFO
    generic map (
      g_WIDTH    => c_WIDTH,
      g_DEPTH    => c_DEPTH,
      g_AF_LEVEL => c_AF_LEVEL,
      g_AE_LEVEL => c_AE_LEVEL
      )
    port map (
      i_rst_sync => r_RESET,
      i_clk      => r_CLOCK,
      i_wr_en    => r_WR_EN,
      i_wr_data  => r_WR_DATA,
      o_af       => w_AF,
      o_full     => w_FULL,
      i_rd_en    => r_RD_EN,
      o_rd_data  => w_RD_DATA,
      o_ae       => w_AE,
      o_empty    => w_EMPTY
      );
 
  r_CLOCK <= not r_CLOCK after 5 ns; --5 ns clock generation
 
  p_TEST : process is
  begin
    wait until r_CLOCK = '1';
    r_WR_EN <= '1';           r_WR_DATA <= r_WR_DATA + x"01";
    wait until r_CLOCK = '1'; r_WR_DATA <= r_WR_DATA + x"01";
    wait until r_CLOCK = '1'; r_WR_DATA <= r_WR_DATA + x"01";
    wait until r_CLOCK = '1'; r_WR_DATA <= r_WR_DATA + x"01";
    wait until r_CLOCK = '1';
    r_WR_EN <= '0';
    r_RD_EN <= '1';           
    wait until r_CLOCK = '1';
    wait until r_CLOCK = '1';
    wait until r_CLOCK = '1';
    wait until r_CLOCK = '1';
    r_RD_EN <= '0';
    r_WR_EN <= '1';           r_WR_DATA <= x"B5";
    wait until r_CLOCK = '1'; r_WR_DATA <= r_WR_DATA + x"01";
    wait until r_CLOCK = '1'; r_WR_DATA <= r_WR_DATA + x"01";
    r_RD_EN <= '1';
    wait until r_CLOCK = '1';
    wait until r_CLOCK = '1';
    wait until r_CLOCK = '1';
    wait until r_CLOCK = '1';
    wait until r_CLOCK = '1';
    wait until r_CLOCK = '1';
    wait until r_CLOCK = '1';
    wait until r_CLOCK = '1';
    r_WR_EN <= '0';
    wait until r_CLOCK = '1';
    wait until r_CLOCK = '1';
    wait until r_CLOCK = '1';
    wait until r_CLOCK = '1';
 
  end process;
   
end stimulus;