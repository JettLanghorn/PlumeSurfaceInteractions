#include <Stepper.h>
const int stepsPerRev = 200;
int Apos = 13;
int Aneg = 12;
int Bpos = 11;
int Bneg = 10;
int zeroRef = 4;
int relay = 7;
int steps = 0;
int height = 0;
int stepCount = 0;
int stepsRemain = 0;
int menuNav = 0;
int testTime = 30000;
Stepper myStepper(stepsPerRev, Apos, Aneg, Bpos, Bneg);

void killSignals () {
  digitalWrite(Apos, LOW);
  digitalWrite(Aneg, LOW);
  digitalWrite(Bpos, LOW);
  digitalWrite(Bneg, LOW);
  digitalWrite(relay, LOW);
}

int promptNum () {
  while (Serial.available() <= 0) {
  }
  int temp = Serial.parseInt();
  Serial.parseInt();
  return temp;
}

void setup() {
  myStepper.setSpeed(20);
  pinMode(Apos, OUTPUT);
  pinMode(Aneg, OUTPUT);
  pinMode(Bpos, OUTPUT);
  pinMode(Bneg, OUTPUT);
  pinMode(zeroRef, INPUT);
  pinMode(relay, OUTPUT);
  Serial.begin(9600);
  
  Serial.println("Welcome! Enter anything to begin calibration.");
  promptNum();
  Serial.println("Calibrating...");

  //while (digitalRead(zeroRef)==LOW) {
  //  myStepper.step(-10);
  //  delay(10);
  //}
  
  killSignals();
}

// the loop function runs over and over again forever
void loop() {
  Serial.println("Please Select:");
  Serial.println("1 to ADJUST HEIGHT");
  Serial.println("2 to FIRE");

  menuNav = promptNum();
  Serial.println(menuNav);
  
  switch (menuNav) {
  case 1:
    Serial.println("Enter the number of steps you would like to take");
    steps = promptNum();
    myStepper.step(steps);
    delay(1000);
    killSignals();
    break;
  case 2:
    digitalWrite(relay, HIGH);
    delay(testTime);
    digitalWrite(relay, LOW);
    break;
  default:
    Serial.println("Please select one of the options listed");
    break;
}

}
