-- Project: Or gate using CASE...WHEN
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
	process(data_in) is
	begin
		case data_in is
			when "0000" => data_out <= '0';
			when "0001" => data_out <= '1';
			when "0010" => data_out <= '1';
			when "0011" => data_out <= '1';
			when "0100" => data_out <= '1';
			when "0101" => data_out <= '1';
			when "0110" => data_out <= '1';
			when "0111" => data_out <= '1';
			when "1000" => data_out <= '1';
			when "1001" => data_out <= '1';
			when "1010" => data_out <= '1';
			when "1011" => data_out <= '1';
			when "1100" => data_out <= '1';
			when "1101" => data_out <= '1';
			when "1110" => data_out <= '1';
			when "1111" => data_out <= '1';
			when others => data_out <= 'Z';
		end case;
	end process;

end behavioral;