library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity num_mod24 is 
	port(EN, MODE, INCREMENT, RST, CLK: in std_logic;
	QU: out std_logic_vector(3 downto 0);
	QZ: out std_logic_vector(3 downto 0));
end entity;

architecture arh_comp of num_mod24 is
begin 
	process(CLK, EN, RST)
	variable tempU: std_logic_vector(3 downto 0) := "0000";
	variable tempZ: std_logic_vector(3 downto 0) := "0000";
	begin
		if (RST = '1') then
			tempU := "0000";
			tempZ := "0000";
		else
			if MODE = '0' then
				if (EN = '1') then
					if (CLK'event and CLK = '1') then
						tempU := tempU + 1;
						if (tempU = "1010") then	
							tempU := "0000";
							tempZ := tempZ + 1;
						end if;
						if tempU = "0100" and tempZ = "0010" then
							tempU := "0000";
							tempZ := "0000";
						end if;
					end if;
				else
					tempU := tempU;
					tempZ := tempZ;
				end if;
			else
				if MODE = '1' then
					if (EN = '1') then
						if (CLK'event and CLK = '1' and INCREMENT = '1') then
							tempU := tempU + 1;
							if (tempU = "1010") then	
								tempU := "0000";
								tempZ := tempZ + 1;
							end if;
							if tempU = "0100" and tempZ = "0010" then
								tempU := "0000";
								tempZ := "0000";
							end if;
						end if;
					else
						tempU := tempU;
						tempZ := tempZ;
					end if;
				end if;
			end if;
		end if;
		QU <= tempU;
		QZ <= tempZ;
	end process;
end architecture;