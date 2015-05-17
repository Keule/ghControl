int led = 2;
int humidAnalog = 0;
int humidDigital = 7;
int i = 0;

void setup() {
  // put your setup code here, to run once:
  pinMode(led, OUTPUT);
  pinMode(humidDigital, INPUT);  
 Serial.begin(9600);  
 i= 0;
}

void loop() {
  // put your main code here, to run repeatedly:
  digitalWrite(led, HIGH);   // turn the LED on (HIGH is the voltage level)
  delay(1);               // wait for a second
//  int bytesSent = Serial.write(" ");
//  Serial.println();

  digitalWrite(led, LOW);    // turn the LED off by making the voltage LOW
  
  
  int valDigital = digitalRead(humidDigital);   // read the input pin
  
  Serial.print("digital: ");
  Serial.print(valDigital,DEC);
  Serial.println();

  float valAnalog = analogRead(humidAnalog);    // read the input pin

  
  Serial.print("analog: ");
  Serial.print(valAnalog,DEC);
  Serial.println();

  
  if (Serial.available() > 0) {
                // read the incoming byte:
                i = Serial.read();

                // say what you got:
                Serial.print("I received: ");
                Serial.write(i);
                Serial.write(" ");                
                Serial.println(i, DEC);

        Serial.println();                
        }
        
  delay(1000);
}





