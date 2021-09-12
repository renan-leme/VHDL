-- Project: Counter com PLL
-- Author: Renan de Brito Leme
-- Date: 26/08/2021

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

-- Counter
entity count is
    port (
        clk_i  : in std_logic;
		rst_i  : in std_logic;
		stop_i : in std_logic;
        led_o  : out std_logic_vector(3 downto 0)
    );
end count;

architecture behavioral of count is

    signal iCounter : unsigned(28 downto 0);
	
begin
    -- Counter process
    COUNT_SHIFT: process (clk_i)
    begin
		if rst_i = '0' then --The countering just starts when the PLL is locked (rst_i = '0')
			iCounter <= (others => '0');
		elsif rising_edge(clk_i) then
            if stop_i = '1' then 
				iCounter <= iCounter + 1;
            end if;
        end if;
    end process;
	
	led_o <= std_logic_vector(iCounter(iCounter'high downto iCounter'high - 3));
    --led_o <= std_logic_vector(iCounter(3 downto 0));

end behavioral;