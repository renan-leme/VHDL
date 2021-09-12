-- Project: Shift Register using FOR...LOOP
-- Author: Renan de Brito Leme
-- Date: 07/27/2021

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;


entity shift_register is
    generic(N : integer := 4);
    port(
        d, clk, rst, en, set : in  std_logic;                    
        q                    : out std_logic_vector(N-1 downto 0)
    );
    end shift_register;

-- Architecture declaration
architecture behavioral of shift_register is
	signal q_temp : std_logic_vector(N-1 downto 0) := (others => '0');
begin
    process(clk, rst, en)
    begin
        if (set = '1') then
            q_temp <= (others => '1');
        else    
            if (rst = '1') then
                q_temp <= (others => '0');
            elsif (rising_edge(clk)) then
                if (en = '1') then
                    q_temp(0) <= d;
                    for i in 0 to (N-2) loop
                        q_temp(i+1) <= q_temp(i);
                    end loop;
                end if;
            end if;
        end if;
    end process;
    q <= q_temp;
end behavioral;