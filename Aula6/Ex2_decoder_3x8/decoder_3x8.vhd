
-- Project: Decoder 3x8
-- Author: Renan de Brito Leme
-- Date: 09/01/2021

library IEEE;
use IEEE.std_logic_1164.all;

entity decoder_3x8 is 
    port(
	    code_i    : in  std_logic_vector(2 downto 0);
        sev_seg_o : out std_logic; -- Turns on the 7 segments display in the board
	    decode_o  : out std_logic_vector(7 downto 0)
    );
 end decoder_3x8;
 
 architecture behavioral of decoder_3x8 is	
begin
    sev_seg_o <= '0'; -- Turns on the 7 segments display in the board
	process(all)
		begin
			case code_i is 
                                         -- .gfedcba
				when "111"  => decode_o <= "01000000"; -- 0
				when "110"  => decode_o <= "01111001"; -- 1
				when "101"  => decode_o <= "00100100"; -- 2
				when "100"  => decode_o <= "00110000"; -- 3
				when "011"  => decode_o <= "00011001"; -- 4
				when "010"  => decode_o <= "00010010"; -- 5
				when "001"  => decode_o <= "00000010"; -- 6
				when "000"  => decode_o <= "01111000"; -- 7
				when others => decode_o <= "ZZZZZZZZ"; 
			end case;
	end process;
 end behavioral;