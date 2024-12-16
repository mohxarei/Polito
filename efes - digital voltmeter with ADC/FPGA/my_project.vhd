library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity my_project is
    port(
            H16_clk      : in       std_logic;
            Button1      : in       std_logic;
            Button2      : in       std_logic;
            LED_data     : out      std_logic_vector(3 downto 0);
            SRAM_data    : inout    STD_LOGIC_VECTOR(7 downto 0); -- Bidirectional data bus from    ar3=data[0] to ar10=data[7]
            SRAM_addr    : out      STD_LOGIC_VECTOR(2 downto 0);  -- SRAM address lines            add0 = ar0 to add2=ar2   
            CE           : out      STD_LOGIC;         -- Chip Enable, active low                   ar11
            WE           : out      STD_LOGIC;         -- Write Enable, active low                  ar12
            OE           : out      STD_LOGIC;         -- Output Enable, active low                 ar13
            MOSI         : out      std_logic;         --                                           A2
            SCK          : out      std_logic;         --                                           A1
            SS           : out      std_logic;         --                                           A0  
            ADC_clock    : out      std_logic;         --SDA     -- Clock for SPI
            ADC_cs       : out      std_logic;         --A       -- Chip Select for ADC
            ADC_miso     : in       std_logic          --SCL     -- MISO (Master In Slave Out) from ADC
        );
end my_project;

architecture Behavioral of my_project is
    
    component  SPI_Master is
    port(
        sys_clk     : in    std_logic;
        spi_mosi    : out   std_logic;
        spi_sck     : out   std_logic;
        spi_ss      : out   std_logic;
        data_in     : in    std_logic_vector(7 downto 0);
        start_trans : in    std_logic
    );
    end component;
    component ADC0831 is
        port(
        ref_clk:    in      std_logic;                    
        spi_clk:    out     std_logic;                    
        spi_cs:     out     std_logic;                   
        spi_miso:   in      std_logic;                    
        spi_data:   out     std_logic_vector(7 downto 0); 
        ADCRead:    in      std_logic;                    
        busy:       out     std_logic                     
        );
    end component;
    signal counter_1s:      integer := 0;
    signal write:           std_logic_vector(1 downto 0):="11";
    signal read:            std_logic_vector(1 downto 0):="00";
    signal index_w:         integer:=0;
    signal index_r:         integer:=0;
    signal write_cnt:       integer:=0;
    signal read_cnt:        integer:=0;
    signal Data:            std_logic_vector(7 downto 0);
    signal Start:           std_logic:='0';
    signal spi_data:        std_logic_vector(7 downto 0);
    signal ADCRead:         std_logic:='0';
    signal busy:            std_logic:='0';
    signal tmp_Data:        std_logic_vector(7 downto 0); 
    signal tmp_cnt:         integer:=0;
    signal button1_state:   std_logic:='1';
    signal button2_state:   std_logic:='1';
    type btnFSM is (sample, stay, send);
    signal button1_fsm: btnFSM:=sample;
    signal button2_fsm: btnFSM:=sample;
begin

    master_uint: SPI_Master
        port map(H16_clk,MOSI,SCK, SS,Data,Start);
        
    ADC_uint: ADC0831
        port map(H16_clk,ADC_clock,ADC_cs, ADC_miso,spi_data,ADCRead, busy);

    process(H16_clk)
    begin
        if rising_edge(H16_clk) then
            Start <= '0';
            ADCRead <= '0';
            
            if counter_1s = 75000000 then
            
            
                if Button1 = '1' and busy = '0' and write = "00" then
                        SRAM_data   <= (others => '0'); 
                        ADCRead     <= '1';
                        write       <= "01";
                end if;
                
                
                
                if Button2 = '1' and read = "00" then
                    read <= "01";
                    SRAM_data <= (others => 'Z');
                    Data      <= (others => '0');
                end if; 
                
                
                
                counter_1s <= 0;      
            else
                counter_1s <= counter_1s + 1;
            end if;   
                     
                     
                     
                     
                     
                     
            if write = "01" and busy = '0' then
               tmp_Data <= spi_data;
               tmp_cnt <= tmp_cnt + 1;
               if tmp_cnt = 5 then 
                tmp_cnt<= 0;
                write       <= "10";
               end if;
            end if;         
            if write = "10" then                
                    write <= "11";
                    CE <= '0';
                    WE <= '0';
                    OE <= '1';
                    SRAM_addr <= std_logic_vector(to_unsigned(index_w, 3));
                    LED_data  <= std_logic_vector(to_unsigned(index_w, 4));
                    SRAM_data <= tmp_Data;
                    Start <= '1'; 
                    --Data  <=     tmp_Data;
                    Data  <=     x"73"; 
                    index_w   <= index_w + 1;
                    if index_w = 7 then 
                        index_w <= 0;
                    end if;
            elsif  write = "11" then
                write_cnt <= write_cnt + 1;
                if write_cnt = 6 then
                    write_cnt <= 0;
                    write <= "00";
                    CE <= '1';
                    WE <= '1';
                    OE <= '1';                          
                end if;
            end if;
            
            
            
            
            
            
            
            
            
            
            if read = "01" then
                read <= "10";
                CE <= '0';
                WE <= '1';
                OE <= '0';
                SRAM_addr <= std_logic_vector(to_unsigned(index_r, 3));
                LED_data  <= std_logic_vector(to_unsigned(index_r, 4));
                index_r   <= index_r + 1;
                if index_r = 7 then 
                    index_r <= 0;
                end if;
            elsif  read = "10" then
                read_cnt <= read_cnt + 1;
                if read_cnt = 6 then
                    read_cnt <= 0;
                    read <= "11";    
                end if;   
            elsif  read = "11" then
                read_cnt <= read_cnt + 1;
                if read_cnt = 6 then
                    read_cnt <= 0;
                    read <= "00";
                    Start <= '1';
                    Data  <= SRAM_data;
                    CE <= '1';
                    WE <= '1';
                    OE <= '1'; 
                end if;                            
            end if;
        end if;
    end process;
end Behavioral;
