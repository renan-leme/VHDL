-- Project: 12 bits multiplier testbench
-- Author: Renan de Brito Leme
-- Date: 07/27/2021

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity multiplier_12bits_tb is
end multiplier_12bits_tb;

architecture behavioral of multiplier_12bits_tb is
    
    component multiplier_12bits is
        port 
        (
            A : in  signed(11 downto 0);
	    B : in  signed(11 downto 0);
	    R : out signed(23 downto 0)
        );
    end component;

	signal A_tb, B_tb : signed(11 downto 0);
	signal R_tb       : signed(23 downto 0);

begin

    DUT: multiplier_12bits port map(A => A_tb, B => B_tb, R => R_tb);

    process
	begin		
		A_tb  <= "000000000000"; --0
		B_tb  <= "000000000001"; --1
		wait for 10 ns;

        A_tb  <= "000000000010"; --2
		B_tb  <= "000000000011"; --3
		wait for 10 ns;
	
		A_tb  <= "111111111111"; --4095
		B_tb  <= "111111111111"; --4095
		wait for 10 ns;
	end process;

end behavioral;