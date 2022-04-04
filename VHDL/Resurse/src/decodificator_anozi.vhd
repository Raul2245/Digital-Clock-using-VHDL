library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity decodificator_anozi is
	port(A: in std_logic_vector(1 downto 0);
	Q: out std_logic_vector(3 downto 0));
end entity;

architecture arh_comp of decodificator_anozi is
begin 
	process(A)
	begin
		case (A) is
			when "00" => Q <= "1110";
			when "01" => Q <= "1101";
			when "10" => Q <= "1011";
			when "11" => Q <= "0111";
			when others => Q <= "XXXX";
		end case;
	end	process;
end architecture;