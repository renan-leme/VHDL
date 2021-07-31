-- Project: 3x8 bits decoder using WHEN...ELSE
-- Author: Renan de Brito Leme
-- Date: 07/26/2021

library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.numeric_std.all;
	use IEEE.std_logic_unsigned.all;

entity decoder3x8 is
	port(
		data_in	 : 	in	std_logic_vector(2 downto 0);
		data_out :	out	std_logic_vector(7 downto 0)
	);
end decoder3x8;

architecture behavioral of decoder3x8 is

begin

	data_out <= "00000001" when data_in = "000" else
				"00000010" when data_in = "001" else
				"00000100" when data_in = "010" else
				"00001000" when data_in = "011" else
				"00010000" when data_in = "100" else
				"00100000" when data_in = "101" else
				"01000000" when data_in = "110" else
				"10000000" when data_in = "111" else
				"ZZZZZZZZ";

end behavioral;