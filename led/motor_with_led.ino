#include <SPI.h>
#include <SD.h>
#include <SoftwareSerial.h>
#include <DFPlayerMini_Fast.h>
#include <Adafruit_NeoPixel.h>

#include <Adafruit_PWMServoDriver.h>
#include <Wire.h>

#define SERVO_FREQ 50 // Analog servos run at ~50 Hz updates
#define PIN 4
#define NUM_LEDS 49

Adafruit_PWMServoDriver pwm = Adafruit_PWMServoDriver(0x40);
Adafruit_NeoPixel strip = Adafruit_NeoPixel(NUM_LEDS, PIN, NEO_GRB | NEO_KHZ800);

SoftwareSerial mySerial(10, 11); // RX, TX
DFPlayerMini_Fast myMP3;

int pinCS = 53;
int trig = 0;
int j = 0;

unsigned int ang1;
unsigned int ang2;
unsigned int ang3;
unsigned int ang4;
unsigned int pos;

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
  
}

void loop(){
    unsigned long previous_time = 0;
    File dataFile = SD.open("me_60.txt");
    if (dataFile) {

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

          trig += 1;

        while (1){
          unsigned long current_time = millis();
          if (current_time - previous_time >= 20){
              Serial.println(current_time - previous_time);
              
              if (trig ==1){
                myMP3.play(7);
              }
              
              for(int i=0; i<=NUM_LEDS; i++){
                 strip.setPixelColor(i, strip.Color(15, 15, 15));
              }
              
              sel_range();
              strip.show();
              strip.clear(); 

              pwm.setPWM(servo1, 0, ang1+90); 
              pwm.setPWM(servo2, 0, ang2+90);
              pwm.setPWM(servo3, 0, ang3+90);
              pwm.setPWM(servo4, 0, ang4+90);

              previous_time = current_time;
              break;
          }
        }
     }
   }
}

void sel_range(){
   
    if (pos == 1){
      j = pos - 1;
      for(int i=j*7; i<j*7+7; i++){
      strip.setPixelColor(i, strip.Color(255,255,255));
      } 
    }
    else if (pos == 2){
      j = pos - 1;
      for(int i=j*7; i<j*7+7; i++){
      strip.setPixelColor(i, strip.Color(255,255,255));
      } 
    }
    else if (pos == 3){
      j = pos - 1;
      for(int i=j*7; i<j*7+7; i++){
      strip.setPixelColor(i, strip.Color(255,255,255));
      } 
    }
    else if (pos == 4){
      j = pos - 1;
      for(int i=j*7; i<j*7+7; i++){
      strip.setPixelColor(i, strip.Color(255,255,255));
      } 
    }
    else if (pos == 5){
      j = pos - 1;
      for(int i=j*7; i<j*7+7; i++){
      strip.setPixelColor(i, strip.Color(255,255,255));
      } 
    }
    else if (pos == 6){
      j = pos - 1;
      for(int i=j*7; i<j*7+7; i++){
      strip.setPixelColor(i, strip.Color(255,255,255));
      } 
    }
    else if (pos == 7){
      j = pos - 1;
      for(int i=j*7; i<j*7+7; i++){
      strip.setPixelColor(i, strip.Color(255,255,255));
      } 
    }
    else {
      for(int i=0; i<=NUM_LEDS; i++){
         strip.setPixelColor(i, strip.Color(155, 155, 155));
      }
    }
}
