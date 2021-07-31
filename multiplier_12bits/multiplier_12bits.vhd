-- Project: 12 bits multiplier
-- Author: Renan de Brito Leme
-- Date: 07/27/2021

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity multiplier_12bits is
    port 
	(
		A : in  signed(11 downto 0);
		B : in  signed(11 downto 0);
		R : out signed(23 downto 0)
	);

end multiplier_12bits;

architecture behavioral of multiplier_12bits is
begin
	R <= A * B;
end behavioral;