library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity devider is
	port (CLK, RST : in std_logic;
	Q: out std_logic);
end entity;

architecture arh_cmp of devider is 
signal counter: integer := 1;
signal temp: std_logic := '0';
begin 
	process(CLK, RST)
	begin 
		if RST = '1' then
			counter <= 1;
			temp <= '0';
		elsif CLK'event and CLK = '1' then
			counter <= counter + 1;
		if counter = 1 then
			temp <= not temp;
			counter <= 1;
		end if;
		end if;
		Q <= temp;
	end process;
end architecture;