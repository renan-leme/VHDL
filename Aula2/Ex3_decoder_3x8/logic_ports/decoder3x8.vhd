-- Project: 3x8 bits decoder using LOGIC PORTS
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

	data_out(0) <= not data_in(2) and not data_in(1) and not data_in(0);
	data_out(1) <= not data_in(2) and not data_in(1) and     data_in(0);
	data_out(2) <= not data_in(2) and     data_in(1) and not data_in(0);
	data_out(3) <= not data_in(2) and     data_in(1) and     data_in(0);
	data_out(4) <=     data_in(2) and not data_in(1) and not data_in(0);
	data_out(5) <=     data_in(2) and not data_in(1) and     data_in(0);
	data_out(6) <=     data_in(2) and     data_in(1) and not data_in(0);
	data_out(7) <=     data_in(2) and     data_in(1) and     data_in(0);

end behavioral;