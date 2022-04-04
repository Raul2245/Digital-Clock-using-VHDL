library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity comp_4b is 
	port (A, B: in std_logic_vector(3 downto 0);
	F: out std_logic);
end entity;

architecture arh_comp of comp_4b is
begin
	F <= ((A(0) xnor B(0)) and (A(1) xnor B(1)) and (A(2) xnor B(2)) and (A(3) xnor B(3)));
end architecture;