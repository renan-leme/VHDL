-- Project: Or gate using WHEN...ELSE
-- Author: Renan de Brito Leme
-- Date: 07/25/2021

library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.numeric_std.all;
	use IEEE.std_logic_unsigned.all;

entity or_gate is
	port(
		data_in	 : 	in	std_logic_vector(3 downto 0);
		data_out :	out	std_logic
	);
end or_gate;

architecture behavioral of or_gate is

begin

	data_out <= '0' when data_in = "0000" else
				'1' when data_in = "0001" else
				'1' when data_in = "0010" else
				'1' when data_in = "0011" else
				'1' when data_in = "0100" else
				'1' when data_in = "0101" else
				'1' when data_in = "0110" else
				'1' when data_in = "0111" else
				'1' when data_in = "1000" else
				'1' when data_in = "1001" else
				'1' when data_in = "1010" else
				'1' when data_in = "1011" else
				'1' when data_in = "1100" else
				'1' when data_in = "1101" else
				'1' when data_in = "1110" else
				'1' when data_in = "1111" else
				'Z';

end behavioral;