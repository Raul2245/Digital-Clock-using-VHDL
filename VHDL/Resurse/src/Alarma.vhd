library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity alarma is
	port (CLK, RESET, EN, M, H: in std_logic;
	UMIN, ZMIN, UHOUR, ZHOUR: out std_logic_vector(3 downto 0));
end entity;

architecture arh_str of alarma is	

component num_mod10 is 
	port(EN, MODE, INCREMENT, RST, CLK: in std_logic;
	CARRY: out std_logic;
	Q: out std_logic_vector(3 downto 0));
end component;

component num_mod6 is 
	port(EN, MODE, INCREMENT, RST, CLK: in std_logic;
	CARRY: out std_logic;
	Q: out std_logic_vector(3 downto 0));
end component;

component num_mod24 is 
	port(EN, MODE, INCREMENT, RST, CLK: in std_logic;
	QU: out std_logic_vector(3 downto 0);
	QZ: out std_logic_vector(3 downto 0));
end component;

signal N1, N2: std_logic; 
signal SU, SZ, MU, MZ, HU, HZ: std_logic_vector(3 downto 0); 

begin 
	C1: num_mod10 port map (EN => EN, MODE => '1', INCREMENT => M, RST => RESET, CLK => CLK, CARRY => N1, Q => UMIN);
	C2: num_mod6 port map (EN => N1, MODE => '0', INCREMENT => '0', RST => RESET, CLK => CLK, CARRY => N2, Q => ZMIN);
	C3: num_mod24 port map (EN => EN, MODE => '1', INCREMENT => H, RST => RESET, CLK => CLK, QU => UHOUR, QZ => ZHOUR);
end architecture;