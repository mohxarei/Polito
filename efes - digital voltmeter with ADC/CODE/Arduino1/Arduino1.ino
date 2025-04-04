#include <avr/interrupt.h>  // Include for AVR interrupt handling
#include <Wire.h> // I2C library for OLED communication
#include <Adafruit_GFX.h> // Graphics library for OLED
#include <Adafruit_SSD1306.h> // OLED display driver

// Define OLED display parameters
#define SCREEN_WIDTH 128  // OLED display width in pixels
#define SCREEN_HEIGHT 64  // OLED display height in pixels
#define OLED_RESET     -1 // No reset pin used (-1 for sharing Arduino reset)
#define SCREEN_ADDRESS 0x3C // OLED I2C address (0x3D for 128x64, 0x3C for 128x32)

// Initialize OLED display object
Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, OLED_RESET);

// Global variables for SPI and ADC data handling
byte data; // Variable to store the received byte from SPI (8-bit)
byte adcarray[8]; // Array to store sampled ADC values
int indexW = 0;   // Write index for ADC data storage
int indexR = 0;   // Read index for retrieving stored ADC values

void setup() {   // Runs only once on startup
  Serial.begin(115200);       // Initialize serial communication
  Serial.println("Start up!!!"); // Startup message for debugging
  pinMode(SS, INPUT_PULLUP); // Configure SPI Chip Select (SS) as an input with pull-up resistor

  // Initialize OLED display
  if (!display.begin(SSD1306_SWITCHCAPVCC, SCREEN_ADDRESS)) {
    Serial.println(F("SSD1306 allocation failed")); // Display initialization failure message
    for (;;); // Halt execution if OLED fails
  }  

  initSPI();  // Initialize SPI in slave mode (register level configuration)
  initADC();  // Initialize ADC in register level
  sei();      // Enable global interrupts for SPI communication

  // Display initial startup message
  display.clearDisplay();
  display.setTextSize(1);
  display.setTextColor(SSD1306_WHITE);
  display.println(F("Start up!!!"));
  display.display();
}

void loop() {    // Continuously runs (similar to while loop)
  uint16_t adcvalue = readADC(); // Read internal ADC value in real-time

  // Update OLED display
  display.clearDisplay();
  display.setCursor(0, 0);
  display.setTextSize(1);
  display.setTextColor(SSD1306_WHITE);

  display.print(F("ADC REAL-TIME: ")); // Display ADC label
  display.print(adcvalue);  // Show real-time ADC value

  display.setCursor(0, 10);         //
  display.print(F("SMPL: "));    // 
  display.print(indexW-1);              //
  
  display.setCursor(60, 10);         //
  display.print(F("DIS: "));    // 
  display.print(indexR-1);              //

  display.setCursor(0, 30); // Move cursor for FPGA ADC display
  display.print(F("FPGA ADC ----> "));
  display.print(data); // Show last received SPI data from FPGA

  display.setCursor(0, 40); // Move cursor for Arduino ADC display
  display.print(F("Arduino ADC -> "));
  display.print(adcarray[indexR]); // Show stored ADC value

  display.display();  
  delay(300); // Delay for readability

  // Optional: Implement averaging for better display output (DIY)
}

// Function to initialize SPI in slave mode at the register level
void initSPI() {
  DDRB &= ~(1 << DDB4);  // Set MISO (PB4) as an output

  // Configure SPI Control Register (SPCR)
  SPCR = (1 << 7)  // Enable SPI interrupt (SPIE=1)
       | (1 << 6); // Enable SPI module (SPE=1)

  // Configure SPI settings (clearing necessary bits)
  SPCR &= ~((1 << 5)  // MSB first (DORD=0)
          | (1 << MSTR)  // Set as SPI slave (MSTR=0)
          | (1 << 3)  // Clock polarity CPOL=0
          | (1 << 2)  // Clock phase CPHA=0
          | (1 << SPR1)  // Set SPI clock speed (SPR1, SPR0=0)
          | (1 << SPR0)); // SPI clock speed = 16MHz / 4 = 4MHz
}

// SPI Interrupt Service Routine (ISR) - Handles SPI data reception
ISR(SPI_STC_vect) {
  data = SPDR;  // Read received data from SPI Data Register (SPDR) and store in variable

  if (data == 115) { // If received value is 115 ('s' in ASCII), indicates sampling key pressed
    int value = readADC();  // Read internal ADC value
    value = map(value, 0, 1023, 0, 255); // Scale 10-bit ADC result to 8-bit
    // Cannot use bit-shifting (<<) since MSB would be lost
    adcarray[indexW] = value; // Store scaled ADC value in array

    Serial.print("IndexW ");
    Serial.println(indexW); // Print write index for debugging
    indexW++;
    if (indexW == 8) indexW = 0; // Reset index after storing 8 samples
  } 
  else { // If received data is not 's', it is an ADC value sent from FPGA
    Serial.print("IndexR ");
    Serial.println(indexR); // Print read index for debugging
    Serial.print("FPGA ADC: ");
    Serial.println(data); // Print received FPGA ADC value
    Serial.print("Arduino ADC: ");
    Serial.println(adcarray[indexR]); // Print stored Arduino ADC value
    Serial.println("#################################"); // Debug separator
    indexR++;
    if (indexR == 8) indexR = 0; // Reset index after reading 8 samples
  }
}

// Function to initialize the ADC at the register level
// Must reset Arduino each time FPGA resets
void initADC() {
  ADMUX = (1 << REFS0);          // Set reference voltage to AVCC (connected to VCC)
  ADMUX &= ~(1 << ADLAR);        // Right-adjust ADC result (LSB format)
  ADMUX |= (0 & 0x07);           // Select ADC channel (A0) - Datasheet reference: p282
  
  ADCSRA = (1 << ADEN)           // Enable ADC module
         | (1 << ADPS2);         // Set prescaler to 16 (16MHz / 16 = 1MHz ADC clock) - Datasheet reference: p285
}

// Function to read ADC value without using analogRead() (manual ADC conversion)
uint16_t readADC() {
  ADCSRA |= (1 << ADSC);         // Start ADC conversion (single conversion mode)
  while (ADCSRA & (1 << ADSC));  // Wait until conversion is complete (bit clears when done)
  return ADC;                    // Return the ADC result
}
