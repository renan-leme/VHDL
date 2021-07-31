-- Project: 4 bits adder/subtractor
-- Author: Renan de Brito Leme
-- Date: 07/26/2021

library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.numeric_std.all;
	use IEEE.std_logic_unsigned.all;

entity adder_subtractor_4bits is
	port(
		OP       : in  std_logic;                    --Operation 0 for + and 1 for -
		A, B	 : in  std_logic_vector(3 downto 0); --Inputs operands
		R        : out std_logic_vector(3 downto 0); --Result
		Cout, OV : out std_logic                     --Cout = carry out and OV = overflow
	);
end adder_subtractor_4bits;

architecture behavioral of adder_subtractor_4bits is
	
	component fulladder_4bits is
		port(
			A, B, Cin : in	std_logic;
			sum, Cout : out std_logic
		);
	end component;
	
	signal C0, C1, C2, C3         : std_logic; --Full adder carries
	signal AUX0, AUX1, AUX2, AUX3 : std_logic; --For xor operation between B and OP
	   
begin
	FA0 : fulladder_4bits port map(A => A(0), B => AUX0, Cin => OP, sum => R(0), Cout => C0); -- Result 0
	FA1 : fulladder_4bits port map(A => A(1), B => AUX1, Cin => C0, sum => R(1), Cout => C1); -- Result 1
	FA2 : fulladder_4bits port map(A => A(2), B => AUX2, Cin => C1, sum => R(2), Cout => C2); -- Result 2
	FA3 : fulladder_4bits port map(A => A(3), B => AUX3, Cin => C2, sum => R(3), Cout => C3); -- Result 3


	AUX0  <= B(0) xor OP;
	AUX1  <= B(1) xor OP;
	AUX2  <= B(2) xor OP;
	AUX3  <= B(3) xor OP;
	Cout  <= C3;
	OV    <= C2 XOR C3;
	  
end behavioral;