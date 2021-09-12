-- Project: 3x8 bits decoder testebench using LOGIC PORTS
-- Author: Renan de Brito Leme
-- Date: 07/26/2021

library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.numeric_std.all;

entity decoder3x8_tb is
end decoder3x8_tb;

architecture stimulus of decoder3x8_tb is
	
	component decoder3x8 is
		port(
			data_in	 : 	in	std_logic_vector(2 downto 0);
			data_out :	out	std_logic_vector(7 downto 0)
		);
	end component;

	signal data_in_tb  : std_logic_vector(2 downto 0);
	signal data_out_tb : std_logic_vector(7 downto 0);

begin

	DUT: decoder3x8 port map(data_in => data_in_tb, data_out => data_out_tb);

	data_in_tb <= "000",
				  "001" after 5  ns,
				  "010" after 10 ns, 
				  "011" after 15 ns,
				  "100" after 20 ns,
				  "101" after 25 ns,
				  "110" after 30 ns,
				  "111" after 35 ns;
				
end stimulus;