-- Project: State machine home gate control testbench
-- Author: Renan de Brito Leme
-- Date: 09/08/2021

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--use IEEE.numeric_std.all;

--declaramos a entidade
entity sm_home_gate_control_tb is
end sm_home_gate_control_tb;

--a arquitetura
architecture stimulus of sm_home_gate_control_tb is

    component sm_home_gate_control is
        port(
            clk_i	        : in  std_logic; -- Clock
            rst_i           : in  std_logic; -- Button to reset the state machine
            to_open_i       : in  std_logic; -- Button to open the gate
            to_close_i      : in  std_logic; -- Button to close the gate
            sensor_closed_i : in  std_logic; -- Sensor to inform that the gate is closed
            sensor_opened_i : in  std_logic; -- Sensor to inform that the gate is opened
            relays_o        : out std_logic_vector(1 downto 0) -- bit '1' => closing the gate / bit '0' => opening the gate 
        );
    end component;

    component sm_home_gate_control_pll is
		port(
			areset : in  std_logic := '0';
			inclk0 : in  std_logic := '0';
			c0	   : out std_logic;
			locked : out std_logic 
		);
	end component;

    --State Machine Signals
	signal clk_s           : std_logic;
	signal rst_s           : std_logic;
	signal to_open_s       : std_logic;
	signal to_close_s      : std_logic;
	signal sensor_closed_s : std_logic;
	signal sensor_opened_s : std_logic;
	signal relays_s        : std_logic_vector(1 downto 0);

    -- PLL Signals
    signal areset_s : std_logic := '0';
	signal inclk0_s : std_logic;
	signal c0_s     : std_logic;
	signal locked_s : std_logic;

	-- Clock period
	constant clk_period : time := 2 ns;

begin
    inclk0_s <= clk_s;
    -- Stimulate Control process
    process
    begin
		--Initialize the signals and wait until the reset goes to '1'
        rst_s           <= '0';
        to_open_s       <= '1';
        to_close_s      <= '1';
        sensor_closed_s <= '1';
        sensor_opened_s <= '0';
        rst_s <= '0', '1' after clk_period;
        wait until rst_s <= '1';

	    --Wait the rising edge clk to sincronize the result with the clk
		wait until rising_edge(clk_s);
        wait until rising_edge(clk_s);
        wait until rising_edge(clk_s);
        wait until rising_edge(clk_s);
        wait until rising_edge(clk_s);
        wait until rising_edge(clk_s);
        wait until rising_edge(clk_s);
        wait until rising_edge(clk_s);
        wait until rising_edge(clk_s);
        wait until rising_edge(clk_s);
        wait until rising_edge(clk_s);
        wait until rising_edge(clk_s);

        --The gate is opened because the rst_s is initialized in '0'
        to_close_s <= '0';             --Comand to close the gate
        wait until rising_edge(clk_s);
        to_close_s <= '1';
        sensor_opened_s <= '1';        --Sensor that alert the gate is opening or is opened
        wait until rising_edge(clk_s);
        wait until rising_edge(clk_s);
        sensor_closed_s <= '0';        --Sensor that alert the gate is closed
        wait until rising_edge(clk_s);
        wait until rising_edge(clk_s); 
        
        --The gate is closed
        to_open_s <= '0';             --Comand to open the gate
        wait until rising_edge(clk_s);
        to_open_s <= '1';
        sensor_closed_s <= '1';
        wait until rising_edge(clk_s);
        wait until rising_edge(clk_s);
        sensor_opened_s <= '0';
        wait until rising_edge(clk_s);
        wait until rising_edge(clk_s);
    
		wait;

    end process;

    -- Clock process definitions
	clk_p : process
	begin
		clk_s <= '0';
		wait for clk_period/2;
		clk_s <= '1';
		wait for clk_period/2;
	end process;

   -- Instantiate the Device Under Test (DUT)
	DUT1 : sm_home_gate_control port map(
		clk_i	        => clk_s,
        rst_i           => rst_s,
        to_open_i       => to_open_s,
        to_close_i      => to_close_s,
        sensor_closed_i => sensor_closed_s,
        sensor_opened_i => sensor_opened_s,
        relays_o        => relays_s
	);

    DUT2 : sm_home_gate_control_pll port map(
		areset => areset_s,
		inclk0 => inclk0_s, --PLL input 50 MHz
		c0	   => c0_s,     --PLL output 50 MHz
		locked => locked_s
	);

end stimulus;				