// the setup function runs once when you press reset or power the board
int Apos = 13;
int Aneg = 12;
int Bpos = 11;
int Bneg = 10;
float steps = 0;


void setup() {
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
  digitalWrite(Out1, HIGH);
  digitalWrite(Out2, HIGH);
  
  Serial.println("Enter a height in thousands of an inch");
  while (Serial.available() <= 0) {
  }

  number = map(Serial.parseInt(), 0, 3824, LowRef, HighRef);
  //Serial.println(number);
  Serial.parseInt();
  CurrentPos = analogRead(A1);
  
  if ((number < HighRef) && (number >= LowRef)) {
    while (number > CurrentPos) {
      digitalWrite(Out1, LOW);
      digitalWrite(Out2, HIGH);
      delay(20);
      CurrentPos = analogRead(A1);
      //Serial.println(CurrentPos);
    }
    
    while (number < CurrentPos) {
      digitalWrite(Out1, HIGH);
      digitalWrite(Out2, LOW);
      delay(20);
      CurrentPos = analogRead(A1);
      //Serial.println(CurrentPos);
    }

    digitalWrite(Out1, HIGH);
    digitalWrite(Out2, HIGH);
    delay(2000);
    Serial.print("Current Height: ");
    Serial.println(map(analogRead(A1), LowRef, HighRef, 0, 3824));
    //Serial.println(analogRead(A1));
    
  } else {
    Serial.println("Please enter a height between 0 and 3824 in thousand of an inch");
  }

}
