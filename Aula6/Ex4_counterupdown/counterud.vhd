-- Project: UP/DOWN counter
-- Author: Renan de Brito Leme
-- Date: 09/01/2021

LIBRARY IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;

entity counterud is
    port(
        clk_i		   : in  std_logic;
		--rst_i		   : in  std_logic; --My board doesn't have 5 buttons, then I decided to not use the rst
		button_count_i : in  std_logic;
		button_load_i  : in  std_logic; 
		selector_ud_i  : in  std_logic;
		--load_dada_i    : in  std_logic_vector(3 downto 0); --My board doesn't have enought buttons to charge data and the DIP swith uses the same wires of the push button
		leds_o         : out std_logic_vector(3 downto 0)
    );
end counterud;

architecture behavioral of counterud is

	component counterupdown is
        port(
            clk_i		   : in std_logic;
            --rst_i		   : in std_logic; --My board doesn't have 5 buttons, then I decided to not use the rst
            button_count_i : in std_logic;
            button_load_i  : in std_logic; 
            selector_ud_i  : in std_logic;
            --load_dada_i    : in std_logic_vector(3 downto 0); --My board doesn't have enought buttons to charge data and the DIP swith uses the same wires of the push button
            leds_o         : out std_logic_vector(3 downto 0)
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

    signal areset_s : std_logic;
	signal inclk0_s : std_logic;
	signal c0_s     : std_logic;
	signal locked_s : std_logic;

begin
	
    counter_PLL_inst : counter_PLL port map (
		areset => areset_s,
		inclk0 => inclk0_s,
		c0	   => c0_s,
		locked => locked_s
	);

    cud_inst : counterupdown port map(
		clk_i		   => c0_s,
      --rst_i		   => areset_s, --My board doesn't have 5 buttons, then I decided to not use the rst
        button_count_i => button_count_i,
        button_load_i  => button_load_i, 
        selector_ud_i  => selector_ud_i,
      --load_dada_i    => load_dada_i, --My board doesn't have enought buttons to charge data and the DIP swith uses the same wires of the push button
        leds_o         => leds_o
	);

end behavioral;