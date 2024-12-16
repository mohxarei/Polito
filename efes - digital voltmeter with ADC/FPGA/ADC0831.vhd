library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ADC0831 is
    port(
        ref_clk:    in      std_logic;  --125MHZ (8ns) | 0 or 1 (for each device connected to FPGA)               
        spi_clk:    out     std_logic;  --250KHZ (4us)  | to ADC      means each 500 ref_clk is one spi_clk         
        spi_cs:     out     std_logic;  --chip select active low                 
        spi_miso:   in      std_logic;  --DO to ADC                   
        spi_data:   out     std_logic_vector(7 downto 0); --output port adc data (for saving sampled data readed from adc to it)
                                                          --8bit sisnce micro is 8bit register
        ADCRead:    in      std_logic;          --trigger (1 means sapmling|0 means idel) Sampling key       
        busy:       out     std_logic           --status (1 busy) for sapling or not
    );
end ADC0831;

architecture Behavioral of ADC0831 is
    type state is (IDLE, Tsetup, Read1, Read2, Stop); --making pulse p9 ADC datasheet
                   --read1 no data, first clk syncronize (t setup)
    signal FSM: state := IDLE; --data type: state (FSM changable)
    signal spi_clk_counter: integer range 0 to 500 := 0; --data type: integer   
    signal temporaryData: std_logic_vector(8 downto 0) := (others => '0'); --data type: std_logic_vector
                                                            --first data (9's) is when setting timing so it's not valid
    signal dataIndex: integer range 0 to 8 := 8;
    signal spi_clk_int: std_logic := '0'; --data type: std_logic

begin
    spi_clk <= spi_clk_int; --spi_clk=0
    process(ref_clk) --process sensitive to ref_clk 125MHz 
    begin
        if rising_edge(ref_clk) then --working on rising(positive) edge / making synchrone data with ref_clk
            case FSM is
                when IDLE => 
                    spi_cs <= '1';                    
                    spi_clk_int <= '0';
                    spi_clk_counter <= 0;
                    dataIndex <= 8;                   
                    busy <= '0';    --one bit                  
                    temporaryData<= (others => '0'); --vector make 0 all indexes
                    if ADCRead = '1' then             
                        FSM <= Tsetup;
                        spi_cs <= '0';                
                        busy <= '1';                  
                    end if;

                when Tsetup =>    --next time process running comes to Tsetup
                    spi_clk_counter <= spi_clk_counter + 1; --spi_clk_counter ++
                    if spi_clk_counter = 31 then   --(1/125Mhz) *31 = 248ns wait for Tsetup
                        FSM <= Read1; --next time FSM goes to Read1
                        spi_clk_int <= '1'; --spi_clk = 1
                        spi_clk_counter <= 0; --initialize
                    end if;

                when Read1 =>  --in fisrt half clock data is not valid!
                    spi_clk_int <= '1'; --making positive / spi_clk spi_clk = 1
                    spi_clk_counter <= spi_clk_counter + 1; --spi_clk_counter ++
                    if spi_clk_counter = 250 then --(250 * 8ns = 2us) making first half positive pulse spi_clk =1
                        spi_clk_int <= '0'; --spi_clk = 0
                        spi_clk_counter <= 0; --initialize
                        FSM <= Read2; --next time FSM goes to Read2
                    end if;

                when Read2 => --making spi_clk
                    spi_clk_counter <= spi_clk_counter + 1;  --spi_clk_counter ++
                    if spi_clk_counter = 250 then --(250 * 8ns = 2us) making half spi_clk pulse
                        spi_clk_int <= not spi_clk_int; -- making clock +-
                        spi_clk_counter <= 0;
                    end if;
                    if spi_clk_int = '0' and spi_clk_counter =100 then  -- = tpd  (after 8ns*100=800ns data is avalible)   
                        temporaryData(dataIndex) <= spi_miso; --0 or 1 from MISO goes in index 8 temporaryData
                        if dataIndex = 0 then     
                            FSM <= Stop;
                            spi_clk_counter <= 0;
                        else
                            dataIndex <= dataIndex - 1;
                        end if;
                    end if;                    
                when Stop => --one clk more for CS and data stop
                    spi_clk_counter <= spi_clk_counter + 1;   --spi_clk_counter ++
                    if spi_clk_counter = 250 then --waint for one spi_clk more
                        spi_clk_int <= not spi_clk_int;
                        spi_clk_counter <= 0;
                        if spi_clk_int = '0' then
                            spi_cs <= '1';                       
                            spi_data <= temporaryData(7 downto 0);    --first data (9's) is when setting timing so it's not valid                      
                            FSM <= IDLE;    --next time FSM goes to IDEL                       
                        end if;
                    end if;
            end case;
        end if;
    end process;
end Behavioral;
