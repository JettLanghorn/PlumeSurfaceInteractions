// the setup function runs once when you press reset or power the board
#include <Stepper.h>
const int stepsPerRev = 200;
int Apos = 13;
int Aneg = 12;
int Bpos = 11;
int Bneg = 10;
int steps = 0;
int stepCount = 0;
Stepper myStepper(stepsPerRev, Apos, Aneg, Bpos, Bneg);

void setup() {
  myStepper.setSpeed(60);
  pinMode(Apos, OUTPUT);
  pinMode(Aneg, OUTPUT);
  pinMode(Bpos, OUTPUT);
  pinMode(Bneg, OUTPUT);
  Serial.begin(9600);
  Serial.println("Welcome! Enter anything to begin calibration.");
  while (Serial.available() <= 0) {
  }
  Serial.parseInt();
  Serial.parseInt();
  Serial.println("Calibrating...");
  digitalWrite(Apos, LOW);
  digitalWrite(Aneg, LOW);
  digitalWrite(Bpos, LOW);
  digitalWrite(Bneg, LOW);
}

// the loop function runs over and over again forever
void loop() {
  Serial.println("Enter the number of steps");
  while (Serial.available() <= 0) {
  }
  steps = Serial.parseInt();
  Serial.parseInt();
  Serial.println(steps);
  //for (int i=0; i<steps; i++){
    myStepper.step(steps);
    //stepCount++;
    //delay(10);
  //}
}
