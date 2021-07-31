-- Project: 3x8 bits decoder using IF...ELSE
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

	process(data_in) is
		begin
			if (data_in = "000") then 
				data_out <= "00000001";
			elsif (data_in = "001") then
				data_out <= "00000010";
			elsif (data_in = "010") then
				data_out <= "00000100";
			elsif (data_in = "011") then
				data_out <= "00001000";
			elsif (data_in = "100") then
				data_out <= "00010000";
			elsif (data_in = "101") then
				data_out <= "00100000";
			elsif (data_in = "110") then
				data_out <= "01000000";
			elsif (data_in = "111") then
				data_out <= "10000000";
			else
				data_out <= "ZZZZZZZZ";
			end if;
	end process;

end behavioral;