library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ADC0831 is
    port(
        ref_clk:  in   std_logic;  --125MHZ (8ns) | (FPGA clock)               
        spi_clk:  out  std_logic;  --250KHZ (4us)  | to ADC 
								   --means each 500 ref_clk is one spi_clk         
        spi_cs:   out  std_logic;  --chip select active low                 
        spi_miso: in   std_logic;  --Pin Do in ADC                   
        spi_data: out  std_logic_vector(7 downto 0);
								   --8 bit space for saving sampled data readed from ADC to it
        ADCRead:  in   std_logic;  --trigger / Sampling key (1 means sapmling|0 means idel)      
        busy:     out  std_logic   --status (1 busy) for sampling or not
    );
end ADC0831;

architecture Behavioral of ADC0831 is
    type state is (IDLE, Tsetup, Read1, Read2, Stop);    	 --making suitable pulse to read from ADC
    signal FSM: state := IDLE;     						 	 --data type: state (FSM changable)
    signal spi_clk_counter: integer range 0 to 500 := 0; 	 --data type: integer   
    signal temporaryData: std_logic_vector(8 downto 0) := (others => '0');
    signal dataIndex: integer range 0 to 8 := 8; --9th index is for timing setting so it's not valid
    signal spi_clk_int: std_logic := '0';

begin
    spi_clk <= spi_clk_int; 								 --spi_clk=0
    process(ref_clk) 				                         --process sensitive to ref_clk (125MHz) 
    begin
        if rising_edge(ref_clk) then --working on rising(positive) edge / synchrone data with ref_clk
            case FSM is
                when IDLE =>		 						 --not working
                    spi_cs <= '1';                    
                    spi_clk_int <= '0';
                    spi_clk_counter <= 0;
                    dataIndex <= 8;                   
                    busy <= '0';     --'one bit'                  
                    temporaryData<= (others => '0'); 		 --make 0 all vector's indexes
                    if ADCRead = '1' then     		         --when sampling key is pressed initialize        
                        FSM <= Tsetup;
                        spi_cs <= '0';                
                        busy <= '1';                  
                    end if;

                when Tsetup =>                               --next time process running comes to Tsetup
                    spi_clk_counter <= spi_clk_counter + 1;	 --spi_clk_counter ++
                    if spi_clk_counter = 31 then   			 --(1/125Mhz) *31 = 248ns wait for Tsetup
                        FSM <= Read1; 						 --next time FSM goes to Read1
                        spi_clk_int <= '1'; 				 --spi_clk = 1
                        spi_clk_counter <= 0; 				 --initialize
                    end if;

                when Read1 =>  								 --in first positive clock no data is valid!
                    spi_clk_int <= '1'; 					 --spi_clk = 1
                    spi_clk_counter <= spi_clk_counter + 1;  --spi_clk_counter ++
                    if spi_clk_counter = 250 then  			 --(250*8ns=2us) making first positive spi_clk=1
                        spi_clk_int <= '0'; 				 --spi_clk = 0
                        spi_clk_counter <= 0;
                        FSM <= Read2; 						 --next time FSM goes to Read2
                    end if;

                when Read2 => 								
                    spi_clk_counter <= spi_clk_counter + 1; 
                    if spi_clk_counter = 250 then 			 --(250 * 8ns = 2us) time for half spi_clk pulse
                        spi_clk_int <= not spi_clk_int; 	 -- making spi_clk +-
                        spi_clk_counter <= 0;
                    end if;
                    if spi_clk_int = '0' and spi_clk_counter =100 then--Tpd(after 8ns*100=800ns data is Valid)   
                        temporaryData(dataIndex) <= spi_miso;--MISO(data) goes in 8th index of temporaryData
                        if dataIndex = 0 then     
                            FSM <= Stop;
                            spi_clk_counter <= 0;
                        else
                            dataIndex <= dataIndex - 1;
                        end if;
                    end if;                    
                when Stop => 								 --one clk more for CS and data for stop
                    spi_clk_counter <= spi_clk_counter + 1;  --spi_clk_counter ++
                    if spi_clk_counter = 250 then 			 --waint for one spi_clk more
                        spi_clk_int <= not spi_clk_int;
                        spi_clk_counter <= 0;
                        if spi_clk_int = '0' then
                            spi_cs <= '1';                       
                            spi_data <= temporaryData(7 downto 0);	--9th data is for time setting/invalid!                      
                            FSM <= IDLE;    						--next time FSM goes to IDEL                       
                        end if;
                    end if;
            end case;
        end if;
    end process;
end Behavioral;
