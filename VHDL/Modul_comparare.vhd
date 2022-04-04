library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity modul_comparare is
	port (UTM, ZTM, UTH, ZTH, UAM, ZAM, UAH, ZAH: in std_logic_vector(3 downto 0);
	Y: out std_logic);
end entity;

architecture arh_str of modul_comparare is

component comp_4b is 
	port (A, B: in std_logic_vector(3 downto 0);
	F: out std_logic);
end component;

signal N1, N2, N3, N4: std_logic;

begin 
	C1: comp_4b port map (A => UTM, B => UAM, F => N1);
	C2: comp_4b port map (A => ZTM, B => ZAM, F => N2);
	C3: comp_4b port map (A => UTH, B => UAH, F => N3);
	C4: comp_4b port map (A => ZTH, B => ZAH, F => N4);
	Y <= N1 and N2 and N3 and N4;
end architecture;