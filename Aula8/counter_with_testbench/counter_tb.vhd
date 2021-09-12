-- Project: Testbench counter com PLL
-- Author: Renan de Brito Leme
-- Date: 26/08/2021

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity counter_tb is
end counter_tb;

architecture stimulus of counter_tb is
	component counter is
        port (
            clk_i       : in  std_logic;
            rst_i       : in  std_logic;
            stop_i      : in  std_logic;
            led_o_125M  : out std_logic_vector(3 downto 0);
            led_o_100M  : out std_logic_vector(3 downto 0);
            led_o_25M   : out std_logic_vector(3 downto 0);
            led_o_10M   : out std_logic_vector(3 downto 0)
        );
    end component;

	signal clk_s 		: std_logic := '0';
	signal stop_s       : std_logic := '0';
	signal rst_s		: std_logic := '1';
	signal counter_s    : integer range 0 to 125000001 := 0; 
	signal led_o_125M_s : std_logic_vector(3 downto 0);
	signal led_o_100M_s : std_logic_vector(3 downto 0);
	signal led_o_25M_s  : std_logic_vector(3 downto 0);
	signal led_o_10M_s  : std_logic_vector(3 downto 0);

begin

    DUT : counter port map(
		clk_i  	   => clk_s,
		rst_i      => rst_s,
		stop_i     => stop_s,
		led_o_125M => led_o_125M_s,
		led_o_100M => led_o_100M_s,
		led_o_25M  => led_o_25M_s,
		led_o_10M  => led_o_10M_s	
	);
	
	clk_process: process
	begin
		clk_s <= '0';
		wait for 10 ns;
		clk_s <= '1';
		wait for 10 ns;		
	end process;
	
	rst_s <= '0';
	
	process(clk_s)
	begin
		if rising_edge(clk_s) then 
			if counter_s > 125000000 then
				counter_s <= 0;
			else
				counter_s <= counter_s + 1;
			end if;
		end if;
	end process;

end stimulus;