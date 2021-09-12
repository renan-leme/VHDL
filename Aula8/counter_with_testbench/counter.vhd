-- Project: Counter com PLL
-- Author: Renan de Brito Leme
-- Date: 26/08/2021

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

entity counter is
    port (
        clk_i       : in  std_logic;
        rst_i       : in  std_logic;
		stop_i      : in  std_logic;
        led_o_125M  : out std_logic_vector(3 downto 0);
        led_o_100M  : out std_logic_vector(3 downto 0);
        led_o_25M   : out std_logic_vector(3 downto 0);
        led_o_10M   : out std_logic_vector(3 downto 0)
    );
end counter;

architecture rtl of counter is
    
    component count is 
        port(
            clk_i  : in std_logic;
		    rst_i  : in std_logic;
		    stop_i : in std_logic;
            led_o  : out std_logic_vector(3 downto 0)
        );
    end component;

    component counter_pll is
	    PORT(
		    areset : IN  std_logic := '0';
		    inclk0 : IN  std_logic := '0';
		    c0	   : OUT std_logic ;
		    c1	   : OUT std_logic ;
		    c2	   : OUT std_logic ;
		    c3	   : OUT std_logic;
		    locked : OUT std_logic 
	    );
    end component;

    signal areset_sig : std_logic ;
	signal inclk0_sig : std_logic ;
	signal c0_sig     : std_logic ;
	signal c1_sig	  : std_logic ;
    signal c2_sig	  : std_logic ;
	signal c3_sig	  : std_logic ;
	signal locked_sig : std_logic ;

begin

	counter_pll_inst : counter_pll PORT MAP (
		areset => rst_i,
		inclk0 => clk_i,     --50 MHz
		c0	   => c0_sig,    --125 MHz
		c1	   => c1_sig,    --100 MHz
		c2	   => c2_sig,    --25 MHz
		c3	   => c3_sig,    --10 MHz
		locked => locked_sig
	);

    counter_clk_125M : count  port map(
        clk_i  => c0_sig,
		rst_i  => not locked_sig, --The countering just starts when the PLL is locked (rst_i = '0')
		stop_i => stop_i,
        led_o  => led_o_125M
    );

	counter_clk_100M : count port map(
        clk_i  => c1_sig,
		rst_i  => not locked_sig,
		stop_i => stop_i,
        led_o  => led_o_100M
    );
	
	counter_clk_25M : count port map(
        clk_i  => c2_sig,
		rst_i  => not locked_sig,
		stop_i => stop_i,
        led_o  => led_o_25M
    );
	
	counter_clk_10M : count port map(
        clk_i  => c3_sig,
		rst_i  => not locked_sig,
		stop_i => stop_i,
        led_o  => led_o_10M
    );

end rtl;