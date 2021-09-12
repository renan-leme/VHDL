-- Project: Shift Register using FOR...LOOP
-- Author: Renan de Brito Leme
-- Date: 07/27/2021

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;


entity shift_register_tb is
end shift_register_tb;

-- Architecture declaration
architecture stimulus of shift_register_tb is

    component shift_register is
        generic(N : integer := 4);
        port(
            d, clk, rst, en, set : in  std_logic;                    
            q                    : out std_logic_vector(N-1 downto 0)
        );
    end component;

    signal d_tb, clk_tb, rst_tb, en_tb, set_tb : std_logic;                    
    signal q_tb                                : std_logic_vector(3 downto 0);
    --signal q_temp : std_logic_vector(3 downto 0) := (others => '0');
    constant clk_period_tb : time := 10 ns;

begin
    
    DUT : shift_register port map(d => d_tb, clk => clk_tb, rst => rst_tb, en => en_tb, set => set_tb, q => q_tb);
    
    
    --clk_tb <= not clk_tb after 10 ns;
    clk_process :process
    begin
    	clk_tb <= '0';
        wait for clk_period_tb/2;  --for 0.5 ns signal is '0'.
        clk_tb <= '1';
        wait for clk_period_tb/2;  --for next 0.5 ns signal is '1'.
    end process;
	
    d_tb    <= '1', '0' after 5 ns, '1' after 15 ns, '0' after 25 ns, '1' after 75 ns;
    en_tb   <= '1', '0' after 25 ns, '1' after 30 ns;
    d_tb    <= '1', '0' after 35 ns, '1' after 40 ns, '0' after 45 ns;
    rst_tb  <= '0', '1' after 50 ns, '0' after 65 ns;
    set_tb  <= '0', '1' after 55 ns, '0' after 60 ns;
     
end stimulus;