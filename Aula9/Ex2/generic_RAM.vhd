-- Project: Generic single port RAM with bidirectional data bus
-- Author: Renan de Brito Leme
-- Date: 08/03/2021

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
--use ieee.std_logic_arith.all;

entity generic_RAM is
	 generic(
		add_data_size_g   : integer := 8
	 );
    port(
		clk_i, rst_i, we_i, oe_i, ale_i : in    std_logic;
		add_data_io                     : inout std_logic_vector(add_data_size_g - 1 downto 0)
    );
end generic_RAM;

architecture behavioral of generic_RAM is
	
	component debounce is
		port (
			ck        : in  std_logic;
			deb_in1   : in  std_logic;
			deb_in2   : in  std_logic;
			deb_in3   : in  std_logic;
			deb_in4   : in  std_logic_vector(7 downto 0);
			deb_out1  : out std_logic;
			deb_out2  : out std_logic;
			deb_out3  : out std_logic;
			deb_out4  : out std_logic;
			deb_out5  : out std_logic;
			deb_out6  : out std_logic;
			deb_out7  : out std_logic;
			deb_out8  : out std_logic;
			deb_out9  : out std_logic;
			deb_out10 : out std_logic;
			deb_out11 : out std_logic
		);
	end component;

	component generic_RAM_PLL is
		port(
			areset : in  std_logic := '0';
			inclk0 : in  std_logic := '0';
			c0	   : out std_logic;
			c1	   : out std_logic;
			locked : out std_logic 
		);
	end component;

	--type ram_t is array (0 to (2**address'length)-1) of std_logic_vector((data'length)-1 downto 0);
	type ram_t is array (3 downto 0) of std_logic_vector(7 downto 0);
	signal ram_s : ram_t := (others => (others => '0'));
	signal data_o_s : std_logic_vector(7 downto 0);
	signal address_s : std_logic_vector(3 downto 0);

	--PLL Signals
	signal areset_s : std_logic := '0';
	signal inclk0_s : std_logic;
	signal c0_s     : std_logic;
	signal c1_s     : std_logic;
	signal locked_s : std_logic;

	--Debounced Signals
	signal we_i_debounced_s        : std_logic;
	signal oe_i_debounced_s        : std_logic;
	signal ale_i_debounced_s       : std_logic;
	signal add_data_io_debounced_s : std_logic_vector(7 downto 0);

begin
	
	inclk0_s <= clk_i;

	--Address selecting
	address_p : process(all)
	begin
		if rising_edge(c0_s) then
			if(ale_i_debounced_s = '1') then
				address_s <= add_data_io_debounced_s(3 downto 0);	
			end if;
		end if;
	end process;

	--Reading the the RAM memory
	data_out_p : process(all)
	begin
		if rising_edge(c0_s) then
			data_o_s <= ram_s(to_integer(unsigned(address_s)));
		end if;
	end process;
	
	--Writing in the RAM memory
	data_in_p : process(all)
	begin
		if rising_edge(c0_s) then
			if ale_i_debounced_s = '0' and we_i = '1' then
				ram_s(to_integer(unsigned(address_s))) <= add_data_io_debounced_s;
			end if;
		end if;
	end process;
	
	--output control
	add_data_io <= data_o_s when ale_i_debounced_s = '0' and oe_i_debounced_s = '1' else (others=>'Z');

	-- Debouncing
	deb_inst : debounce port map(
		ck        => c0_s,
		deb_in1   => we_i,
		deb_out1  => we_i_debounced_s,
		deb_in2   => oe_i,
		deb_out2  => oe_i_debounced_s,
		deb_in3   => ale_i,
		deb_out3  => ale_i_debounced_s,		
		deb_in4   => add_data_io,          
		deb_out4  => add_data_io_debounced_s(7),
		deb_out5  => add_data_io_debounced_s(6),
		deb_out6  => add_data_io_debounced_s(5),
		deb_out7  => add_data_io_debounced_s(4),
		deb_out8  => add_data_io_debounced_s(3),
		deb_out9  => add_data_io_debounced_s(2),
		deb_out10 => add_data_io_debounced_s(1),
		deb_out11 => add_data_io_debounced_s(0)
	);

	-- PLL
	counter_PLL_inst : generic_RAM_PLL port map (
		areset => areset_s,
		inclk0 => inclk0_s, -- 50 Mhz
		c0	   => c0_s,		-- 50 Mhz
		c1	   => c1_s,		-- 200 Mhz
		locked => locked_s
	);
end behavioral;