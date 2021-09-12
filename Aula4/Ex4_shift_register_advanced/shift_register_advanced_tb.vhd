-- Project : Advanced shift register testbench 
-- Author  : Renan de Brito Leme
-- Date    : 28/08/2021


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

--declaramos a entidade
entity shift_register_advanced_tb is
end shift_register_advanced_tb;

--a arquitetura
architecture behavioral of shift_register_advanced_tb is

	component shift_register_advanced
		port(
			shift_register_in  : in std_logic;
			parallel_data 	   : in std_logic_vector(1023 downto 0);
			clk                : in std_logic;
			rst                : in std_logic;
			en                 : in std_logic;
			direction          : in std_logic;
			force_input        : in std_logic;
			force_0            : in std_logic;
			force_1            : in std_logic;
			parallel_load      : in std_logic;
			
			shift_register_out : out std_logic;
			parallel_out       : out std_logic_vector(1023 downto 0)
	);
	end component;

	constant clk_period : time := 20 ns;
	
	signal shift_register_in  : std_logic := '0';
	signal parallel_data 	  : std_logic_vector(1023 downto 0) := (others => '1');
	signal clk                : std_logic := '0';
	signal rst                : std_logic := '0';
	signal en                 : std_logic := '1';
	signal direction          : std_logic := '0';
	signal force_input        : std_logic := '0';
	signal force_0            : std_logic := '0';
	signal force_1            : std_logic := '0';
	signal parallel_load      : std_logic := '0';
		
	signal shift_register_out : std_logic := '0';
	signal parallel_out       : std_logic_vector(1023 downto 0):= (others => '0');
	
begin
	DUT : shift_register_advanced 
		port map (
			shift_register_in  => shift_register_in,
			parallel_data      => parallel_data, 
			clk                => clk, 
			rst                => rst,
			en                 => en,
			direction          => direction,
			force_input        => force_input,
			force_0            => force_0,
			force_1            => force_1,
			parallel_load      => parallel_load,
			shift_register_out => shift_register_out, 
			parallel_out       => parallel_out			
		);

	clk <= not clk after clk_period/2;
	rst <= '1', '0' after 10 ns;
	
	stimulus : process
	begin
		-- Start simulation and keeps '0' in shift_register
		parallel_load <= '0';
		wait for (2 * clk_period);
		
		-- Set data from parallel_data to shift_register
		parallel_load <= '1';
		wait for (1 * clk_period);
		
		-- Stop data transmittion from parallel_data to shift_register
		parallel_load <= '0';
		wait for (2 * clk_period);
		
		-- Data output by LSB
		shift_register_in <= '0';
		en <= '1';
		direction <= '0';
		force_0 <= '0';
		force_1 <= '0';
		wait for (1023 * clk_period);
		
		-- Reset data from parallel_data to shift_register
		parallel_load <= '1';
		parallel_data <= (others => '0');
		wait for (10 * clk_period);
		
		-- Reset data from parallel_data to shift_register
		parallel_data <= (others => '1');
		wait for (10 * clk_period);
		
		-- Stop data transmition from parallel_data
		parallel_load <= '0';
		wait for (10 * clk_period);
		
		-- Data output by MSB
		shift_register_in <= '0';
		en <= '1';
		direction <= '1';
		force_0 <= '0';
		force_1 <= '0';
		force_input <= '1';
		wait for (1023 * clk_period);
		
		-- Data output by MSB
		shift_register_in <= '0';
		en <= '1';
		direction <= '0';
		force_0 <= '0';
		force_1 <= '0';
		force_input <= '1';
		wait for (1023 * clk_period);
		
		-- Enables parallel_out
        parallel_load <= '0';
		parallel_data <= (others => '1');
		en <= '0';
		wait for (1023 * clk_period);
		
		-- Disables parallel_out

		parallel_data <= (others => '0');
		wait for (1023 * clk_period);
		
		parallel_load <= '1';
		parallel_data <= (others => '1');
		wait for (1023 * clk_period);
		
		parallel_load <= '0';
		parallel_data <= (others => '1');
		wait for (1023 * clk_period);
		
		en <= '1';
		wait for (10 * clk_period);
		
		-- Data output by MSB
		shift_register_in <= '0';
		en <= '1';
		direction <= '0';
		force_0 <= '0';
		force_1 <= '0';
		force_input <= '1';
		wait for (1023 * clk_period);
		
		wait;

	end process stimulus;  
	
end behavioral;	