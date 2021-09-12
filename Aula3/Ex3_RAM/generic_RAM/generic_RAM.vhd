-- Project: Generic RAM
-- Author: Renan de Brito Leme
-- Date: 07/31/2021

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity generic_RAM is
	 generic(
		data_size_g   : integer := 8;
		adress_size_g : integer := 8
	 );
	 
    port(
		clk, rst, we_i, oe_i : in  std_logic;
		address_i            : in  std_logic_vector(adress_size_g - 1 downto 0);
		data_input           : in  std_logic_vector(data_size_g - 1 downto 0);
		data_output          : out std_logic_vector(data_size_g - 1 downto 0)
    );
end generic_RAM;

architecture behavioral of generic_RAM is
    
    type ram_t is array (adress_size_g downto 0) of std_logic_vector(adress_size_g-1 downto 0);
    signal ram_s : ram_t := (others => (others => '0'));

begin

		 write_p: process(all)
		 begin
			--Writing in the RAM memory
			if rising_edge(clk) then
					if we_i = '1' then -- write memory
						ram_s(to_integer(unsigned(address_i))) <= data_input;
					end if;
			end if;
		 end process;

		 --Reading from the RAM memory 
		 data_output <= ram_s(to_integer(unsigned(address_i))) when we_i = '0' and oe_i = '1' else (others => 'Z');

end behavioral;