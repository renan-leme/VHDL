-- Project: Description of the 74h595 CI testbench using positive logic
-- Author: Renan de Brito Leme
-- Date: 08/16/2021

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--use IEEE.numeric_std.all;

--declaramos a entidade
entity CI_74h595_descrip_tb is
end CI_74h595_descrip_tb;

--a arquitetura
architecture stimulus of CI_74h595_descrip_tb is

	component CI_74h595_descrip is
	port(
		oe_i    : in  std_logic; --Output enable
		srclr_i : in  std_logic; --shift register clear
		srclk_i : in  std_logic; --shift register clkr
		ser_i   : in  std_logic; --shift register inputserial data
		rclk_i  : in  std_logic; --Storage register clk
		qa_o	: out std_logic;
		qb_o    : out std_logic;
		qc_o	: out std_logic;
		qd_o	: out std_logic;
		qe_o	: out std_logic;
		qf_o	: out std_logic;
		qg_o	: out std_logic;
		qh_o	: out std_logic;
		qh1_o	: out std_logic
	);
	end component;

	signal oe_s    : std_logic := '1'; --Output enable
	signal srclr_s : std_logic := '0'; --shift register clear
	signal srclk_s : std_logic := '0'; --shift register clkr
	signal ser_s   : std_logic := '0'; --shift register inputserial data
	signal rclk_s  : std_logic := '0'; --Storage register clk
	signal qa_s	   : std_logic := '0';
	signal qb_s	   : std_logic := '0';
	signal qc_s	   : std_logic := '0';
	signal qd_s	   : std_logic := '0';
	signal qe_s	   : std_logic := '0';
	signal qf_s	   : std_logic := '0';
	signal qg_s	   : std_logic := '0';
	signal qh_s	   : std_logic := '0';
	signal qh1_s   : std_logic := '0';

	-- Clock period
	constant clk_period : time := 2 ns;

begin

	-- Clock process definitions
	clk_p : process
	begin
		srclk_s <= '0';
		rclk_s  <= '1';
		wait for clk_period/2;
		srclk_s <= '1';
		rclk_s  <= '0';
		wait for clk_period/2;
	end process;

	srclr_s <= '0', '1' after 2*clk_period;

    -- Stimulate Control process
   process
   begin
		--Initialize the signals and wait until the reset goes to '0'
		wait until srclr_s = '1';

	    --Wait the rising edge clk to sincronize the result with the clk
		wait until rising_edge(rclk_s);
		
		--Writening in the address 3 -- data = A4 (10100100)
		--address_s <= (2 downto 0 => "011", (others=>'0'));
		oe_s  <= '0';
		wait until rising_edge(rclk_s);
		ser_s <= '1';
		wait until rising_edge(rclk_s);
		ser_s <= '0';
		wait until rising_edge(rclk_s);
		wait until rising_edge(rclk_s);
		wait until rising_edge(rclk_s);
		wait until rising_edge(rclk_s);
		wait until rising_edge(rclk_s);
		wait until rising_edge(rclk_s);
		wait until rising_edge(rclk_s);
		wait until rising_edge(rclk_s);
		wait until rising_edge(rclk_s);
		oe_s <= '1';
		wait until rising_edge(rclk_s);
		wait until rising_edge(rclk_s);
		oe_s <= '0';
		wait;

   end process;

   -- Instantiate the Device Under Test (DUT)
	DUT : CI_74h595_descrip port map(
		oe_i    => oe_s,
		srclr_i => srclr_s,
		srclk_i => srclk_s,
		ser_i   => ser_s,
		rclk_i  => rclk_s,		
		qa_o    => qa_s,
		qb_o    => qb_s,
		qc_o	=> qc_s,
		qd_o	=> qd_s,
		qe_o	=> qe_s,
		qf_o	=> qf_s,
		qg_o	=> qg_s,
		qh_o	=> qh_s,
		qh1_o	=> qh1_s
	);

end stimulus;				