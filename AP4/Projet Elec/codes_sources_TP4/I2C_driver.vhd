library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity I2C_driver is

	port
	(
		CLOCK			: in  std_logic;									-- horloge à 48 kHz fournie par le composant config_CODEC
		GO				: in  std_logic;									-- signal de départ pour la transmission i2c,
		DATA			: in	 std_logic_vector(23 downto 0);		-- donnée à transmettre, fournie par le composant config_CODEC
		I2C_SDA		: inout  std_logic;	-- horloge i2c
		I2C_SCL		: out  std_logic;		-- horloge i2c
		SENT			: out  std_logic;		-- 1 au repos, passe à 0 dès que la transmission commence, et revient à 1 quand elle est terminée
		ACK			: out  std_logic		-- doit valoir 0 si ACK reçu à chaque envoi d'octet par la liaison i2c
	);
end I2C_driver;

architecture I2C of I2C_driver is

	signal data_to_send : std_logic_vector(23 downto 0);	-- sert à stocker la donnée à envoyer
																			--(chargée au début de la transmission avec les 24 bits présents sur l'entrée DATA)
	signal I2C_counter : integer range 0 to 63;		-- compteur incrémenté sur front montant de clock, indique la position dans la séquence i2c
	signal SDA : std_logic;									-- donnée à transmettre sur i2c_SDA
	signal SCLK : std_logic;								-- indique si I2C_SCLK est figé à 1 ou pas
	signal ACK1 : std_logic;
	signal ACK2 : std_logic;
	signal ACK3 : std_logic;

begin

	I2C_SDA <= '0' when (SDA = '0') else 'Z';
	
	process(SCLK, I2C_counter, CLOCK) is
	begin
		if (SCLK = '1') then													-- si SCLK vaut 1, I2C_SCL vaut aussi 1
			I2C_SCL <= '1';
		elsif (I2C_counter >= 4) AND (I2C_counter <= 30) then		-- quand I2C_counter entre 4 et 30, I2C_SCLK vaut NOT(CLOCK)
			I2C_SCL <= NOT CLOCK;											-- (inversion car I2C_SDA change sur front montant de CLOCK, et les fronts montants
																					-- de I2C_SCLK doivent être décalés)
		else
			I2C_SCL <= '0';													-- dans les autres cas, I2C_SCL vaut 0
		end if;
 	end process;
	
	ACK <= ACK1 OR ACK2 OR ACK3;		-- ACK = 0 si la transmission I2C s'est bien déroulée

	process(CLOCK, GO) is 
	begin 
		if(rising_edge(CLOCK)) then				-- i2c_counter remis à 0 lorsque GO est activé (reset synchrone))
			if (GO = '0') then						-- puis incrémenté jusqu'à atteindre sa valeur max (de 0 à 63)
				I2C_counter <= 0;
			elsif (I2C_counter < 63) then
				I2C_counter <= I2C_counter + 1;
			else
				I2C_counter <= I2C_counter;
			end if;
		end if;
	end process;

	process(CLOCK, I2C_counter) is 
	begin 
			if(rising_edge(CLOCK)) then
				case I2C_counter is
				when 0 => SDA <= '1'; SCLK <= '1'; SENT <= '0'; ACK1 <= '0'; ACK2 <= '0'; ACK3 <= '0';
				-- start
				when 1 => SDA <= '0'; SCLK <= '1'; SENT <= '0'; data_to_send <= DATA;
				when 2 => SDA <= '0'; SCLK <= '0'; SENT <= '0';
				-- send slave address + Write
				when 3 => SDA <= data_to_send(23); SCLK <= '0'; SENT <= '0';
				when 4 => SDA <= data_to_send(22); SCLK <= '0'; SENT <= '0';
				when 5 => SDA <= data_to_send(21); SCLK <= '0'; SENT <= '0';
				when 6 => SDA <= data_to_send(20); SCLK <= '0'; SENT <= '0';
				when 7 => SDA <= data_to_send(19); SCLK <= '0'; SENT <= '0';
				when 8 => SDA <= data_to_send(18); SCLK <= '0'; SENT <= '0';
				when 9 => SDA <= data_to_send(17); SCLK <= '0'; SENT <= '0';
				when 10 => SDA <= data_to_send(16); SCLK <= '0'; SENT <= '0';
				when 11 => SDA <= '1'; SCLK <= '0'; SENT <= '0';						-- I2C_SDA passe en haute impédance
				-- send next byte (7 bits for CODEC's register address + 1st bit of CODEC's register content)
				when 12 => SDA <= data_to_send(15); SCLK <= '0'; SENT <= '0';
							  ACK1 <= I2C_SDA;
				when 13 => SDA <= data_to_send(14); SCLK <= '0'; SENT <= '0';
				when 14 => SDA <= data_to_send(13); SCLK <= '0'; SENT <= '0';
				when 15 => SDA <= data_to_send(12); SCLK <= '0'; SENT <= '0';
				when 16 => SDA <= data_to_send(11); SCLK <= '0'; SENT <= '0';
				when 17 => SDA <= data_to_send(10); SCLK <= '0'; SENT <= '0';
				when 18 => SDA <= data_to_send(9); SCLK <= '0'; SENT <= '0';
				when 19 => SDA <= data_to_send(8); SCLK <= '0'; SENT <= '0';
				when 20 => SDA <= '1'; SCLK <= '0'; SENT <= '0';						-- I2C_SDA passe en haute impédance
				-- send next byte (8 remaining bits of CODEC's register content)
				when 21 => SDA <= data_to_send(7); SCLK <= '0'; SENT <= '0';
							  ACK2 <= I2C_SDA;
				when 22 => SDA <= data_to_send(6); SCLK <= '0'; SENT <= '0';
				when 23 => SDA <= data_to_send(5); SCLK <= '0'; SENT <= '0';
				when 24 => SDA <= data_to_send(4); SCLK <= '0'; SENT <= '0';
				when 25 => SDA <= data_to_send(3); SCLK <= '0'; SENT <= '0';
				when 26 => SDA <= data_to_send(2); SCLK <= '0'; SENT <= '0';
				when 27 => SDA <= data_to_send(1); SCLK <= '0'; SENT <= '0';
				when 28 => SDA <= data_to_send(0); SCLK <= '0'; SENT <= '0';
				when 29 => SDA <= '1'; SCLK <= '0'; SENT <= '0';						-- I2C_SDA passe en haute impédance
				-- stop
				when 30 => SDA <= '0'; SCLK <= '0'; SENT <= '0';
							  ACK3 <= I2C_SDA;
				when 31 => SDA <= '0'; SCLK <= '1'; SENT <= '0';
				when 32 => SDA <= '1'; SCLK <= '1'; SENT <= '1';
				when others => SDA <= '1'; SCLK <= '1'; SENT <= '1';
				end case;
			end if;
	end process;

end I2C;
