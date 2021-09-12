-- Project: 8 bits vector
-- Author: Renan de Brito Leme
-- Date: 08/03/2021

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity vector_8bits is
    Port(
        clk    : in std_logic;
		  output : out std_logic_vector(7 downto 0)		
    );
end vector_8bits;

Architecture behavioral of vector_8bits is
	
	signal counter : integer :=0;

begin
	process(clk)
	--variable counter : integer range 0 to 4;
	begin
			if counter = 0 then
				output <= "ZZZZZZZZ";
			elsif counter = 1 then
				output <= "00000000";
			elsif counter = 2 then
				output <= "10100100";
			end if;
			
			
			if(counter /= 2) then
				counter <= counter + 1;
			else
				counter <= 0;
			end if;
	end process;
end behavioral;