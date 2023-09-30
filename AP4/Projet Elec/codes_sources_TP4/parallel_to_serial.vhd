library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity parallel_to_serial is

	port
	(
		BCLK			: in  std_logic;
		DACLRC		: in  std_logic;
		left_in		: in	std_logic_vector(15 downto 0);
		right_in		: in	std_logic_vector(15 downto 0);
		DACDAT		: out  std_logic
	);
end parallel_to_serial;

architecture par_to_ser of parallel_to_serial is

	signal DACLRC_sample : std_logic_vector(1 downto 0);		-- pour stocker les 2 derniers échantillons de ADCLRC
	signal DACLRC_falling : std_logic;								-- indique les fronts descendants de ADCLRC
	signal DACLRC_rising : std_logic;								-- indique les fronts montants de ADCLRC
	signal counter : integer range 0 to 31;						-- permet de se repérer dans la séquence
	signal left_shift_reg : std_logic_vector(15 downto 0);	-- pour stocker l'entrée série
	signal right_shift_reg : std_logic_vector(15 downto 0);
	

begin

	process(BCLK) is  						-- registre à décalage pour stocker les 2 derniers échantillons de DACLRC
	begin											-- (sur front montant de BCLK car DACLRC change sur front descendant)
		if (rising_edge(BCLK)) then
			DACLRC_sample(1 downto 0) <= DACLRC & DACLRC_sample(1);
		end if;
	end process;

	process(BCLK, DACLRC_sample) is  	-- évaluation de DACLRC_falling et DACLRC_rising (modifiés sur front descendant de BCLK: 
	begin											-- ils serviront pour le reset de counter qui fonctionne sur front montant)
		if (falling_edge(BCLK)) then
			if (DACLRC_sample(1) = '0') AND (DACLRC_sample(0) = '1') then		-- DACLRC vaut maintenant 0, il valait avant 1
				DACLRC_falling <= '1';
				DACLRC_rising <= '0';
			elsif (DACLRC_sample(1) = '1') AND (DACLRC_sample(0) = '0') then	-- DACLRC vaut maintenant 1, il valait avant 0
				DACLRC_falling <= '0';
				DACLRC_rising <= '1';
			else
				DACLRC_falling <= '0';
				DACLRC_rising <= '0';
			end if;

		end if;
	end process;

	process(BCLK, DACLRC_falling, DACLRC_rising) is  						-- compteur pour se situer dans la séquence,
	begin																					-- entièrement synchrone sur front montant de BCLK
		if (rising_edge(BCLK)) then												-- (puisque le registre à décalage sera décalé sur front descendant de BCLK,
			if ((DACLRC_falling = '1') OR (DACLRC_rising = '1')) then	--  et counter doit être fixé à ce moment)
				counter <= 0;
			elsif (counter < 31) then
				counter <= counter + 1;
			else
				counter <= counter;
			end if;
		end if;
	end process;

	process(BCLK, counter, DACLRC) is  															-- registre à décalage pour lire l'entrée série
	begin 																								-- l'entrée doit être échantillonnée sur front montant de BCLK
		if(falling_edge(BCLK)) then
			if (counter >= 0) AND (counter <= 14) AND (DACLRC = '0')then				-- décalage du registre 15 fois
				left_shift_reg(15 downto 0) <= left_shift_reg(14 downto 0) & '0';		-- (MSB sorti en 1er, LSB en dernier)

			elsif (counter = 15) AND (DACLRC = '0') then										-- le registre a été décalé 15 fois
				left_shift_reg(15 downto 0) <= left_in(15 downto 0);						-- et les 16 bits qu'il contenait ont été lus par le CODEC
																											-- => on peut mettre à jour son contenu 
			else
				left_shift_reg(15 downto 0) <= left_shift_reg(15 downto 0);
			end if;
		end if;
	end process;

	process(BCLK, counter, DACLRC) is  															-- registre à décalage pour lire l'entrée série
	begin 																								-- l'entrée doit être échantillonnée sur front montant de BCLK
		if(falling_edge(BCLK)) then
			if (counter >= 0) AND (counter <= 14) AND (DACLRC = '1')then				-- décalage du registre 15 fois
				right_shift_reg(15 downto 0) <= right_shift_reg(14 downto 0) & '0';	-- (MSB sorti en 1er, LSB en dernier)

			elsif (counter = 15) AND (DACLRC = '1') then										-- le registre a été décalé 15 fois
				right_shift_reg(15 downto 0) <= right_in(15 downto 0);					-- et les 16 bits qu'il contenait ont été lus par le CODEC
																											-- => on peut mettre à jour son contenu 
			else
				right_shift_reg(15 downto 0) <= right_shift_reg(15 downto 0);
			end if;
		end if;
	end process;


	DACDAT <= left_shift_reg(15) when (DACLRC = '0') else right_shift_reg(15);

end par_to_ser;