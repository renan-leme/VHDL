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
        led_o_10M   : out std_logic_vector(3 downto 0)
    );
end counter;

architecture beravioral of counter is
    
    component counter_pll is
	    PORT(
		    areset : in  std_logic := '0';
		    inclk0 : in  std_logic := '0';
		    c0	   : out std_logic ;
		    locked : out std_logic 
	    );
    end component;

    signal iCounter : unsigned(28 downto 0);

    signal areset_s : std_logic ;
	signal inclk0_s : std_logic ;
	signal c0_s     : std_logic ;
	signal locked_s : std_logic ;

begin

    inclk0_s <= clk_i;
	
    -- Counter process
    COUNT_SHIFT: process (inclk0_s)
    begin
        if (rising_edge(inclk0_s)) then           
            if stop_i = '0' then else                           
                iCounter <= iCounter + 1;
            end if;
        end if;    
    end process;

	led_o_10M <= not(std_logic_vector(iCounter(iCounter'high downto iCounter'high - 3)));

	counter_pll_inst : counter_pll port map(
		areset => rst_i,   -- Reset the PLL
		inclk0 => clk_i,   --50 MHz
		c0	   => c0_s,    --100 MHz
		locked => locked_s
	);

end beravioral;