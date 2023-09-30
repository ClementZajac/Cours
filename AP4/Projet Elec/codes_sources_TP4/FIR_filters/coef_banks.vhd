-- ================================================================================================
-- écrit par Jean-Marc Capron
-- 31 juillet 2014
--
-- Ce fichier décrit deux jeux de 19 coefficients sur 16 bits, pouvant être utilisés avec le composant "FIR_filter_37_tap".
-- La sélection du jeu de coefficients se fait avec l'entrée "select_coef_bank".
-- ================================================================================================

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee. Std_logic_arith.all;

PACKAGE my_package IS
	type ARRAY_19_by_16 is array (18 downto 0) of STD_LOGIC_VECTOR(15 downto 0);
END PACKAGE my_package;

--LIBRARY work;								-- cette ligne est facultative
USE work.my_package.all;

LIBRARY ieee;									-- cette partie doit être recopiée,
USE ieee.std_logic_1164.ALL;				-- sinon, STD_LOGIC et STD_LOGIC_VECTOR
USE ieee. Std_logic_arith.all;			-- ne sont pas reconnus
USE ieee.std_logic_signed.all;			-- même si "LIBRARY ieee; etc." a déjà été mis au début de ce fichier

entity coef_banks is

	port
	(
		select_coef_bank	: in std_logic;
		coef			: out	ARRAY_19_by_16							-- 19 coefficients, each 16-bit wide
	);
end coef_banks;

architecture banks_of_coef of coef_banks is

begin

	process(select_coef_bank) is 
	begin
	
	if select_coef_bank = '0' then							-- low-pass filter
		coef(0) <= conv_std_logic_vector(790, 16);
		coef(1) <= conv_std_logic_vector(1020, 16);
		coef(2) <= conv_std_logic_vector(1464, 16);
		coef(3) <= conv_std_logic_vector(2189, 16);
		coef(4) <= conv_std_logic_vector(3247, 16);
		coef(5) <= conv_std_logic_vector(4673, 16);
		coef(6) <= conv_std_logic_vector(6476, 16);
		coef(7) <= conv_std_logic_vector(8644, 16);
		coef(8) <= conv_std_logic_vector(1136, 16);
		coef(9) <= conv_std_logic_vector(13887, 16);
		coef(10) <= conv_std_logic_vector(16807, 16);
		coef(11) <= conv_std_logic_vector(19792, 16);
		coef(12) <= conv_std_logic_vector(22273, 16);
		coef(13) <= conv_std_logic_vector(25475, 16);
		coef(14) <= conv_std_logic_vector(27926, 16);
		coef(15) <= conv_std_logic_vector(29965, 16);
		coef(16) <= conv_std_logic_vector(31496, 16);
		coef(17) <= conv_std_logic_vector(32445, 16);
		coef(18) <= conv_std_logic_vector(32767, 16);
	else																-- high pass filter
--		coef(0) <= conv_std_logic_vector(-5533, 16);
--		coef(1) <= conv_std_logic_vector(-6790, 16);
--		coef(2) <= conv_std_logic_vector(-6561, 16);
--		coef(3) <= conv_std_logic_vector(-4938, 16);
--		coef(4) <= conv_std_logic_vector(-2597, 16);
--		coef(5) <= conv_std_logic_vector(-605, 16);
--		coef(6) <= conv_std_logic_vector(-42, 16);
--		coef(7) <= conv_std_logic_vector(-1577, 16);
--		coef(8) <= conv_std_logic_vector(-5136, 16);
--		coef(9) <= conv_std_logic_vector(-9806, 16);
--		coef(10) <= conv_std_logic_vector(-14023, 16);
--		coef(11) <= conv_std_logic_vector(-16022, 16);
--		coef(12) <= conv_std_logic_vector(-14395, 16);
--		coef(13) <= conv_std_logic_vector(-8610, 16);
--		coef(14) <= conv_std_logic_vector(711, 16);
--		coef(15) <= conv_std_logic_vector(11861, 16);
--		coef(16) <= conv_std_logic_vector(22446, 16);
--		coef(17) <= conv_std_logic_vector(30019, 16);
--		coef(18) <= conv_std_logic_vector(32767, 16);

--		coef(0) <= conv_std_logic_vector(-443, 16);			-- high pass, cutoff frequency = 1 kHz
--		coef(1) <= conv_std_logic_vector(-521, 16);
--		coef(2) <= conv_std_logic_vector(-600, 16);
--		coef(3) <= conv_std_logic_vector(-678, 16);
--		coef(4) <= conv_std_logic_vector(-756, 16);
--		coef(5) <= conv_std_logic_vector(-832, 16);
--		coef(6) <= conv_std_logic_vector(-905, 16);
--		coef(7) <= conv_std_logic_vector(-976, 16);
--		coef(8) <= conv_std_logic_vector(-1044, 16);
--		coef(9) <= conv_std_logic_vector(-1107, 16);
--		coef(10) <= conv_std_logic_vector(-1165, 16);
--		coef(11) <= conv_std_logic_vector(-1217, 16);
--		coef(12) <= conv_std_logic_vector(-1264, 16);
--		coef(13) <= conv_std_logic_vector(-1305, 16);
--		coef(14) <= conv_std_logic_vector(-1338, 16);
--		coef(15) <= conv_std_logic_vector(-1365, 16);
--		coef(16) <= conv_std_logic_vector(-1384, 16);
--		coef(17) <= conv_std_logic_vector(-1395, 16);
--		coef(18) <= conv_std_logic_vector(32767, 16);

--		coef(0) <= conv_std_logic_vector(-1082, 16);			-- high pass, cutoff frequency = 500 Hz
--		coef(1) <= conv_std_logic_vector(-1112, 16);
--		coef(2) <= conv_std_logic_vector(-1138, 16);
--		coef(3) <= conv_std_logic_vector(-1166, 16);
--		coef(4) <= conv_std_logic_vector(-1190, 16);
--		coef(5) <= conv_std_logic_vector(-1214, 16);
--		coef(6) <= conv_std_logic_vector(-1236, 16);
--		coef(7) <= conv_std_logic_vector(-1256, 16);
--		coef(8) <= conv_std_logic_vector(-1276, 16);
--		coef(9) <= conv_std_logic_vector(-1292, 16);
--		coef(10) <= conv_std_logic_vector(-1308, 16);
--		coef(11) <= conv_std_logic_vector(-1322, 16);
--		coef(12) <= conv_std_logic_vector(-1334, 16);
--		coef(13) <= conv_std_logic_vector(-1344, 16);
--		coef(14) <= conv_std_logic_vector(-1352, 16);
--		coef(15) <= conv_std_logic_vector(-1360, 16);
--		coef(16) <= conv_std_logic_vector(-1364, 16);
--		coef(17) <= conv_std_logic_vector(-1366, 16);
--		coef(18) <= conv_std_logic_vector(65534, 16);

		coef(0) <= conv_std_logic_vector(-24489, 16);			-- band pass, from 1kHZ to 2 kHz
		coef(1) <= conv_std_logic_vector(-26350, 16);
		coef(2) <= conv_std_logic_vector(-27238, 16);
		coef(3) <= conv_std_logic_vector(-27071, 16);
		coef(4) <= conv_std_logic_vector(-25809, 16);
		coef(5) <= conv_std_logic_vector(-23461, 16);
		coef(6) <= conv_std_logic_vector(-20090, 16);
		coef(7) <= conv_std_logic_vector(-15803, 16);
		coef(8) <= conv_std_logic_vector(-10754, 16);
		coef(9) <= conv_std_logic_vector(-5137, 16);
		coef(10) <= conv_std_logic_vector(826, 16);
		coef(11) <= conv_std_logic_vector(6893, 16);
		coef(12) <= conv_std_logic_vector(12811, 16);
		coef(13) <= conv_std_logic_vector(18331, 16);
		coef(14) <= conv_std_logic_vector(23215, 16);
		coef(15) <= conv_std_logic_vector(27253, 16);
		coef(16) <= conv_std_logic_vector(30271, 16);
		coef(17) <= conv_std_logic_vector(32136, 16);
		coef(18) <= conv_std_logic_vector(32767, 16);

	end if;
	
	end process;

end banks_of_coef;