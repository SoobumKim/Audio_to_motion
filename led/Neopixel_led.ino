#include <MsTimer2.h>
#include <SPI.h>
#include <SD.h>
#include <SoftwareSerial.h>
#include <DFPlayerMini_Fast.h>
#include <Adafruit_NeoPixel.h>

#include <Adafruit_PWMServoDriver.h>
#include <Wire.h>

#define SERVO_FREQ 50 // Analog servos run at ~50 Hz updates
#define PIN 4
#define NUM_LEDS 60

Adafruit_PWMServoDriver pwm = Adafruit_PWMServoDriver(0x40);
Adafruit_NeoPixel strip = Adafruit_NeoPixel(NUM_LEDS, PIN, NEO_GRB | NEO_KHZ800);

SoftwareSerial mySerial(10, 11); // RX, TX
DFPlayerMini_Fast myMP3;

int pinCS = 53;
int flag = 1;
int j;

unsigned int ang1; unsigned int pre_ang1;
unsigned int ang2; unsigned int pre_ang2;
unsigned int ang3; unsigned int pre_ang3;
unsigned int ang4; unsigned int pre_ang4;
unsigned int pos; unsigned int pre_pos;

uint8_t servo1 = 0;
uint8_t servo2 = 1;
uint8_t servo3 = 2;
uint8_t servo4 = 3;

void setup() {

  Serial.begin(115200); 

  mySerial.begin(9600); //소프트웨어 시리얼 용도
  myMP3.begin(mySerial);
  myMP3.volume(25);
  
  pinMode(pinCS,OUTPUT);
  SD.begin();
  myMP3.pause();
  
  strip.begin();
  strip.show(); // Initialize all pixels to 'off'

  pwm.begin();
  pwm.setOscillatorFrequency(25000000);   // int.osc.은 27MH에 가까움
  pwm.setPWMFreq(SERVO_FREQ);             // 서보모터 기본 주기 : 50hz 설정
  
  MsTimer2::set(20, intCallBack); //(ms, function name)
  MsTimer2::start();//start
  
  myMP3.play(1);
  
}

void loop(){
    File dataFile = SD.open("SOS_60.txt");
    if (dataFile) {
       if (1) { 
          while (dataFile.readStringUntil('\n'))
          {
            unsigned long ch1 = dataFile.parseInt();
            ang2 = ch1; 
            unsigned long ch2 = dataFile.parseInt();
            ang3 = ch2; 
            unsigned long ch3 = dataFile.parseInt();
            ang4 = ch3; 
            unsigned long ch4 = dataFile.parseInt();
            pos = ch4; 
            unsigned long ch5 = dataFile.parseInt();
            ang1 = ch5;
            
            pwm.setPWM(servo1, 0, ang1+90); 
            pwm.setPWM(servo2, 0, ang2+90);
            pwm.setPWM(servo3, 0, ang3+90);
            pwm.setPWM(servo4, 0, ang4+90);
  
            delay(15);  
         }
       }
    }
}

void intCallBack() {
  sel_range();

  strip.show();
  strip.clear(); 
}

void sel_range(){
   
    if (ang2){
      for(int i=0; i<NUM_LEDS/4; i++){
      strip.setPixelColor(i, strip.Color(255/125*ang2, 0, 0));
      } 
    }
    if (ang3){
      for(int i=NUM_LEDS/4; i<NUM_LEDS/4*2; i++){
      strip.setPixelColor(i, strip.Color(255/125*ang3, 125/125*ang3, 0));
      } 
    }
    if (ang4){
      for(int i=NUM_LEDS/4*2; i<NUM_LEDS/4*3; i++){
      strip.setPixelColor(i, strip.Color(0, 255/125*ang4, 0));
      } 
    }
    if (ang1){
      j = pos - 1;
      for(int i=NUM_LEDS/4*3; i<NUM_LEDS/4*4; i++){
      strip.setPixelColor(i, strip.Color(0, 0, 255/125*ang1));
      } 
    }
    if (ang1 == 0 && ang2 == 0 && ang3 == 0 && ang4 == 0){
      for(int i=0; i<=NUM_LEDS; i++){
         strip.setPixelColor(i, strip.Color(0, 0, 0));
      }
    }
}
