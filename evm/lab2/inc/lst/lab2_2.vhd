-- Пример модуля подавления дребезга 10 мс.
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
Entity lab2_example IS
PORT (
    RST: IN STD_LOGIC; --Системный сигнал сброса
    CLK: IN STD_LOGIC; --Сигнал синхронизации
    COUNT: IN STD_LOGIC; --Сигнал кнопки с дребезгом
    CNT: OUT STD_LOGIC --Сигнал кнопки, очищенный от дребезга
);
END lab2_example;
ARCHITECTURE behavioral OF lab2_example IS
-- Кодируем состояния в соответствии с вариантом
    CONSTANT STATE0: STD_LOGIC_VECTOR (1 downto 0) := "11";
    CONSTANT STATE1: STD_LOGIC_VECTOR (1 downto 0) := "00";
    CONSTANT STATE2: STD_LOGIC_VECTOR (1 downto 0) := "01";
    CONSTANT STATE3: STD_LOGIC_VECTOR (1 downto 0) := "10";
-- Состояние автомата в момент времени t
    SIGNAL S: STD_LOGIC_VECTOR (1 downto 0);
-- Состояние автомата в момент времени t+1
    SIGNAL SN: STD_LOGIC_VECTOR (1 downto 0);
    SIGNAL COUNTER: integer; -- Счетчик 2^20
    SIGNAL DLY_OVF: STD_LOGIC; -- Сигнал "Завершение счета"
    SIGNAL DLY_EN: STD_LOGIC; -- Сигнал разрешения работы счетчика
BEGIN
-- Память состояний
    FSM_STATE_inst: PROCESS (CLK)
    BEGIN
        IF (CLK='1' and CLK'event) THEN
            IF (RST='1') THEN
                S <= STATE0;
            ELSE
                S <= SN;
            END IF;
        END IF;
    END PROCESS;
-- Комбинационная схема для выработки сигналов CNT и DLY_EN (по индивидуальному варианту)
    CNT <= not S(1);
    DLY_EN <= not S(0);
--Комбинационные схемы для определения следующего состояния (по индивидуальному варианту)
    SN(0) <= (DLY_OVF and S(1)) or (COUNT and not S(1) and S(0)) or (not COUNT and S(1) and S(0));
    SN(1) <= (not COUNT and S(0)) or (S(1) and S(0));
-- Описание счетчика
    COUNTER_inst: PROCESS (CLK)
    BEGIN
        IF (CLK='1' and CLK'event) THEN
            IF (RST='1' or DLY_EN = ‘0’) THEN
                COUNTER <= 0;
            ELSE
                COUNTER <= COUNTER + 1;
            END IF;
        END IF;
    END PROCESS;
    DLY_OVF <= '1' WHEN COUNTER = 2**20-1 ELSE '0'; --Длительность задержки
END Behavioral;
