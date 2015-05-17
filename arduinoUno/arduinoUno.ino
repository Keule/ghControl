int led = 2;
int humidAnalog = 0;
int humidDigital = 7;

String inputString = "";
int eof = 90;

  
void setup() {
  // put your setup code here, to run once:
  pinMode(led, OUTPUT);
  pinMode(humidDigital, INPUT);  
 Serial.begin(9600);  

}



void loop() {
/*  
  digitalWrite(led, LOW);    // turn the LED off by making the voltage LOW
  delay(1000);               // wait for a second
  digitalWrite(led, HIGH);   // turn the LED on (HIGH is the voltage level)  
  delay(1000);   
*/

//  int valDigital = digitalRead(humidDigital);   // read the input pin
//  Serial.print(valDigital,DEC);

//  float valAnalog = analogRead(humidAnalog);    // read the input pin
//  Serial.print(valAnalog,DEC);


  if (Serial.available() > 0){
    String input = loadInputStream();
    if (input.length() > 0){
       int commandID =  commandIDForString(input);
      executeCommandID(commandID, input);       
    }
  }
}

String loadInputStream(){
  while (inputString.length() < 20 && Serial.available() > 0) {
      char character = Serial.read();
      if (character == eof){
        if (inputString.length() >= 3){
          return (inputString);
        }
        else{
           printCommandBufferUnderflow();
        }
        inputString = "";        
        return "";
      }
      else{
//        inputString.concat(i);
        inputString += character;        
      }      
    }  
    if (inputString.length() >= 20){
      printCommandBufferOverflow();  
      inputString = "";      
    }  
    return "";
}

void printCommandBufferOverflow(){
    Serial.print(24);
    Serial.write(eof);
}

void printCommandBufferUnderflow(){
  printCommandBufferOverflow();
}

void executeCommandID(int commandID, String information){
          Serial.println ("---EXECUTE---");          
          Serial.write ("String: ");          
          Serial.print(inputString); 
          Serial.write ("command: ");          
          Serial.print(commandID);           
}
void writeStringOnSerial(String string){
  char* buf;
  string.toCharArray(buf, string.length()+1); // **CRASH** buf is not allocated!
 // Serial.write(buf,string.length);
}

int intForChars(int char0, int char1, int char2){
    return char0*100 + char1*10 + char2 *1;
}
  
int commandIDForString(String string){
  int char0 =  string.charAt(0) - '0';
  int char1 =  string.charAt(1) - '0';
  int char2 =  string.charAt(2) - '0';  
  return intForChars(char0, char1, char2);
}  
