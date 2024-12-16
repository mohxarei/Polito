#include <avr/interrupt.h>  // Include for interrupt handling
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
#define SCREEN_WIDTH 128 // OLED display width, in pixels
#define SCREEN_HEIGHT 64 // OLED display height, in pixels
#define OLED_RESET     -1 // Reset pin # (or -1 if sharing Arduino reset pin)
#define SCREEN_ADDRESS 0x3C ///< See datasheet for Address; 0x3D for 128x64, 0x3C for 128x32
Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, OLED_RESET);

byte data; // Variable to store the received byte from SPI
byte adcarray[8];
int indexW = 0;
int indexR = 0;

void setup() {
  Serial.begin(115200);       // Initialize serial communication at 115200 baud
  Serial.println("Start up!!!");
  pinMode(SS, INPUT_PULLUP);
  // SSD1306_SWITCHCAPVCC = generate display voltage from 3.3V internally
  if(!display.begin(SSD1306_SWITCHCAPVCC, SCREEN_ADDRESS)) {
    Serial.println(F("SSD1306 allocation failed"));
    for(;;); // Don't proceed, loop forever
  }  
  initSPI();                  // Initialize SPI in slave mode
  initADC();                  // Initialize ADC
  sei();                      // Enable global interrupts
  display.clearDisplay();
  display.setTextSize(1);
  display.setTextColor(SSD1306_WHITE);
  //display.setCursor(10, 0);
  display.println(F("Start up!!!"));
  display.display();
}

void loop() {
  uint16_t adcvalue = readADC();
  display.clearDisplay();
  display.setCursor(0, 0);
  display.setTextSize(1);
  display.setTextColor(SSD1306_WHITE);
  display.print(F("ADC "));
  display.print(adcvalue);
  display.setCursor(0, 10);
  display.print(F("FPGA ADC "));
  display.print(data);
  display.setCursor(0, 20);
  display.print(F("Arduino ADC "));
  display.print(adcarray[indexR]);
  display.display();  
  delay(300);
}

// Function to initialize SPI in slave mode
void initSPI() {
  DDRB &= ~(1 << DDB4);       // Set MISO (PB4) as output
  SPCR = (1 << 6)           // Enable SPI
       | (1 << 7);         // Enable SPI interrupt
  SPCR &= ~(1<<3);
}

// SPI interrupt service routine
ISR(SPI_STC_vect) {
  data = SPDR;  // Read received data from SPI Data Register
  
  if (data == 115) {
    int value = readADC();                 // Read ADC value directly
    value = map(value, 0, 1023, 0, 255);   // Scale the ADC result
    adcarray[indexW] = value;
    Serial.print("IndexW ");
    Serial.println(indexW);
    indexW++;
    if (indexW == 8) indexW = 0;
  } else {
    Serial.print("IndexR ");
    Serial.println(indexR);
    Serial.print("FPGA ADC: ");
    Serial.println(data); 
    Serial.print("Arduino ADC: ");
    Serial.println(adcarray[indexR]);
    Serial.println("#################################"); 
    indexR++;
    if (indexR == 8) indexR = 0;
  }
}

// Function to initialize the ADC
void initADC() {
  ADMUX = (1 << REFS0);          // Set reference voltage to AVCC
  ADMUX &= ~(1 << ADLAR);        // Right adjust the ADC result
  ADMUX |= (0 & 0x07);           // Select ADC channel (A0 here)
  
  ADCSRA = (1 << ADEN)           // Enable ADC
         | (1 << ADPS2)          // Set prescaler to 16 (for 16 MHz CPU, gives 1 MHz ADC clock);
}

// Function to read ADC value without analogRead
uint16_t readADC() {
  ADCSRA |= (1 << ADSC);         // Start conversion
  while (ADCSRA & (1 << ADSC));  // Wait for conversion to complete
  return ADC;                    // Return the ADC value
}
