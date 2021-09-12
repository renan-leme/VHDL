-- Project: Shift Register testebench using WHILE...LOOP
-- Author: Renan de Brito Leme
-- Date: 03/08/2021

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;


entity shift_register_tb is
end shift_register_tb;

architecture stimulus of shift_register_tb is

    component shift_register is
        generic(N : integer := 4);
        port(
            d, clk, rst, en, set : in  std_logic;                    
            q                    : out std_logic_vector(N-1 downto 0)
        );
    end component;
	
	 -- Inputs signals for testbench
    signal d_tb, clk_tb, rst_tb : std_logic := '0';
	 signal en_tb, set_tb        : std_logic := '0';
	 
	 -- Output signal for testbench
    signal q_tb                 : std_logic_vector(3 downto 0);
	 
    -- Clock period
    constant clk_period_tb      : time := 10 ns;

begin
    -- Instantiate the Device Under Test (DUT)
    DUT : shift_register 
		port map(
			d   => d_tb, 
			clk => clk_tb, 
			rst => rst_tb, 
			en  => en_tb, 
			set => set_tb, 
			q   => q_tb
		);
    
    
    --clk_tb <= not clk_tb after 10 ns;
    clk_process :process
    begin
		clk_tb <= '0';
      wait for clk_period_tb/2;
      clk_tb <= '1';
      wait for clk_period_tb/2;
    end process;
	
	 -- Stimulate Control process
	stm_process : process
   begin
		en_tb  <= '1';
		rst_tb <= '1';
		wait for clk_period_tb;
		
		rst_tb <= '0';
		wait for clk_period_tb;
		
		for i in 0 to 5 loop
			d_tb <= not d_tb;
			wait for clk_period_tb;
		end loop;
		
		set_tb <= '1';
		wait for clk_period_tb;
		
		set_tb <= '0';
		rst_tb <= '1';
		wait for clk_period_tb;
		
		rst_tb <= '0';
		wait;
    end process;
     
end stimulus;