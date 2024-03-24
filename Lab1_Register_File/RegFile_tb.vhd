LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY RegisterFile_tb IS
END RegisterFile_tb;

ARCHITECTURE RegisterFile_testbench OF RegisterFile_tb IS

    constant CLK_PERIOD : time := 1 ns; 

    COMPONENT RegisterFile
        PORT (
            clk   		: IN STD_LOGIC;
            wrtReg 		: IN STD_LOGIC;
            wrtRegAdrs 		: IN std_logic_vector(4 DOWNTO 0);
            readReg1Adrs 	: IN std_logic_vector(4 DOWNTO 0);
            readReg2Adrs 	: IN std_logic_vector(4 DOWNTO 0);
            wrtRegData 		: IN std_logic_vector(31 DOWNTO 0);
            readReg1Data 	: OUT std_logic_vector(31 DOWNTO 0);
            readReg2Data 	: OUT std_logic_vector(31 DOWNTO 0)
        );
    END COMPONENT;
	
    -- Signals
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL wrtReg : STD_LOGIC := '0';
    SIGNAL readReg1Adrs : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";
    SIGNAL readReg2Adrs : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00001";
    SIGNAL wrtRegAdrs : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00010";
    SIGNAL wrtRegData : STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');
    SIGNAL readReg1Data : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL readReg2Data : STD_LOGIC_VECTOR(31 DOWNTO 0);
 

   

BEGIN

        

    RegFile_tb: RegisterFile 
	PORT MAP (clk ,wrtReg ,readReg1Adrs ,readReg2Adrs ,wrtRegAdrs ,wrtRegData ,readReg1Data ,readReg2Data );
    
    PROCESS
    BEGIN
        WHILE now < 1000 ns LOOP -- Run for 1000 ns
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        END LOOP;
        WAIT;
    END PROCESS;

	PROCESS
    	BEGIN
        WAIT FOR CLK_PERIOD; 
       
        wrtRegAdrs <= "00000"; 
        wrtRegData <= "11110000000000000000000000000000";
	wrtReg <= '1';
        WAIT FOR CLK_PERIOD;
	wrtReg <= '0';
	
        wrtRegAdrs <= "00001"; 
        wrtRegData <= "00001111000000000000000000000000"; 
	wrtReg <= '1';
	WAIT FOR CLK_PERIOD;
	wrtReg <= '0';

	
	wrtRegAdrs <= "00010"; 
        wrtRegData <= "00000000111100000000000000000000"; 
	wrtReg <= '1';
	WAIT FOR CLK_PERIOD;
	wrtReg <= '0';

	
	wrtRegAdrs <= "00011"; 
        wrtRegData <= "00000000000011110000000000000000";
	wrtReg <= '1';
	WAIT FOR CLK_PERIOD;
	wrtReg <= '0';
        WAIT;
    	END PROCESS;
    
   PROCESS
   BEGIN
        WAIT FOR CLK_PERIOD; 
        
        wrtRegAdrs <= "00010"; 
        wrtRegData <= "11111111111111111111111111111111" ; 
        wrtReg <= '1'; 
	WAIT FOR CLK_PERIOD;
	wrtReg <= '0';
        readReg1Adrs <= "00000"; 
        readReg2Adrs <= "00001"; 
        WAIT FOR CLK_PERIOD; 
        
        
	ASSERT readReg1Data = "11110000000000000000000000000000" 
            REPORT "readReg1Data has unexpected data" ;
	ASSERT readReg2Data = "00001111000000000000000000000000" 
            REPORT "readReg2Data has unexpected data" ;
        
        
        wrtRegAdrs <= "00011"; 
        wrtRegData <= "00000000000000000000000000000000"; 
        wrtReg <= '1'; 
	WAIT FOR CLK_PERIOD;
	wrtReg <= '0';
        readReg1Adrs <= "00010"; 
        readReg2Adrs <= "00011"; 
        WAIT FOR CLK_PERIOD; 
        
        -- Check outputs
        ASSERT readReg1Data = "11111111111111111111111111111111" 
            REPORT "readReg1Data has unexpected data" ;
        ASSERT readReg2Data = "00000000000000000000000000000000"
            REPORT "readReg2Data has unexpected data" ;

        wrtRegAdrs <= "00011"; 
        wrtRegData <= "00000000000000000000000000001111"; 
        wrtReg <= '0';
	WAIT FOR CLK_PERIOD;
	wrtReg <= '0';
        readReg1Adrs <= "00010"; 
        readReg2Adrs <= "00011"; 
        WAIT FOR CLK_PERIOD; 
        
        -- Check outputs
        ASSERT readReg1Data = "11111111111111111111111111111111" 
            REPORT "readReg1Data has unexpected data" ;
        ASSERT readReg2Data = "00000000000000000000000000000000"
            REPORT "readReg2Data has unexpected data" ;
        WAIT;
    END PROCESS;

end RegisterFile_testbench;

