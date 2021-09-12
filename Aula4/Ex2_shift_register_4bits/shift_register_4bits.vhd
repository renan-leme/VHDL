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
		clk           : in std_logic;
		rst           : in std_logic;	
		en            : in std_logic;	
		data_input    : in std_logic;
		data_output_a :out std_logic_vector(data_size-1 downto 0);
		data_output_b :out std_logic_vector(data_size-1 downto 0);
		data_output_c :out std_logic_vector(data_size-1 downto 0)
	);
			
end shift_register_4bits;

--arquitetura
Architecture behavioral of shift_register_4bits is

-- Output signals 
signal q_a : std_logic_vector(data_size-1 downto 0);
signal q_b : std_logic_vector(data_size-1 downto 0);
signal q_c : std_logic_vector(data_size-1 downto 0);

begin
	process(clk, rst)
		begin
			if rst = '1' then
				q_a <= (others=>'0');
				q_b <= (others=>'0');
				q_c <= (others=>'0');
			elsif rising_edge(clk) then
				if en = '1' then
					--Format 1 for transfering data between flip-flops
					q_a(0) <= data_input;
					q_a(3 downto 1) <= q_a(2 downto 0);
					
					--Format 2 for transfering data between flip-flops
					q_b(0) <= data_input;
					q_b(q_b'high downto 1) <= q_b(q_b'high-1 downto 0);
					
					--Format 3 for transfering data between flip-flops
					q_c <= q_c(q_c'high-1 downto 0) & data_input;
				end if;
			end if;
	end process;
	
	-- Outputs
	data_output_a <= q_a;
	data_output_b <= q_b;
	data_output_c <= q_c;

end behavioral;