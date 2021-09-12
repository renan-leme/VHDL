-- Project : Advanced shift register
-- Author  : Renan de Brito Leme
-- Date    : 28/08/2021

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity shift_register_advanced is
	port(
		shift_register_in  : in  std_logic;
		parallel_data 	   : in  std_logic_vector(1023 downto 0);
		clk                : in  std_logic;
		rst                : in  std_logic;
		en                 : in  std_logic;
		direction          : in  std_logic;
		force_input        : in  std_logic;
		force_0            : in  std_logic;
		force_1            : in  std_logic;
		parallel_load      : in  std_logic;
		shift_register_out : out std_logic;
		parallel_out       : out std_logic_vector(1023 downto 0)
	);
end shift_register_advanced;


architecture behavioral of shift_register_advanced is

	component shift_register_advanced_PLL is
		port(
			areset : in  std_logic := '0';
			inclk0 : in  std_logic := '0';
			c0	   : out std_logic;
			locked : out std_logic 
		);
	end component;

	component debounce is
		port (
			ck        : in  std_logic;
			deb_in1   : in  std_logic;
			deb_in2   : in  std_logic;
			deb_in3   : in  std_logic;
			deb_in4   : in  std_logic;
			deb_in5   : in  std_logic;
			deb_in6   : in  std_logic;
			deb_in7   : in  std_logic;
			deb_out1  : out std_logic;
			deb_out2  : out std_logic;
			deb_out3  : out std_logic;
			deb_out4  : out std_logic;
			deb_out5  : out std_logic;
			deb_out6  : out std_logic;
			deb_out7  : out std_logic
		);
	end component;


	signal shift_register : std_logic_vector(1023 downto 0);
	signal data_selected  : std_logic;

	--PLL Signals
	signal areset_s : std_logic := '0';
	signal inclk0_s : std_logic;
	signal c0_s     : std_logic;
	signal locked_s : std_logic;

	--Debounced Signals
	signal rst_debounced_s           : std_logic;
	signal en_debounced_s            : std_logic;
	signal direction_debounced_s     : std_logic;
	signal force_input_debounced_s   : std_logic;
	signal force_0_debounced_s       : std_logic;
	signal force_1_debounced_s       : std_logic;
	signal parallel_load_debounced_s : std_logic;


begin

	inclk0_s <= clk;
	data_selected <= '0' when force_0_debounced_s = '1' else
				     '1' when force_1_debounced_s = '1' else
					  shift_register_in when force_input_debounced_s = '1' else
					  shift_register(0) when direction_debounced_s   = '0' else
					  shift_register(1023);
		
	process(rst, c0_s, parallel_load, en, direction)
	begin
		if rst_debounced_s = '1' then
			shift_register <= (others=>'0');
		elsif rising_edge(c0_s) then
			--intencionalmente faremos com que eu possa carregar
			--paralelamente independente do enable.
			--para fazer a carga depender do enable, basta colocar
			--ela 'dentro' do if.
			if parallel_load_debounced_s = '1' then
				shift_register <= parallel_data;
			elsif en = '1' then
				if direction_debounced_s = '0' then --saída pelo LSB, roda para o LSB.
					shift_register <= data_selected & shift_register(1023 downto 1);
				else
					shift_register <= shift_register(1022 downto 0) & data_selected;
				end if;
			else
				parallel_out <= shift_register;
			end if;
		end if;
	end process;
	
	shift_register_out <= shift_register(0) when direction_debounced_s = '0' else
						  shift_register(1023);

	-- Debouncing
	deb_inst : debounce port map(
		ck        => c0_s,
		deb_in1   => rst,
		deb_out1  => rst_debounced_s,
		deb_in2   => en,
		deb_out2  => en_debounced_s,
		deb_in3   => direction,
		deb_out3  => direction_debounced_s,
		deb_in4   => force_input,
		deb_out4  => force_input_debounced_s,		
		deb_in5   => force_0,          
		deb_out5  => force_0_debounced_s,
		deb_in6   => force_1,
		deb_out6  => force_1_debounced_s,
		deb_in7   => parallel_load,
		deb_out7  => parallel_load_debounced_s
	);

	-- PLL
	counter_PLL_inst : shift_register_advanced_PLL port map (
		areset => areset_s,
		inclk0 => inclk0_s, -- 50 Mhz
		c0	   => c0_s,		-- 50 Mhz
		locked => locked_s
	);

end behavioral;