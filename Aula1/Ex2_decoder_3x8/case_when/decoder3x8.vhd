-- Project: 3x8 bits decoder using CASE...WHEN
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
			case data_in is
				when "000"  => data_out <= "00000001";
				when "001"  => data_out <= "00000010";
				when "010"  => data_out <= "00000100";
				when "011"  => data_out <= "00001000";
				when "100"  => data_out <= "00010000";
				when "101"  => data_out <= "00100000";
				when "110"  => data_out <= "01000000";
				when "111"  => data_out <= "10000000";
				when others => data_out <= "ZZZZZZZZ";
			end case;
		end process;

end behavioral;