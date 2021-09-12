-- Project: Description of the 74h595 CI using positive logic
-- Author: Renan de Brito Leme
-- Date: 08/16/2021

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--use IEEE.numeric_std.all;

entity CI_74h595_descrip is
	port(
		oe_i    : in  std_logic; --output enable
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
			
end CI_74h595_descrip;

architecture behavior of CI_74h595_descrip is
   
	signal q_serial_s: std_logic_vector(7 downto 0) :=(others=>'0');

begin

	process(srclk_i)
	begin
		if rising_edge(srclk_i) then
			if srclr_i = '1' then
				q_serial_s(0) <= ser_i;
				q_serial_s(7 downto 1) <= q_serial_s(6 downto 0);
			else
				q_serial_s <= (others=>'0');
			end if;
		end if;
	end process;

	process(rclk_i, oe_i)
	begin
		if oe_i = '1' then
			qa_o <= 'Z';
			qb_o <= 'Z';
			qc_o <= 'Z';
			qd_o <= 'Z';
			qe_o <= 'Z';
			qf_o <= 'Z';
			qg_o <= 'Z';
			qh_o <= 'Z';
		elsif rising_edge(rclk_i) then
			qa_o <= q_serial_s(0);
			qb_o <= q_serial_s(1);
			qc_o <= q_serial_s(2);
			qd_o <= q_serial_s(3);
			qe_o <= q_serial_s(4);
			qf_o <= q_serial_s(5);
			qg_o <= q_serial_s(6);
			qh_o <= q_serial_s(7);
		end if;
	end process;
	qh1_o <= q_serial_s(7);	
end behavior;