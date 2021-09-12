-- Project: UP/DOWN counter
-- Author: Renan de Brito Leme
-- Date: 09/05/2021

LIBRARY IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity sm_home_gate_control is
    port(
        clk_i	        : in  std_logic; -- Clock
		rst_i           : in  std_logic; -- Button to reset the state machine
        to_open_i       : in  std_logic; -- Button to open the gate
        to_close_i      : in  std_logic; -- Button to close the gate
		sensor_closed_i : in  std_logic; -- Sensor to inform that the gate is closed
        sensor_opened_i : in  std_logic; -- Sensor to inform that the gate is opened
        relays_o        : out std_logic_vector(1 downto 0) -- bit '1' => closing the gate / bit '0' => opening the gate 
    );
end sm_home_gate_control;

architecture behavioral of sm_home_gate_control is

    component sm_home_gate_control_pll is
		port(
			areset : in  std_logic := '0';
			inclk0 : in  std_logic := '0';
			c0	   : out std_logic;
			locked : out std_logic 
		);
	end component;

    --State machine declaration
    type states_t is (
        closing,
        closed,
        opening,
        opened
    );
    
    --State Machine signal
    signal mq_estados_s : states_t := opened;
    
    -- PLL Signals
    signal areset_s : std_logic := '0';
	signal inclk0_s : std_logic;
	signal c0_s     : std_logic;
	signal locked_s : std_logic;

begin
    inclk0_s <= clk_i;
    process(rst_i, c0_s)
    begin
        if rst_i = '0' then
            mq_estados_s <= opened;
        elsif rising_edge(c0_s) then
            case mq_estados_s is
                when opened =>
                    if to_close_i = '0' then
                        mq_estados_s <= closing;
                    elsif sensor_closed_i = '0' then 
                        mq_estados_S <= closed;
                    end if;
                when opening =>
                    if to_close_i = '0' then
                        mq_estados_s <= closing;
                    elsif sensor_opened_i = '0' then
                        mq_estados_S <= opened;
                    end if;
                when closed =>
                    if to_open_i = '0' then
                        mq_estados_s <= opening;
                    elsif sensor_opened_i = '0' then 
                        mq_estados_s <= opened;
                    end if;
                when closing =>
                    if to_open_i = '0' then
                        mq_estados_S <= opening;
                    elsif sensor_closed_i = '0' then
                        mq_estados_s <= closed;
                    end if;						
                when others =>
                    mq_estados_s <= opened;
            end case;
        end if;
    end process;

    with mq_estados_s select relays_o <= "10" when opening,
                                         "01" when closing,
                                         "11" when opened,
                                         "11" when closed,
                                         "ZZ" when others;
                
    pll_instantiate : sm_home_gate_control_pll port map(
		areset => areset_s,
		inclk0 => inclk0_s, --PLL input 50 MHz
		c0	   => c0_s,     --PLL output 50 MHz
		locked => locked_s
	);
end behavioral;					