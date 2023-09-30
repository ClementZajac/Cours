library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity absolute_value is

	port
	(
		input			: in std_logic_vector(15 downto 0);
		abs_value	: out	std_logic_vector(15 downto 0)
	);
end absolute_value;

architecture abs_val of absolute_value is
signal zero, var : std_logic_vector(15 downto 0);
begin

	process(input) is
	begin
	zero <= conv_std_logic_vector(0,16);
	var <= conv_std_logic_vector(32767,16);
	---------------------------------------------------
	----------------- PLEASE COMPLETE -----------------
	
	if (input > var) then
			abs_value(15 downto 0) <= input(15 downto 0); 	-- output must be 0 when input is < 0
	else
			abs_value(15 downto 0) <= input(15 downto 0);				-- output must be same as input when input is > 0
	end if;

	---------------------------------------------------	
	end process;

end abs_val;
