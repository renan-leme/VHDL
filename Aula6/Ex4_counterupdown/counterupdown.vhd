-- Project: UP/DOWN counter
-- Author: Renan de Brito Leme
-- Date: 09/01/2021

LIBRARY IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;

entity counterupdown is
    port(
        clk_i		   : in  std_logic;
		--rst_i		   : in  std_logic; --My board doesn't have 5 buttons, then I decided to not use the rst
		button_count_i : in  std_logic;
		button_load_i  : in  std_logic; 
		selector_ud_i  : in  std_logic;
		--load_dada_i    : in  std_logic_vector(3 downto 0); --My board doesn't have enought buttons to charge data and the DIP swith uses the same wires of the push button
		leds_o         : out std_logic_vector(3 downto 0)
    );
end counterupdown;

architecture behavioral of counterupdown is

	component debounce is
		port(
			ck      : in  std_logic;
			deb_in  : in  std_logic;
			deb_out : out std_logic
		);
	end component;

	component counter_PLL is
		port(
			areset : in  std_logic := '0';
			inclk0 : in  std_logic := '0';
			c0	   : out std_logic;
			locked : out std_logic 
		);
	end component;

	signal temp_s : std_logic_vector(3 downto 0);
	signal button_count_debounced_s : std_logic;
	signal load_data_s : std_logic_vector(3 downto 0) := "1000";

	signal areset_s : std_logic;
	signal inclk0_s : std_logic;
	signal c0_s     : std_logic;
	signal locked_s : std_logic;

begin
	
	inclk0_s <= clk_i;

	process(c0_s)
	begin
		--if rst_i = '0' then           --My board doesn't have 5 buttons, then I decided to not use the rst
			--temp_s <= "0000";
		--elsif rising_edge(clk_i) then
		if rising_edge(c0_s) then
			if button_load_i = '0' then
				temp_s <= load_data_s;
			elsif button_load_i = '1' and selector_ud_i = '1' and button_count_debounced_s = '0' then
				temp_s <= temp_s + 1;
			elsif button_load_i = '1' and selector_ud_i = '0' and button_count_debounced_s = '0' then
				temp_s <= temp_s - 1;
			end if;
		end if;
	end process;

	leds_o <= not temp_s;

	deb_u : debounce port map(
		ck      => c0_s,
		deb_in  => button_count_i,          --bloco de debounce, sentrada
		deb_out => button_count_debounced_s --bloco de debounce, saída
	);

	counter_PLL_inst : counter_PLL port map (
		areset => areset_s,
		inclk0 => inclk0_s,
		c0	   => c0_s,
		locked => locked_s
	);

end behavioral;