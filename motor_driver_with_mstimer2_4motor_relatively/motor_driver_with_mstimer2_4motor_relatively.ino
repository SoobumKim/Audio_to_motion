#include <MsTimer2.h>
#include <SPI.h>
#include <SD.h>
#include <SoftwareSerial.h>
#include <DFPlayerMini_Fast.h>

#include <Adafruit_PWMServoDriver.h>
#include <Wire.h>

Adafruit_PWMServoDriver pwm = Adafruit_PWMServoDriver(0x40);

#define SERVO_FREQ 50 // Analog servos run at ~50 Hz updates

SoftwareSerial mySerial(10, 11); // RX, TX
DFPlayerMini_Fast myMP3;

int pinCS = 53;

unsigned int ang1[800];
unsigned int ang2[800];
unsigned int ang3[800];
unsigned int ang4[800];

uint8_t servo1 = 0;
uint8_t servo2 = 1;
uint8_t servo3 = 2;
uint8_t servo4 = 3;

unsigned int cnt = 0;
unsigned int i = 0;

void setup() {

  Serial.begin(115200); 

  mySerial.begin(9600); //소프트웨어 시리얼 용도
  myMP3.begin(mySerial);
  myMP3.volume(25);
  
  pinMode(pinCS,OUTPUT);
  SD.begin();
  myMP3.pause();
  //myMP3.play(1);

  File dataFile = SD.open("SOS_16_leaves.txt");
    if (dataFile) {
      while (dataFile.available())
      {
        unsigned long ch1 = dataFile.parseInt();
        ang1[cnt] = ch1; 
        unsigned long ch2 = dataFile.parseInt();
        ang2[cnt] = ch2; 
        unsigned long ch3 = dataFile.parseInt();
        ang3[cnt] = ch3; 
        unsigned long ch4 = dataFile.parseInt();
        ang4[cnt] = ch4; 

        cnt++;
      }
      dataFile.close();
    }
        
  pwm.begin();
  pwm.setOscillatorFrequency(25000000);   // int.osc.은 27MH에 가까움
  pwm.setPWMFreq(SERVO_FREQ);             // 서보모터 기본 주기 : 50hz 설정

  myMP3.play(6);
  //Serial.println('a');
  MsTimer2::set(20, intCallBack); //(ms, function name)
  MsTimer2::start();//start
}

void loop(){
  Serial.println(ang1[i]);
  pwm.setPWM(servo1, 0, ang1[i]+150); 
  pwm.setPWM(servo2, 0, ang2[i]+150);
  pwm.setPWM(servo3, 0, ang3[i]+150);
  pwm.setPWM(servo4, 0, ang4[i]+150);
  }

void intCallBack() {
  //Serial.println('b');
  i++;
  if(i == 800){
    i = 0;
  }
  if(i == 0){
    myMP3.play(6);
  }
}
