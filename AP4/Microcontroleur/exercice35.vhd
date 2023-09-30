library ieee;
use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

entity tp5CompteurSimple is
    port (
        clk : in std_logic;
        Q : out unsigned(4 downto 0)
    );
end tp5CompteurSimple;

architecture compt of tp5CompteurSimple is
    signal compteur : unsigned(4 downto 0);
begin
    process(clk)
    begin
        if rising_edge(clk) then
            compteur <= compteur + 1;
            Q <= compteur;
        end if;
    end process;
end compt;