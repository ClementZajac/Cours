library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity config_CODEC is

	port
	(
		clock_in		: in  std_logic;		-- horloge à 50 MHz
		SENT			: in  std_logic;		-- signal reçu pour indiquer que la transmission i2c est terminée
													-- 1 au repos, passe à 0 dès que la transmission commence, et revient à 1 quand elle est terminée
		volume_down	: in	std_logic;		-- actif à l'état bas, dure une période de I2C_SCLK, provoqué par un appui sur KEY0
		volume_up	: in	std_logic;		-- actif à l'état bas, dure une période de I2C_SCLK, provoqué par un appui sur KEY0
		
		clock_4		: out  std_logic;		-- horloge à 50 MHz / 4, soit 12,5 MHz, utilisée pour AUD_XCK
		clock_1024	: out  std_logic;		-- horloge à 50 MHz / 1024, soit 48,8 kHz, utilisée pour I2C_SCLK
		GO				: out  std_logic;		-- signal de départ pour la transmission i2c,
													-- 1 au repos, passe à 0 durant 1 période de I2C_SCLK pour donner le top départ
		DATA			: out	 std_logic_vector(23 downto 0);	-- 3 octets à envoyer durant une transmission i2c
																			-- (adresse i2c du CODEC suivi de W, adresse du registre, contenu du registre)
		
		volume_level: out	 std_logic_vector(4 downto 0)
	);
end config_CODEC;

architecture config of config_CODEC is

	signal counter : std_logic_vector(10 downto 0);		-- diviseur d'horloge
	signal vol : integer range 0 to 31 := 16;				-- vol (incrémenté / décrémenté à chaque appui sur KEY0 ou KEY1)   --- de 0 à 31
	signal volume : std_logic_vector(6 downto 0);		-- niveau final de volume sur 7 bits --- de 96 à 127
	signal address : integer range 0 to 31;				-- adresse dans la table des données à transmettre
	signal table : std_logic_vector(15 downto 0);		-- table contenant la configuration du CODEC
	
	SHARED VARIABLE table_size: INTEGER := 9;		-- adresse max de la table

begin

	process(clock_in) is 
	begin											-- compteur 11 bits, pour fournir les horloges à fin/4 et fin/1024
		if(rising_edge(clock_in)) then	-- (le 11ème bit sert à générer le signal GO)
			counter <= counter + 1;
		end if;
	end process;
	
	clock_4 <= counter(1);		-- clock_in / 4, soit 12,5 MHz, pour générer AUD_XCK
	clock_1024 <= counter(9);	-- clock_in / 1024, soit 48,8 kHz, pour générer I2C_SCLK


	process(volume_down, volume_up, SENT) is 
	begin 																-- address est remis à 0 lorsque volume_down ou volume_up est actif (à l'état bas)
		if ((volume_down = '0') OR (volume_up = '0')) then	-- ensuite address s'incrémente lorsque SENT remonte (quand la transmission est finie)
			address <= 0;												-- jusqu'à atteindre la valeur table_size + 1 (dans ce cas GO ne sera plus déclenché)
		elsif (rising_edge(SENT)) then
			if (address <= table_size) then
				address <= address + 1;
			-- else
			-- 	address <= address;
			end if;
		end if;
	end process;

	process(counter(9), volume_down, volume_up) is
	begin															-- volume_down et volume_up peuvent être à l'état bas entre
		if (rising_edge(counter(9))) then				-- deux fronts descendants successifs de clock_1024 ( = counter(9), à 48,8 kHz)
																	-- vol peut être modifié sur le front montant de clock_1024,
																	-- au milieu de l'impulsion volume_down ou volume_up
			if (volume_down = '0') then
-------------------------------------------------------------------------------
-- PLEASE MODIFY THIS SECTION TO AVOID vol ROLLING OVER TO 31 WHEN IT REACHES 0
-------------------------------------------------------------------------------
				-- vol <= vol - 1;
				if vol > 0 then
					vol <= vol - 1;
				else
					vol <= vol;
				end if;

			elsif (volume_up = '0') then
-------------------------------------------------------------------------------
-- PLEASE MODIFY THIS SECTION TO AVOID vol ROLLING OVER TO 0 WHEN IT REACHES 31
-------------------------------------------------------------------------------		
				--vol <= vol + 1;
				if vol < 31 then
					vol <= vol + 1;
				else
					vol <= vol;
				end if;

			else
				vol <= vol;
			end if;
		end if;
	end process;	
	
	volume <= conv_std_logic_vector(vol + 96,7);		-- volume entre 96 et 127
	
	process(address, SENT) is								-- GO = 1 au repos et descend à 0 pendant 1 période de I2C_SCLK (48,8 kHz)
	begin															-- lorsqu'une nouvelle transmission I2C doit commencer
		if ((address <= table_size) AND (SENT = '1')) then
			GO <= counter(10);
		else
			GO <= '1';
		end if;
	end process;
	
	process(address) is
	begin
		case address is										-- registre		contenu
			when 0 => table <= X"0C00";					--  0000110		000000000	Power Down Control: disable every power down
--			when 1 => table <= X"0EC2";					--  0000111		011000010	Digital Audio Format: I2S, 16 bits, Right when DACLRC low, No swap, Master mode, Invert BCLK
			when 1 => table <= X"0E42";					--  0000111		001000010							  : Don't invert BCLK
--			when 2 => table <= X"0838";					--  0000100		000111000	Analogue Audio Path: Line input to ADC, Bypass, Select DAC, Enable side tone, -6dB
			when 2 => table <= X"0810";					--  0000100		000010000                      : Disable bypass, Disable side tone
			when 3 => table <= X"1000";					--  0001000		000000000	Sampling Control: 256fs (soit fs = 48,8 kHz), digital filter type 1, MCLK not divided, Clockout = MCLK
			when 4 => table <= X"0017";					--  0000000		000010111	Left Line In: 0dB, Disable Mute, Disable simultaneous load
			when 5 => table <= X"0217";					--  0000001		000010111	Right Line In: 0dB, Disable Mute, Disable simultaneous load
			when 6 => table <= X"04" & '0' & volume;	--  0000010		00xxxxxxx	Left Headphone Out: Volume Control, Disable Zero Cross Detect, Disable simultaneous load
			when 7 => table <= X"06" & '0' & volume;	--  0000011		00xxxxxxx	Right Headphone Out: Volume Control, Disable Zero Cross Detect, Disable simultaneous load
			when 8 => table <= X"0A00";					--  0000101		000000000	Digital Audio Path: Enable High Pass, Clear offset, Disable DAC mute, Disable De-emphasis
			when table_size => table <= X"1201";		--  0001001		000000001	Active Control: Active
			when others => table <= X"1201";
			end case;
	end process;
	

	process(SENT) is
	begin
		if (rising_edge(SENT)) then			-- mériterait d'être modifié car DATA n'est pas chargé tant
			DATA <= X"34" & table;				-- qu'un transfert complet n'a pas été effectué
		end if;										-- (donc au 1er transfert, DATA garde la valeur qu'il avait précédemment)
	end process;
	
	volume_level <= conv_std_logic_vector(vol,5);

end config;