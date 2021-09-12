-- Project: 4 bits adder/subtractor testbench
-- Author: Renan de Brito Leme
-- Date: 07/26/2021

library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.numeric_std.all;

entity adder_subtractor_4bits_tb is
end adder_subtractor_4bits_tb;

architecture stimulus of adder_subtractor_4bits_tb is
	
	component adder_subtractor_4bits is
		port(
			OP       : in  std_logic;                    --Operation 0 for + and 1 for -
			A, B	 : in  std_logic_vector(3 downto 0); --Inputs operands
			R        : out std_logic_vector(3 downto 0); --Result
			Cout, OV : out std_logic                     --Cout = carry out and OV = overflow
		);
	end component;

	signal OP_tb          : std_logic;
	signal A_tb, B_tb     : std_logic_vector(3 downto 0);
	signal R_tb           : std_logic_vector(3 downto 0);
	signal Cout_tb, OV_tb : std_logic;

begin

	DUT: adder_subtractor_4bits port map(OP => OP_tb, A => A_tb, B => B_tb, R => R_tb, Cout => Cout_tb, OV => OV_tb);

	process
	begin
		OP_tb <= '0';    --Sum operation
		wait for 10 ns;
		
		A_tb  <= "0100"; --4
		B_tb  <= "0011"; --3
		wait for 10 ns;
	
		A_tb  <= "1000"; --8
		B_tb  <= "1000"; --8
		wait for 10 ns;

		OP_tb <= '1';    --Subtraction operation
		wait for 10 ns;
		
		A_tb <= "0100"; --4
		B_tb <= "0011"; --3
		wait for 10 ns;

		A_tb <= "0011"; --3
		B_tb <= "0100"; --4
		wait for 10 ns;
	
		A_tb <= "1000"; --8
		B_tb <= "1000"; --8
		wait for 10 ns;
	
	end process;
   
				
end stimulus;