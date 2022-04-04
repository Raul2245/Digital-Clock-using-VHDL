library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity num_mod3 is 
	port(EN, RST, CLK: in std_logic;
	CARRY: out std_logic;
	Q: out std_logic_vector(1 downto 0));
end entity;

architecture arh_comp of num_mod3 is
begin 
	process(CLK, EN, RST)
	variable temp: std_logic_vector(1 downto 0) := "00";
	begin
		if (EN = '1') then
			if (RST = '1') then
				temp := "00";
			elsif (CLK'event and CLK = '1') then
				temp := temp + 1;
				if (temp = "11") then
					temp := "00";
					CARRY <= '1';
				else
					CARRY <= '0';
				end if;
			end if;
		else
			temp := temp;
		end if;	  
		Q <= temp;
	end process;
end architecture;