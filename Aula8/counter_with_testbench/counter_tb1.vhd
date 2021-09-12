-- Project: Generic RAM Testbench
-- Author: Renan de Brito Leme
-- Date: 07/31/2021

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
--use ieee.std_logic_arith.all;

entity counter_tb is
end counter_tb;

architecture stimulus of counter_tb is

	-- Component declaration for the Device Under Test (DUT)
	component counter is
		generic(
			add_data_size_g   : integer := 8
		);
		port(
			clk, rst, we_i, oe_i, ale_i : in    std_logic;
			add_data_io                 : inout std_logic_vector(add_data_size_g - 1 downto 0)
		);
	end component;

	-- Inputs signals for testbench
	signal clk, rst, we_i, oe_i, ale_i : std_logic;

	-- Inputs/Output signal for testbench
	signal add_data_io                 : std_logic_vector(7 downto 0);

	-- Clock period
	constant clk_period                : time := 2 ns;
	
begin 
    -- Instantiate the Device Under Test (DUT)
	DUT : generic_RAM port map(
		clk         => clk,
		rst         => rst,
		oe_i        => oe_i,
		we_i        => we_i,
		ale_i       => ale_i,
        add_data_io => add_data_io
    );
 
   -- Clock process definitions
   clk_p : process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
   
   rst <= '1', '0' after 4*clk_period;

    -- Stimulate Control process
   process
   begin
		--Initialize the signals and wait until the reset goes to '0'
		add_data_io <= (others=>'Z');
		oe_i <= '0';
		we_i <= '0';
		ale_i <= '0';
		wait until rst = '0';

	    --Wait the rising edge clk to sincronize the result with the clk
		wait until rising_edge(clk);
		
		--Writening in the address 3 -- data = A4 (10100100)
		--address_i <= (2 downto 0 => "011", (others=>'0'));
		ale_i <= '1';
		add_data_io <= "00000011";
		wait until rising_edge(clk);
		ale_i <= '0';
		we_i  <= '1';
		add_data_io <= x"A4";
		wait until rising_edge(clk);

		--Writening in the address 4 -- data = A5 (10100100)
		--address_i <= (2 downto 0 => "011", (others=>'0'));
		ale_i <= '1';
		add_data_io <= "00000100";
		wait until rising_edge(clk);
		ale_i <= '0';
		we_i  <= '1';
		add_data_io <= x"A5";
		wait until rising_edge(clk);

		--Cleaning all of control signals
		oe_i  <= '0';
		we_i  <= '0';
		ale_i <= '0';
		add_data_io <= (others=>'Z');
		wait until rising_edge(clk);

		--Reading the address 3
		--address_i <= (2 downto 0 => "011", others=>'0');
		ale_i <= '1';
		add_data_io <= "00000011";
		oe_i  <= '1';
		add_data_io <= (others=>'Z');
		wait until rising_edge(clk);
		
		--Reading the address 4
		--address_i <= (2 downto 0 => "100", others=>'0');
		ale_i <= '1';
		add_data_io <= "00000100";
		oe_i  <= '1';
		add_data_io <= (others=>'Z');
		wait until rising_edge(clk);
		
		wait;
   end process;
end stimulus;