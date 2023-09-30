library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity serial_to_parallel is

	port
	(
		BCLK			: in  std_logic;
		ADCLRC		: in  std_logic;
		ADCDAT		: in  std_logic;
		left_out		: out	std_logic_vector(15 downto 0);
		right_out	: out	std_logic_vector(15 downto 0)
	);
end serial_to_parallel;

architecture ser_to_par of serial_to_parallel is

	signal ADCLRC_sample : std_logic_vector(1 downto 0);		-- pour stocker les 2 derniers échantillons de ADCLRC
	signal ADCLRC_falling : std_logic;								-- indique les fronts descendants de ADCLRC
	signal ADCLRC_rising : std_logic;								-- indique les fronts montants de ADCLRC
	signal counter : integer range 0 to 31;						-- permet de se repérer dans la séquence
	signal left_shift_reg : std_logic_vector(15 downto 0);	-- pour stocker l'entrée série
	signal right_shift_reg : std_logic_vector(15 downto 0);
	signal left_data : std_logic_vector(15 downto 0);			-- entrée remise en parallèle sur 16 bits
	signal right_data : std_logic_vector(15 downto 0);
	

begin

	process(BCLK) is  						-- registre à décalage pour stocker les 2 derniers
	begin											-- échantillons de ADCLRC
		if (rising_edge(BCLK)) then
			ADCLRC_sample(1 downto 0) <= ADCLRC & ADCLRC_sample(1);
		end if;
	end process;
	
	ADCLRC_falling <= (NOT ADCLRC_sample(1)) AND ADCLRC_sample(0);		-- signaux actifs à 1 durant une période de BCLK
	ADCLRC_rising <= (ADCLRC_sample(1)) AND (NOT ADCLRC_sample(0));	-- si ADCLRC change d'état
	
	process(BCLK, ADCLRC_falling, ADCLRC_rising) is  						-- compteur pour se situer dans la séquence,
	begin																					-- entièrement synchrone sur front descendant de BCLK
		if (falling_edge(BCLK)) then												-- (puisque le signal ADCDAT sera échantillonné sur front montant de BCLK,
			if ((ADCLRC_falling = '1') OR (ADCLRC_rising = '1')) then	--  et counter doit être fixé à ce moment)
				counter <= 0;
			elsif (counter < 31) then
				counter <= counter + 1;
			else
				counter <= counter;
			end if;
		end if;
	end process;

	process(BCLK, counter, ADCLRC) is  															-- registre à décalage pour lire l'entrée série
	begin 																								-- l'entrée doit être échantillonnée sur front montant de BCLK
		if(rising_edge(BCLK)) then
			if (counter >= 0) AND (counter <= 15) AND (ADCLRC = '0')then
				left_shift_reg(15 downto 0) <= left_shift_reg(14 downto 0) & ADCDAT;	-- décalage du registre avec chargement de ADCDAT par la droite
				left_data(15 downto 0) <= left_data(15 downto 0);							-- (MSB reçu en 1er, LSB en dernier)
				
			elsif (counter = 16) AND (ADCLRC = '0') then
				left_shift_reg(15 downto 0) <= left_shift_reg(15 downto 0);				-- les 16 bits du canal gauche ont été reçus
				left_data(15 downto 0) <= left_shift_reg(15 downto 0);					-- => on met à jour le registre left_data

			else
				left_shift_reg(15 downto 0) <= left_shift_reg(15 downto 0);
				left_data(15 downto 0) <= left_data(15 downto 0);
			end if;
		end if;
	end process;
	
	process(BCLK, counter, ADCLRC) is  
	begin 
		if(rising_edge(BCLK)) then
			if (counter >= 0) AND (counter <= 15) AND (ADCLRC = '1')then
				right_shift_reg(15 downto 0) <= right_shift_reg(14 downto 0) & ADCDAT;	-- décalage du registre avec chargement de ADCDAT par la droite
				right_data(15 downto 0) <= right_data(15 downto 0);							-- (MSB reçu en 1er, LSB en dernier)
				
			elsif (counter = 16) AND (ADCLRC = '1') then
				right_shift_reg(15 downto 0) <= right_shift_reg(15 downto 0);				-- les 16 bits du canal gauche ont été reçus
				right_data(15 downto 0) <= right_shift_reg(15 downto 0);						-- => on met à jour le registre right_data

			else
				right_shift_reg(15 downto 0) <= right_shift_reg(15 downto 0);
				right_data(15 downto 0) <= right_data(15 downto 0);
			end if;
		end if;
	end process;

	left_out(15 downto 0) <= left_data(15 downto 0);
	right_out(15 downto 0) <= right_data(15 downto 0);

end ser_to_par;
