LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee. Std_logic_arith.all;

entity coef_table is											-- passe-bas

	port
	(
		select_coef_bank	: in std_logic;
		coef1x				: out	std_logic_vector(15 downto 0);
		coef2x				: out	std_logic_vector(15 downto 0);
		coef3x				: out	std_logic_vector(15 downto 0);
		coef4x				: out	std_logic_vector(15 downto 0);
		coef5x				: out	std_logic_vector(15 downto 0);
		coef6x				: out	std_logic_vector(15 downto 0);
		coef7x				: out	std_logic_vector(15 downto 0);
		coef8x				: out	std_logic_vector(15 downto 0);
		coef9x				: out	std_logic_vector(15 downto 0);
		coef10x				: out	std_logic_vector(15 downto 0);
		coef11x				: out	std_logic_vector(15 downto 0);
		coef12x				: out	std_logic_vector(15 downto 0);
		coef13x				: out	std_logic_vector(15 downto 0);
		coef14x				: out	std_logic_vector(15 downto 0);
		coef15x				: out	std_logic_vector(15 downto 0);
		coef16x				: out	std_logic_vector(15 downto 0);
		coef17x				: out	std_logic_vector(15 downto 0);
		coef18x				: out	std_logic_vector(15 downto 0);
		coef19x				: out	std_logic_vector(15 downto 0)
	);
end coef_table;

architecture table of coef_table is

begin

	process(select_coef_bank) is 
	begin
	
	if select_coef_bank = '0' then							-- low-pass filter
		coef1x <= conv_std_logic_vector(790, 16);
		coef2x <= conv_std_logic_vector(1020, 16);
		coef3x <= conv_std_logic_vector(1464, 16);
		coef4x <= conv_std_logic_vector(2189, 16);
		coef5x <= conv_std_logic_vector(3247, 16);
		coef6x <= conv_std_logic_vector(4673, 16);
		coef7x <= conv_std_logic_vector(6476, 16);
		coef8x <= conv_std_logic_vector(8644, 16);
		coef9x <= conv_std_logic_vector(1136, 16);
		coef10x <= conv_std_logic_vector(13887, 16);
		coef11x <= conv_std_logic_vector(16807, 16);
		coef12x <= conv_std_logic_vector(19792, 16);
		coef13x <= conv_std_logic_vector(22273, 16);
		coef14x <= conv_std_logic_vector(25475, 16);
		coef15x <= conv_std_logic_vector(27926, 16);
		coef16x <= conv_std_logic_vector(29965, 16);
		coef17x <= conv_std_logic_vector(31496, 16);
		coef18x <= conv_std_logic_vector(32445, 16);
		coef19x <= conv_std_logic_vector(32767, 16);
	else																-- high pass filter
		coef1x <= conv_std_logic_vector(-5533, 16);
		coef2x <= conv_std_logic_vector(-6790, 16);
		coef3x <= conv_std_logic_vector(-6561, 16);
		coef4x <= conv_std_logic_vector(-4938, 16);
		coef5x <= conv_std_logic_vector(-2597, 16);
		coef6x <= conv_std_logic_vector(-605, 16);
		coef7x <= conv_std_logic_vector(-42, 16);
		coef8x <= conv_std_logic_vector(-1577, 16);
		coef9x <= conv_std_logic_vector(-5136, 16);
		coef10x <= conv_std_logic_vector(-9806, 16);
		coef11x <= conv_std_logic_vector(-14023, 16);
		coef12x <= conv_std_logic_vector(-16022, 16);
		coef13x <= conv_std_logic_vector(-14395, 16);
		coef14x <= conv_std_logic_vector(-8610, 16);
		coef15x <= conv_std_logic_vector(711, 16);
		coef16x <= conv_std_logic_vector(11861, 16);
		coef17x <= conv_std_logic_vector(22446, 16);
		coef18x <= conv_std_logic_vector(30019, 16);
		coef19x <= conv_std_logic_vector(32767, 16);
	end if;
	
	end process;

end table;