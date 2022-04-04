library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity bistabil_d is
	port (D, RST, CLK: in std_logic;
	Q: out std_logic);
end entity;

architecture arh_cmp of bistabil_d is
begin
	process(CLK, RST)
	begin
		if RST = '1' then 
			Q <= '0';
		elsif CLK'event and CLK = '1' then
			Q <= D;
		end if;
	end process;
end architecture;