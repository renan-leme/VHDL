-- Project: Shift register 4 bits
-- Author: Renan de Brito Leme
-- Date: 08/03/2021

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity shift_register_4bits is
	generic(
		data_size   : integer := 4 
	);
	Port(
		clk         : in  std_logic;
		rst         : in  std_logic;			
		data_input  : in  std_logic;
		data_output : out std_logic_vector(data_size-1 downto 0)
	);
end shift_register_4bits;

Architecture behavioral of shift_register_4bits is

signal q: std_logic_vector(3 downto 0);

begin
	process(clk, rst)
	begin
		if rst = '1' then
			q <= "0000";
		elsif rising_edge(clk) then
			q(0) <= data_input;
			q(1) <= q(0);
			q(2) <= q(1);
			q(3) <= q(2);
		end if;
	end process;
	
	data_output <= q;

end behavioral;