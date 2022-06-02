LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY test_dz IS
END test_dz;

ARCHITECTURE RTL OF test_dz IS
COMPONENT control_unit PORT (
    M : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    CLK : IN STD_LOGIC;
    RST : IN STD_LOGIC;
    C : IN STD_LOGIC_VECTOR(5 DOWNTO 0)
);
END COMPONENT;
    SIGNAL M : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL CLK : STD_LOGIC := '0';
    SIGNAL RST : STD_LOGIC := '0';
    SIGNAL C : STD_LOGIC_VECTOR(5 DOWNTO 0) := (OTHERS => '0');
    CONSTANT CLK_PERIOD : TIME := 10NS;
BEGIN
    UUT : control_unit
    PORT MAP(
        M => M,
        CLK => CLK,
        RST => RST,
        C => C
    );

    CLK_PROCESS : PROCESS
    BEGIN
        CLK <= '0';
        WAIT FOR CLK_PERIOD/2;
        CLK <= '1';
        WAIT FOR CLK_PERIOD/2;
    END PROCESS CLK_PROCESS;

    SIM_PROC : PROCESS
    BEGIN
        RST <= '0';
        WAIT FOR CLK_PERIOD;
        C <= "000000"; --S1 -> S1
        RST <= '1';
        WAIT FOR CLK_PERIOD;
        C <= "000000"; --S1 -> S1
        WAIT FOR CLK_PERIOD;
        C <= "000101"; --S1 -> S4
        WAIT FOR CLK_PERIOD;
        C <= "000000"; --S4 -> S4
        WAIT FOR CLK_PERIOD;
        C <= "000110"; --S4 -> S5
        WAIT FOR CLK_PERIOD;
        C <= "111111"; --S5 -> S5
        WAIT FOR CLK_PERIOD;
        C <= "000000"; --S5 -> S6
        WAIT FOR CLK_PERIOD;
        C <= "111111"; --S6 -> S1
        WAIT FOR CLK_PERIOD;
        C <= "000000"; --S1 -> S2
        WAIT FOR CLK_PERIOD;
        C <= "010000"; --S2 -> S2
        WAIT FOR CLK_PERIOD;
        C <= "000100"; --S2 -> S3
        WAIT FOR CLK_PERIOD;
        C <= "000010"; --S3 -> S3
        WAIT FOR CLK_PERIOD;
        C <= "000001"; --S3 -> S1
        WAIT FOR CLK_PERIOD;
        C <= "000101"; --S1 -> S4
        WAIT FOR CLK_PERIOD;
        C <= "100000"; --S4 -> S3
        WAIT FOR CLK_PERIOD;
        C <= "000001"; --S3 -> S1
        WAIT FOR CLK_PERIOD;
        C <= "010100"; --S1 -> S2
        WAIT FOR CLK_PERIOD;
        C <= "100000"; --S2 -> S5
        WAIT FOR CLK_PERIOD;WAIT;
    PROCESS SIM_PROC;
END ARCHITECTURE;
