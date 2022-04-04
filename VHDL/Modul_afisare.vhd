library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity modul_afisare is
	port (CLK, AFISARE, START: in std_logic;
	UTMIN, ZTMIN, UTHOUR, ZTHOUR, UAMIN, ZAMIN, UAHOUR, ZAHOUR: in std_logic_vector(6 downto 0);
	UCTDMIN, ZCTDMIN, UCTDHOUR, ZCTDHOUR: out std_logic_vector(6 downto 0));
end entity;

architecture arh_str of modul_afisare is	
begin 
	process(CLK, AFISARE, START)
	variable temp1: std_logic_vector(6 downto 0) := "1111110";
	variable temp2: std_logic_vector(6 downto 0) := "1111110";  
	variable temp3: std_logic_vector(6 downto 0) := "1111110";
	variable temp4: std_logic_vector(6 downto 0) := "1111110";
	begin
		if START = '1' then
			if CLK'event and CLK = '1' then
				if AFISARE = '0' then
					temp1 := UTMIN; temp2 := ZTMIN; temp3 := UTHOUR; temp4 := ZTHOUR;
				elsif AFISARE = '1' then
					temp1 := UAMIN; temp2 := ZAMIN; temp3 := UAHOUR; temp4 := ZAHOUR;
				end if;
			end if;
		else 
			temp1 := "XXXXXXX"; temp2 := "XXXXXXX"; temp3 := "XXXXXXX"; temp4 := "XXXXXXX";
		end if;
		UCTDMIN <= temp1; ZCTDMIN <= temp2; UCTDHOUR <= temp3; ZCTDHOUR <= temp4;
	end process;
end architecture;