-- Project: 4 bits full adder
-- Author: Renan de Brito Leme
-- Date: 07/26/2021

library IEEE;
use IEEE.std_logic_1164.all;

entity fulladder_4bits is
	port(
		A, B, Cin : in	std_logic;
		sum, Cout : out std_logic
	);
end fulladder_4bits;

architecture behavioral of fulladder_4bits is
begin
   sum  <= (A xor B) xor Cin;
   Cout <= ((A xor B) and Cin) or (A and B);
end behavioral;