library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SPI_Master is
    port(
        sys_clk     : in    std_logic; 
        spi_mosi    : out   std_logic;
        spi_sck     : out   std_logic;
        spi_ss      : out   std_logic;
        data_in     : in    std_logic_vector(7 downto 0);
        start_trans : in    std_logic
    );
end SPI_Master;

architecture Behavioral of SPI_Master is
    type state_type is (IDLE, LOAD, SEND, COMPLETE);
    signal current_state : state_type := IDLE;
    signal bit_index     : integer range 0 to 8 := 8;
    constant CLOCK_DIV   : integer := 31;
    signal clk_counter   : integer range 0 to 30:= 0;
    signal sck_pulse     : std_logic := '1';
    signal extended_data: std_logic_vector(8 downto 0);
begin
    extended_data(7 downto 0) <= data_in;
    extended_data(8) <= '0';
    process(sys_clk)
    begin
        if rising_edge(sys_clk) then
            case current_state is
                when IDLE =>
                    spi_ss    <= '1';
                    spi_sck   <= '0';
                    spi_mosi  <= '0';
                    sck_pulse <= '0';
                    if start_trans = '1' then
                        current_state <= LOAD;
                    end if;

                when LOAD =>
                    spi_ss    <= '0';
                    bit_index <= 8;
                    spi_mosi  <= extended_data(bit_index);
                    clk_counter <= 0;
                    sck_pulse <= '0';
                    current_state <= SEND;

                when SEND =>
                    clk_counter <= clk_counter + 1;
                    spi_mosi <= extended_data(bit_index);
                      if clk_counter = (CLOCK_DIV / 2) then
                        sck_pulse <= not sck_pulse;
                        spi_sck <= sck_pulse;
                        clk_counter <= 0;
                        if sck_pulse = '0' then
                            bit_index <= bit_index-1;
                            if bit_index = 0 then
                                current_state <= COMPLETE;
                            end if;
                        end if;
                      end if;              
                when COMPLETE =>
                    spi_ss <= '1';
                    current_state <= IDLE;
            end case;
        end if;
    end process;
end Behavioral;