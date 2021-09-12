-- Project: Or gate using WITH...SELECT
-- Author: Renan de Brito Leme
-- Date: 07/25/2021

library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.numeric_std.all;

entity or_gate is
	port(
		data_in	 : 	in	std_logic_vector(3 downto 0);
		data_out :	out	std_logic
	);
end or_gate;

architecture behavioral of or_gate is

begin

			with data_in select
				data_out <= '0' when "0000",
					    '1' when "0001",
					    '1' when "0010",
				            '1' when "0011",
				            '1' when "0100",
				            '1' when "0101",
				            '1' when "0110",
				            '1' when "0111",
				            '1' when "1000",
				            '1' when "1001",
				            '1' when "1010",
				            '1' when "1011",
				            '1' when "1100",
				            '1' when "1101",
				            '1' when "1110",
				            '1' when "1111",
				            'Z' when others;

end behavioral;