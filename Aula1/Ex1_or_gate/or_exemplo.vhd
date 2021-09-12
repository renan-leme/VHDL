--Exemplo.
--Esse será um OR REDUTOR. Ele pega todas as entradas e faz um OR entre todas.
--Exemplo que usará GENERIC e FOR.
library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.numeric_std.all;

--declaramos a entidade
entity or_exemplo is

	port(
		input_port	: 	in	std_logic_vector(3 downto 0);
		output_port	:	out	std_logic
	);
end or_exemplo;

--a arquitetura
architecture behavioral of or_exemplo is

--para este exemplo não declaramos sinais ou componentes. mas caso fossem declarados, seria aqui.

begin

	--aqui é onde o código acontece.
	output_port <=  input_port(0) or input_port(1) or input_port(2) or input_port(3);
	
	--output_port <=  '0' when input_port = "0000" else '1';
	
	--with input_port select
	--	output_port <=  '0' when "0000",
	--					'1' when others;



end behavioral;