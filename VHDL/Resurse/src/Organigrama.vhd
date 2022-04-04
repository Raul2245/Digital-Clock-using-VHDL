library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity UC is 
	port (CLOCK, SET, ALARM, STOPALARM, COMPARARE: in std_logic;
	AFISARE, SETTIME, SETALARM, RINGALARM: out std_logic);
end entity;

architecture str_comp of UC is 
signal STARE, NXSTARE: bit_vector(1 downto 0);
begin
	ACTUALIZARE_STARE: process (CLOCK)
	begin
		if (CLOCK'EVENT and CLOCK = '1') then STARE <= NXSTARE;
		end if;
	end process ACTUALIZARE_STARE;

	TRANSITIONS: process (STARE, SET, ALARM, STOPALARM, COMPARARE)
	begin
		case STARE is
			when "00" => AFISARE <= '0'; SETTIME <= '0'; SETALARM <= '0';
						if SET = '1' then
							NXSTARE <= "01"; 
						else 
							SETTIME <= '0';
							if ALARM = '1' then NXSTARE <= "10";
							elsif ALARM = '0' then 
								AFISARE <= '0'; SETALARM <= '0'; SETTIME <= '0';
								if COMPARARE = '1' then NXSTARE <= "11";
								elsif  COMPARARE = '0' then NXSTARE <= "00"; RINGALARM <= '0';
								end if;
							end if;
						end if;
						if SET = '1' and ALARM = '1' then NXSTARE <= "00";
						end if;
			when "01" => AFISARE <= '0'; SETTIME <= '1'; 
						if SET = '0' then 
							if ALARM = '1' then NXSTARE <= "10";
							elsif ALARM = '0' then
								if COMPARARE = '1' then NXSTARE <= "11";
								else NXSTARE <= "00";
								end if;
							end if;
						elsif SET = '1' then NXSTARE <= "01";
						end if;
						if SET = '1' and ALARM = '1' then NXSTARE <= "00";
						end if;
			when "10" => AFISARE <= '1'; SETALARM <= '1'; SETTIME <= '0'; 
						if ALARM = '1' then NXSTARE <= "10"; 
						elsif ALARM = '0' then 
							if COMPARARE = '1' then
								NXSTARE <= "11";
							elsif COMPARARE = '0' then
								NXSTARE <= "00";
							end if;
						end if;
						if SET = '1' and ALARM = '1' then NXSTARE <= "00";
						end if;
			when "11" => RINGALARM <= '1';
						if STOPALARM = '1' then  RINGALARM <= '0';
							if SET = '1' then NXSTARE <= "01";
							end if;
							if ALARM = '1' then NXSTARE <= "10";
							end if;
						end if;
						if SET = '1' and ALARM = '1' then NXSTARE <= "00";
						end if;
						NXSTARE <= "00";
		end case;
	end process TRANSITIONS;
end architecture;
							
					
					