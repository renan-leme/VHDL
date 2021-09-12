-- Project: Or gate testbench using CASE...WHEN
-- Author: Renan de Brito Leme
-- Date: 07/25/2021

library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.numeric_std.all;

entity or_gate_tb is
end or_gate_tb;

architecture stimulus of or_gate_tb is
	
	component or_gate is
		port(
			data_in	 : 	in	std_logic_vector(3 downto 0);
			data_out :	out	std_logic
		);
	end component;

	signal data_in_tb  : std_logic_vector(3 downto 0);
	signal data_out_tb : std_logic;

begin

	DUT: or_gate port map(data_in => data_in_tb, data_out => data_out_tb);

	data_in_tb <= "0000",
				  "0001" after 5  ns,
				  "0010" after 10 ns, 
				  "0011" after 15 ns,
				  "0100" after 20 ns,
				  "0101" after 25 ns,
				  "0110" after 30 ns,
				  "0111" after 35 ns,
				  "1000" after 40 ns,
				  "1001" after 45 ns,
				  "1010" after 50 ns,
				  "1011" after 55 ns,
				  "1100" after 60 ns,
				  "1101" after 65 ns,
				  "1110" after 70 ns,
				  "1111" after 75 ns;
				
end stimulus;