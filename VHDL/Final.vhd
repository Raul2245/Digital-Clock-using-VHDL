library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity aparat is
	port (CLK, H, M, START, SETALARM, STOPALARM, SETTIME, RESET, RDO: in std_logic;
	UMIN, ZMIN, UHOUR, ZHOUR: out std_logic_vector(6 downto 0);
	RINGALARM, RADIO: out std_logic);
end entity;

architecture arh_str of aparat is

component ceas is
	port (CLK, MODE, M, H, RESET: in std_logic;
	UMIN, ZMIN, UHOUR, ZHOUR: out std_logic_vector(3 downto 0));
end component; 

component modul_conversie is
	port (UMIN, ZMIN, UHOUR, ZHOUR: in std_logic_vector(3 downto 0);
	UCTDMIN, ZCTDMIN, UCTDHOUR, ZCTDHOUR: out std_logic_vector(6 downto 0));
end component; 

component modul_afisare is
	port (CLK, AFISARE, START: in std_logic;
	UTMIN, ZTMIN, UTHOUR, ZTHOUR, UAMIN, ZAMIN, UAHOUR, ZAHOUR: in std_logic_vector(6 downto 0);
	UCTDMIN, ZCTDMIN, UCTDHOUR, ZCTDHOUR: out std_logic_vector(6 downto 0));
end component;

component modul_comparare is
	port (UTM, ZTM, UTH, ZTH, UAM, ZAM, UAH, ZAH: in std_logic_vector(3 downto 0);
	Y: out std_logic);
end component;

component alarma is
	port (CLK, RESET, EN, M, H: in std_logic;
	UMIN, ZMIN, UHOUR, ZHOUR: out std_logic_vector(3 downto 0));
end component;

component bistabil_d is
	port (D, RST, CLK: in std_logic;
	Q: out std_logic);
end component;

component devider is
	port (CLK, RST : in std_logic;
	Q: out std_logic);
end component;

component UC is 
	port (CLOCK, SET, ALARM, STOPALARM, COMPARARE: in std_logic;
	AFISARE, SETTIME, SETALARM, RINGALARM: out std_logic);
end component;

signal CMP, AFIS, STT, STA, RNGALM, ALARM_ON, CLK2, TEMP: std_logic;  
signal T1, T2, T3, T4: std_logic_vector(3 downto 0);
signal A1, A2, A3, A4: std_logic_vector(3 downto 0);
signal TC1, TC2, TC3, TC4: std_logic_vector(6 downto 0);
signal AC1, AC2, AC3, AC4: std_logic_vector(6 downto 0);

begin
	--vom folosi un divizor de frecventa pentru a putea sincroniza componentele	cu modulul de afisare
	C1: devider port map (CLK => CLK, RST => RESET,  Q => CLK2);
	C2: UC port map(CLOCK => CLK2, SET => SETTIME, ALARM => SETALARM, STOPALARM => STOPALARM, COMPARARE => CMP, AFISARE => AFIS, SETTIME => STT, SETALARM => STA, RINGALARM => RNGALM);
	C3: ceas port map(CLK => CLK2, MODE => SETTIME, M => M, H => H, RESET => RESET, UMIN => T1, ZMIN => T2, UHOUR => T3, ZHOUR => T4);
	TEMP <= STOPALARM or RESET;
	C4: bistabil_d port map(D => SETALARM, RST => TEMP, CLK => SETALARM, Q => ALARM_ON);
	C5: alarma port map(CLK => CLK2, RESET => TEMP, EN => SETALARM, M => M, H => H, UMIN => A1, ZMIN => A2, UHOUR => A3, ZHOUR => A4);								
	C6: modul_comparare port map(UTM => T1, ZTM => T2, UTH => T3, ZTH => T4, UAM => A1, ZAM => A2, UAH => A3, ZAH => A4, Y => CMP);
	C7: modul_conversie port map(UMIN => T1, ZMIN => T2, UHOUR => T3, ZHOUR => T4, UCTDMIN => TC1, ZCTDMIN => TC2, UCTDHOUR => TC3, ZCTDHOUR => TC4);
	C8: modul_conversie port map(UMIN => A1, ZMIN => A2, UHOUR => A3, ZHOUR => A4, UCTDMIN => AC1, ZCTDMIN => AC2, UCTDHOUR => AC3, ZCTDHOUR => AC4);
	C9: modul_afisare port map(CLK => CLK, AFISARE => AFIS, START => START, UTMIN => TC1, ZTMIN => TC2, UTHOUR => TC3, ZTHOUR => TC4, UAMIN => AC1, ZAMIN => AC2, UAHOUR => AC3, ZAHOUR => AC4, UCTDMIN => UMIN, ZCTDMIN => ZMIN, UCTDHOUR => UHOUR, ZCTDHOUR => ZHOUR);
	RADIO <= RDO and START;
	RINGALARM <= RNGALM and ALARM_ON and START and (not SETALARM);
end architecture;
	