library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity ceas is
	port (CLK, MODE, M, H, RESET: in std_logic;
	UMIN, ZMIN, UHOUR, ZHOUR: out std_logic_vector(3 downto 0));
end entity;

architecture arh_str of ceas is	

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

signal N1, N2, N3, N4, N5, N6, N7: std_logic; 
signal SU, SZ, MU, MZ, HU, HZ: std_logic_vector(3 downto 0); 
signal M1, M2, M3: std_logic;

begin
	M1 <= not('1' and MODE); --daca setam ceasul dezactivam incrementarea secundelor 
	--secunde
	C1: num_mod10 port map (EN => M1, MODE => '0', INCREMENT => '0', RST => RESET, CLK => CLK, CARRY => N1, Q => SU);
	C2: num_mod6 port map (EN => N1, MODE => '0', INCREMENT => '0', RST => RESET, CLK => CLK, CARRY => N2, Q => SZ);
	N3 <= N1 and N2; 
	--minute
	M2 <= N3 or MODE;
	C3: num_mod10 port map (EN => M2 , MODE => MODE, INCREMENT => M, RST => RESET, CLK => CLK, CARRY => N4, Q => MU);
	N5 <= (N3 and N4) or (N4 and MODE);
	C4: num_mod6 port map (EN => N5, MODE => '0', INCREMENT => '0', RST => RESET, CLK => CLK, CARRY => N6, Q => MZ);
	N7 <= N5 and N6;
	--ore
	M3 <= N7 or MODE;
	C5: num_mod24 port map (EN => M3, MODE => MODE, INCREMENT => H, RST => RESET, CLK => CLK, QU => HU, QZ => HZ);
	UMIN <= MU; ZMIN <= MZ; UHOUR <= HU; ZHOUR <= HZ;
end architecture;