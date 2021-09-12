-- Project: blink led
-- Author: Renan de Brito Leme
-- Date: 31/08/2021

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity blink_led is
	port(		
		swt0_i : in std_logic;
        swt1_i : in std_logic;
        swt2_i : in std_logic;
        swt3_i : in std_logic;
		led_o  : out std_logic_vector(3 downto 0)
	);
end;

architecture behavioral of blink_led is
	signal led_s : std_logic_vector(3 downto 0) := "1111";

begin

	blink_led : process(all)
	begin
		if swt0_i = '0' then
			led_s(0) <= '0';
		else
			led_s(0) <= '1';
		end if;

        if swt1_i = '0' then
			led_s(1) <= '0';
		else
			led_s(1) <= '1';
		end if;

        if swt2_i = '0' then
			led_s(2) <= '0';
		else
			led_s(2) <= '1';
		end if;

        if swt3_i = '0' then
			led_s(3) <= '0';
		else
			led_s(3) <= '1';
		end if;
	end process;

	led_o <= led_s;

end behavioral;