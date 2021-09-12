-- Project: 8 bits vector testbench
-- Author: Renan de Brito Leme
-- Date: 08/03/2021

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity vector_8bits_tb is
end vector_8bits_tb;

Architecture stimulus of vector_8bits_tb is

	component vector_8bits is
		Port(
			clk    : in std_logic;
			output : out std_logic_vector(7 downto 0)		
		);
	 end component;
	 
	  -- Inputs signals for testbench
    signal clk_tb          : std_logic := '0';
	 
	 -- Output signal for testbench
	 signal output_tb       : std_logic_vector(7 downto 0);
	 
    -- Clock period
    constant clk_period_tb : time := 20 ns;

begin
	-- Instantiate the Device Under Test (DUT)
    DUT : vector_8bits 
		port map(
			clk    => clk_tb, 
			output => output_tb
		);
		
	--clk_tb <= not clk_tb after 10 ns;
    clk_process :process
    begin
		clk_tb <= '0';
      wait for clk_period_tb/2;
      clk_tb <= '1';
      wait for clk_period_tb/2;
    end process;
	 
end stimulus;