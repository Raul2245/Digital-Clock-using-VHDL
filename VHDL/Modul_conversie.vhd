library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity modul_conversie is
	port (UMIN, ZMIN, UHOUR, ZHOUR: in std_logic_vector(3 downto 0);
	UCTDMIN, ZCTDMIN, UCTDHOUR, ZCTDHOUR: out std_logic_vector(6 downto 0));
end entity;

architecture arh_str of modul_conversie is	

component decodificator_7seg is
	port(A: in std_logic_vector(3 downto 0);
	Q: out std_logic_vector(6 downto 0));
end component;

begin
	C1: decodificator_7seg port map (A => UMIN, Q => UCTDMIN);
	C4: decodificator_7seg port map (A => ZMIN, Q => ZCTDMIN);
	C7: decodificator_7seg port map (A => UHOUR, Q => UCTDHOUR);
	C10: decodificator_7seg port map (A => ZHOUR, Q => ZCTDHOUR);
end architecture;