library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity decodificator_7seg is
	port(A: in std_logic_vector(3 downto 0);
	Q: out std_logic_vector(6 downto 0));
end entity;

architecture arh_comp of decodificator_7seg is
begin
	process(A)
	begin 
		case (A) is
			when "0000" => Q <= "1111110";
			when "0001" => Q <= "0110000";
			when "0010" => Q <= "1101101";
			when "0011" => Q <= "1111001";
			when "0100" => Q <= "0110011";
			when "0101" => Q <= "1011011";
			when "0110" => Q <= "1011111";
			when "0111" => Q <= "1110000";
			when "1000" => Q <= "1111111";
			when "1001" => Q <= "1111011";
			when others => Q <= "XXXXXXX";
		end case; 
	end process;
end architecture;