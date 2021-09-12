-- Project : Advanced shift register
-- Author  : Renan de Brito Leme
-- Date    : 28/08/2021

library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.numeric_std.all;

entity shift_register_advanced is
	port(
		shift_register_in  : in std_logic;
		parallel_data 	   : in std_logic_vector(1023 downto 0);
		clk                : in std_logic;
		rst                : in std_logic;
		en                 : in std_logic;
		direction          : in std_logic;
		force_input        : in std_logic;
		force_0            : in std_logic;
		force_1            : in std_logic;
		parallel_load      : in std_logic;
		shift_register_out : out std_logic;
		parallel_out       : out std_logic_vector(1023 downto 0)
	);
end shift_register_advanced;


architecture behavioral of shift_register_advanced is
	signal shift_register : std_logic_vector(1023 downto 0);
	signal data_selected  : std_logic;

begin
	data_selected <= '0' when force_0 = '1' else
				     '1' when force_1 = '1' else
					  shift_register_in when force_input = '1' else
					  shift_register(0) when direction   = '0' else
					  shift_register(1023);
		
	process(rst, clk, parallel_load, en, direction)
	begin
		if rst = '1' then
			shift_register <= (others=>'0');
		elsif rising_edge(clk) then
			--intencionalmente faremos com que eu possa carregar
			--paralelamente independente do enable.
			--para fazer a carga depender do enable, basta colocar
			--ela 'dentro' do if.
			if parallel_load = '1' then
				shift_register <= parallel_data;
			elsif en = '1' then
				if direction = '0' then --saída pelo LSB, roda para o LSB.
					shift_register <= data_selected & shift_register(1023 downto 1);
				else
					shift_register <= shift_register(1022 downto 0) & data_selected;
				end if;
			else
				parallel_out <= shift_register;
			end if;
		end if;
	end process;
	
	shift_register_out <= shift_register(0) when direction = '0' else
						  shift_register(1023);
end behavioral;