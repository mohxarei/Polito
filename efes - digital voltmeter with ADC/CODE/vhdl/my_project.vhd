-- Import necessary libraries
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Entity definition for the top module (my_project)
entity my_project is
    port(  
        H16_clk   : in  std_logic;  -- FPGA Clock (125 MHz)
        Button1   : in  std_logic;  -- Sampling trigger (ADC Start)
        Button2   : in  std_logic;  -- Display trigger (Send to Arduino)
        LED_data  : out std_logic_vector(3 downto 0);  -- LED indicators (sampling count)
        SRAM_data : inout std_logic_vector(7 downto 0); -- SRAM Data Bus (Bidirectional)
        SRAM_addr : out std_logic_vector(2 downto 0);  -- SRAM Address (3-bit)
        CE, WE, OE : out std_logic;  -- SRAM Control Signals
        MOSI, SCK, SS : out std_logic;  -- SPI interface (to Arduino)
        ADC_clock, ADC_cs : out std_logic;  -- SPI interface (to ADC)
        ADC_miso  : in  std_logic  -- ADC Data Line (MISO)
    );
end my_project;

-- Architecture defining internal behavior
architecture Behavioral of my_project is

    -- Instantiate SPI Master Component
    component SPI_Master is
        port(
            sys_clk     : in    std_logic;      -- System clock (125 MHz)
            spi_mosi    : out   std_logic;      -- SPI MOSI (Master Out)
            spi_sck     : out   std_logic;      -- SPI Clock
            spi_ss      : out   std_logic;      -- SPI Chip Select
            data_in     : in    std_logic_vector(7 downto 0); -- Data to transmit
            start_trans : in    std_logic       -- Start SPI transmission
        );
    end component;

    -- Instantiate ADC Component
    component ADC0831 is
        port(
            ref_clk:    in      std_logic;   -- FPGA Clock
            spi_clk:    out     std_logic;   -- SPI Clock for ADC
            spi_cs:     out     std_logic;   -- ADC Chip Select
            spi_miso:   in      std_logic;   -- ADC Data Line
            spi_data:   out     std_logic_vector(7 downto 0); -- ADC Output Data
            ADCRead:    in      std_logic;   -- ADC Sampling trigger
            busy:       out     std_logic    -- ADC Busy flag
        );
    end component;

    -- Internal Signals
    signal counter_1s: integer := 0;  -- Counter for debouncing
    signal write, read: std_logic_vector(1 downto 0) := "11";  -- FSM States
    signal index_w, index_r: integer := 0;  -- SRAM Write/Read Index
    signal write_cnt, read_cnt: integer := 0;  -- Delay Counters
    signal Data, spi_data, tmp_Data: std_logic_vector(7 downto 0);  -- Data Buffers
    signal Start, ADCRead, busy: std_logic := '0';  -- Control Signals

begin
    -- **Instantiate SPI Master and ADC Modules**
    SPI_master_unit: SPI_Master
        port map(H16_clk, MOSI, SCK, SS, Data, Start);

    ADC_unit: ADC0831
        port map(H16_clk, ADC_clock, ADC_cs, ADC_miso, spi_data, ADCRead, busy);

    -- **Main Process for Handling Sampling & Data Storage**
    process(H16_clk)
    begin
        if rising_edge(H16_clk) then
            Start <= '0';   -- Reset SPI start signal
            ADCRead <= '0'; -- Reset ADC trigger

            -- **Button Debounce Logic (500ms delay)**
            if counter_1s = 75000000 then  
                -- **Handle Button1 (ADC Sampling)**
                if Button1 = '1' and busy = '0' and write = "00" then   
                    SRAM_data   <= (others => 'Z');  -- Tri-state (prevent overwrite)
                    ADCRead     <= '1';  -- Trigger ADC Sampling
                    write       <= "01"; -- Move to Write State
                end if;

                -- **Handle Button2 (Data Display)**
                if Button2 = '1' and read = "00" then   
                    read <= "01";  -- Set Read Flag
                    SRAM_data <= (others => 'Z');  -- Set SRAM to High Impedance
                    Data      <= (others => '0');  -- Reset Data Buffer
                end if; 

                counter_1s <= 0;  -- Reset debounce counter
            else
                counter_1s <= counter_1s + 1;  -- Increment debounce counter
            end if;   

            -- **Handle ADC Data Write to SRAM**
            if write = "01" and busy = '0' then  
                tmp_Data <= spi_data;  -- Store ADC Data in Buffer
                write <= "10";  -- Proceed to Write State
            end if;
            if write = "10" then  
                write <= "11";  -- Write Complete
                CE <= '0';  -- Enable SRAM
                WE <= '0';  -- Enable Write Mode
                OE <= '1';  -- Disable Read Mode
                SRAM_addr <= std_logic_vector(to_unsigned(index_w, 3)); -- Set Address (convert int to 3bit std)
                LED_data  <= std_logic_vector(to_unsigned(index_w, 3)); -- Update LEDs
                SRAM_data <= tmp_Data;  -- Store ADC Data to SRAM
                Start <= '1';  -- Notify Arduino (Trigger Internal ADC)
                Data  <= x"73";  -- Send ASCII 'S' to Indicate Sampling
                index_w <= index_w + 1;  -- Increment Write Index
                if index_w = 7 then index_w <= 0;  -- Reset at 8 samples
            end if;
            elsif  write = "11" then
                write_cnt <= write_cnt + 1;
                if write_cnt = 6 then	-- Wait for Data Validation (tDW:6*8ns=48ns)
                    write_cnt <= 0;
                    write <= "00";
                    CE <= '1';
                    WE <= '1';
                    OE <= '1';                          
                end if;
            end if;


            -- **Handle SRAM Read (Sending Data to Arduino)**
            if read = "01" then  
                read <= "10";  
                CE <= '0';  -- Enable SRAM
                WE <= '1';  -- Disable Write Mode
                OE <= '0';  -- Enable Read Mode
                SRAM_addr <= std_logic_vector(to_unsigned(index_r, 3)); -- Read Address
                LED_data  <= std_logic_vector(to_unsigned(index_r, 4)); -- Update LEDs
                index_r   <= index_r + 1;  -- Increment Read Index
                if index_r = 7 then index_r <= 0;  -- Reset at 8 samples
            end if;

            elsif read = "10" then  
                read_cnt <= read_cnt + 1;
                if read_cnt = 12 then  -- Wait for Data Validation (tACS:12*8ns=96ns)
                    read_cnt <= 0;
                    read <= "00";  
                    Start <= '1';  -- Send Data to Arduino
                    Data  <= SRAM_data;  -- Transfer Data
                    CE <= '1'; WE <= '1'; OE <= '1';  -- Disable SRAM
                end if;                            
            end if;
        end if;
    end process;
end Behavioral;
