library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RegisterFile is
    Port (
        clk   		     : in  std_logic;
        wrtReg 	     	     : in  std_logic;
        wrtRegAdrs           : in  std_logic_vector(4 downto 0);
        readReg1Adrs   	     : in  std_logic_vector(4 downto 0);
        readReg2Adrs         : in  std_logic_vector(4 downto 0);
        wrtRegData           : in  std_logic_vector(31 downto 0);
        readReg1Data         : out std_logic_vector(31 downto 0);
        readReg2Data         : out std_logic_vector(31 downto 0)
    );
end RegisterFile;

architecture Behavioral of RegisterFile is
    type reg_array is array (0 to 31) of STD_LOGIC_VECTOR(31 downto 0);
    signal registers : reg_array := (others => (others => '0'));
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if wrtReg = '1' then
                registers(conv_integer(wrtRegAdrs)) <= wrtRegData;
            end if;
            readReg1Data <= registers(conv_integer(readReg1Adrs));
            readReg2Data <= registers(conv_integer(readReg2Adrs));
        end if;
    end process;
end Behavioral;