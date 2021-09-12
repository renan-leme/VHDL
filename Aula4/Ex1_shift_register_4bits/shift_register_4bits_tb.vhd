-- Project: Shift register 4 bits testbench
-- Author: Renan de Brito Leme
-- Date: 08/03/2021

library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.numeric_std.all;

--declaramos a entidade
entity shift_register_4bits_tb is
end shift_register_4bits_tb;

--a arquitetura
architecture behavioral of shift_register_4bits_tb is

	component shift_register_4bits is
	generic(
		data_size   : integer := 4 
	);
	Port(
		clk         : in  std_logic;
		rst         : in  std_logic;			
		data_input  : in  std_logic;
		data_output : out std_logic_vector(data_size-1 downto 0)
	);
	end component;
	
	-- Inputs signals for testbench
	signal clk_tb, rst_tb, data_input_tb : std_logic := '0';
	
	-- Output signal for testbench
	signal data_output_tb                : std_logic_vector(3 downto 0);
	
	-- Clock period
	constant clk_period                  : time := 10 ns;

begin
	-- Instantiate the Device Under Test (DUT)
	DUT : shift_register_4bits
		port map(
			clk         => clk_tb,
			rst         => rst_tb,
			data_input  => data_input_tb,
			data_output => data_output_tb
		);
		
		-- Clock process definitions
   clk_process : process
   begin
		clk_tb <= '0';
		wait for clk_period/2;
		clk_tb <= '1';
		wait for clk_period/2;
   end process;
	
	-- Stimulate Control process
	stm_process : process
   begin
		rst_tb <= '1';
		wait for clk_period;
		rst_tb <= '0';
		wait for clk_period;
		
		for i in 0 to 5 loop
			data_input_tb <= not data_input_tb;
			wait for clk_period;
		end loop;
		wait;
		
    end process;

end behavioral;				
		
