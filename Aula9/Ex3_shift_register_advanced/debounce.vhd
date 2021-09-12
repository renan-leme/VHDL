-- Project: Debouncing
-- Author: Renan de Brito Leme
-- Date: 09/01/2021

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

entity debounce is
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
end debounce;

architecture rtl of debounce is

	signal debounce1  : std_logic_vector(239 downto 0) := (others=>'1');
	signal debounce2  : std_logic_vector(239 downto 0) := (others=>'1');
	signal debounce3  : std_logic_vector(239 downto 0) := (others=>'1');
	signal debounce4  : std_logic_vector(239 downto 0) := (others=>'1');
	signal debounce5  : std_logic_vector(239 downto 0) := (others=>'1');
	signal debounce6  : std_logic_vector(239 downto 0) := (others=>'1');
	signal debounce7  : std_logic_vector(239 downto 0) := (others=>'1');
	signal pulse1     : std_logic := '1';
	signal pulse2     : std_logic := '1';
	signal pulse3     : std_logic := '1';
	signal pulse4     : std_logic := '1';
	signal pulse5     : std_logic := '1';
	signal pulse6     : std_logic := '1';
	signal pulse7     : std_logic := '1';

begin

	process(ck)
	begin
		if rising_edge(ck) then
			debounce1 <= debounce1(238 downto 0) & deb_in1;
			pulse1 <= debounce1(239);
			deb_out1 <= '1';
			if debounce1 = x"000000000000000000000000000000000000000000000000000000000000" and pulse1 = '1' then
				deb_out1 <= '0';
			end if;
		end if;
	end process;

	process(ck)
	begin
		if rising_edge(ck) then
			debounce2 <= debounce2(238 downto 0) & deb_in2;
			pulse2 <= debounce2(239);
			deb_out2 <= '1';
			if debounce2 = x"000000000000000000000000000000000000000000000000000000000000" and pulse2 = '1' then
				deb_out2 <= '0';
			end if;
		end if;
	end process;

	process(ck)
	begin
		if rising_edge(ck) then
			debounce3 <= debounce3(238 downto 0) & deb_in3;
			pulse3 <= debounce3(239);
			deb_out3 <= '1';
			if debounce3 = x"000000000000000000000000000000000000000000000000000000000000" and pulse3 = '1' then
				deb_out3 <= '0';
			end if;
		end if;
	end process;

	process(ck)
	begin
		if rising_edge(ck) then
			debounce4 <= debounce4(238 downto 0) & deb_in4;
			pulse4 <= debounce4(239);
			deb_out4 <= '1';
			if debounce4 = x"000000000000000000000000000000000000000000000000000000000000" and pulse4 = '1' then
				deb_out4 <= '0';
			end if;
		end if;
	end process;

	process(ck)
	begin
		if rising_edge(ck) then
			debounce5 <= debounce5(238 downto 0) & deb_in5;
			pulse5 <= debounce5(239);
			deb_out5 <= '1';
			if debounce5 = x"000000000000000000000000000000000000000000000000000000000000" and pulse5 = '1' then
				deb_out5 <= '0';
			end if;
		end if;
	end process;

	process(ck)
	begin
		if rising_edge(ck) then
			debounce6 <= debounce6(238 downto 0) & deb_in6;
			pulse6 <= debounce6(239);
			deb_out6 <= '1';
			if debounce6 = x"000000000000000000000000000000000000000000000000000000000000" and pulse6 = '1' then
				deb_out6 <= '0';
			end if;
		end if;
	end process;

	process(ck)
	begin
		if rising_edge(ck) then
			debounce7 <= debounce7(238 downto 0) & deb_in7;
			pulse7 <= debounce7(239);
			deb_out7 <= '1';
			if debounce7 = x"000000000000000000000000000000000000000000000000000000000000" and pulse7 = '1' then
				deb_out7 <= '0';
			end if;
		end if;
	end process;

end rtl;