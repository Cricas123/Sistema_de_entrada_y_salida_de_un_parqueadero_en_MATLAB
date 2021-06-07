#include <Servo.h>

Servo servoInstance;

int ang;
int increasing = 1;

void setup() {
  servoInstance.attach(3);
  Serial.begin(9600);
}

void loop() {

  if(increasing)
    ang++;
  else
    ang--;

  Serial.println(ang);

  if(ang<=1) {
    ang = 1;
    increasing = 1;
    delay(200);
  }

  if(ang>=180) {
    ang = 180;
    increasing = 0;
    delay(200);
  }

  servoInstance.write(ang);
  
  delay(10);
}
