library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity num_mod10 is 
	port(EN, MODE, INCREMENT, RST, CLK: in std_logic;
	CARRY: out std_logic;
	Q: out std_logic_vector(3 downto 0));
end entity;

architecture arh_comp of num_mod10 is
begin 
	process(CLK, EN, RST)
	variable temp: std_logic_vector(3 downto 0) := "0000";
	begin
		if (RST = '1') then
			temp := "0000";
		else
			if MODE = '0' then
				if (EN = '1') then
					if (CLK'event and CLK = '1') then
						temp := temp + 1;
						if (temp = "1010") then	
							temp := "0000";
						end if;
						if (temp = "1001") then
							CARRY <= '1';
						else
							CARRY <= '0';
						end if;
					end if;
				else
					temp := temp;
				end if;
			elsif MODE = '1' then
				if (EN = '1') then
					if CLK'event and CLK = '1' and INCREMENT = '1' then 
						temp := temp + 1;
						if (temp = "1010") then	
							temp := "0000";
						end if;
						if (temp = "1001") then
							CARRY <= '1';
						else
							CARRY <= '0';
						end if;
					end if;
				end if;
			end if;
		end if;
		Q <= temp;
	end process;
end architecture;