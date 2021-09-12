-- Project: Generic single port RAM with bidirectional data bus
-- Author: Renan de Brito Leme
-- Date: 08/03/2021

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
--use ieee.std_logic_arith.all;

entity generic_RAM is
	 generic(
		data_size_g   : integer := 8;
		address_size_g : integer := 8
	 );
    port(
		clk, rst, we_i, oe_i : in    std_logic;
		address_i             : in    std_logic_vector(address_size_g - 1 downto 0);
		data_io               : inout std_logic_vector(data_size_g - 1 downto 0)
    );
end generic_RAM;

architecture behavioral of generic_RAM is
	
	--type ram_t is array (0 to (2**address'length)-1) of std_logic_vector((data'length)-1 downto 0);
	type ram_t is array (7 downto 0) of std_logic_vector(7 downto 0);
	signal ram_s : ram_t := (others => (others => '0'));
	signal data_io_s : std_logic_vector(2 downto 0);

begin

	data_in_p : process(all)
	begin
		--Writing in the RAM memory
		if (rising_edge(clk)) then
			if(we_i = '1') then
				ram_s(to_integer(unsigned(address_i))) <= data_io;
			end if;
		end if;
	end process;

	--Reading from the RAM memory
	data_io <= ram_s(to_integer(unsigned(address_i))) when we_i = '0' and oe_i = '1' else (others => 'Z');

end behavioral;