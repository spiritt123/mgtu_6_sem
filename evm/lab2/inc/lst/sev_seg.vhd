LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY led_decode IS
PORT (
    DH: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    SEG_DATA: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
);
END led_decode;

ARCHITECTURE Behavioral OF led_decode IS
BEGIN
	PROCESS (DH)
	BEGIN
		CASE DH IS
			WHEN "0000" => SEG_DATA <= "10000001";
			WHEN "0001" => SEG_DATA <= "11001111";
			WHEN "0010" => SEG_DATA <= "10010010";
			WHEN "0011" => SEG_DATA <= "10000110";
			WHEN "0100" => SEG_DATA <= "11001100";
			WHEN "0101" => SEG_DATA <= "10100100";
			WHEN "0110" => SEG_DATA <= "10100000";
			WHEN "0111" => SEG_DATA <= "10001111";
			WHEN "1000" => SEG_DATA <= "10000000";
			WHEN "1001" => SEG_DATA <= "10000100";
			WHEN "1010" => SEG_DATA <= "10001000";
			WHEN "1011" => SEG_DATA <= "11100000";
			WHEN "1100" => SEG_DATA <= "10110001";
			WHEN "1101" => SEG_DATA <= "11000010";
			WHEN "1110" => SEG_DATA <= "10110000";
			WHEN "1111" => SEG_DATA <= "10111000";
			WHEN OTHERS => NULL;
		END CASE;
	END PROCESS;
END Behavioral;