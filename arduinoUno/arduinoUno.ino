const int COMMAND_SENSOR_LIST = 1;
const int COMMAND_ACTOR_LIST = 3;
const int COMMAND_ACTOR_SET_VALUE = 5;

const int ID_SENSOR_HUMIDITY_DIGITAL = 0;
const int ID_SENSOR_HUMIDITY_ANALOG = 1;

const int SENSOR_TYPE_HUMIDITY_ANALOG = 0;
const int SENSOR_TYPE_HUMIDITY_DIGITAL = 1;

const int ID_ACTOR_LED = 0;

const int ACTOR_TYPE_LED = 0;

#include <avr/wdt.h>

int led = 2;
int humidAnalog = 0;
int humidDigital = 7;

String inputString = "";
int eof = 'Z';

void setup() {
  // put your setup code here, to run once:
  pinMode(led, OUTPUT);
  pinMode(humidDigital, INPUT);  
  Serial.begin(9600);  
  wdt_enable(WDTO_8S);
}

void loop() {
//TOBI
/*
executeCommandListSensor();
  delay(1000);   
  */
//  

  if (Serial.available() > 0){
    String input = loadInputStream();
    if (input.length() > 0){
       int commandID =  commandIDForString(input,0,1,2);
        executeCommandID(commandID, input); 
        inputString = "";
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

void printActorNotFound(){
  printCommandBufferOverflow();  
}

void executeCommandID(int commandID, String information){
  wdt_reset();  
  Serial.print ("---EXECUTE---");          
  newline();          

  Serial.write ("COMMAND: ");          
  Serial.print(commandID);           
  Serial.write (" (complete: ");          
  Serial.print(inputString);         
  Serial.write (")");
  
  if (commandID == COMMAND_SENSOR_LIST){
      executeCommandListSensor();
  }
  else if (commandID == COMMAND_ACTOR_LIST){
      executeCommandListActor();    
  }
  else if (commandID == COMMAND_ACTOR_SET_VALUE){
    int actorID = commandIDForString(information,4,5,6);
    int value = commandIDForString(information,8,9,10);
     executeCommandSetActor(actorID, value);
  }   
}

void executeCommandListSensor(){
  Serial.print(COMMAND_SENSOR_LIST+1);
  newline();  
   
  int valDigital = digitalRead(humidDigital);   // read the input pin
  int valAnalog = analogRead(humidAnalog);    // read the input pin
   
  printInformationLine(ID_SENSOR_HUMIDITY_DIGITAL, valDigital, SENSOR_TYPE_HUMIDITY_DIGITAL, 1);
  printInformationLine(ID_SENSOR_HUMIDITY_ANALOG, valAnalog, SENSOR_TYPE_HUMIDITY_ANALOG, 1);  
     
  Serial.write(eof);
}

void printInformationLine(int id, int value, int type, int status){
    Serial.print(id);
    Serial.write(",");
    Serial.print(type);
    Serial.write(",");
    Serial.print(value,DEC);
    Serial.write(",");
    Serial.print(status);  
    newline();
}

void executeCommandListActor(){
  Serial.print(COMMAND_ACTOR_LIST+1);  
  newline();  
  printInformationLine(ID_ACTOR_LED, digitalRead(led), ACTOR_TYPE_LED, 1);
  Serial.write(eof);   
}

void executeCommandSetActor(int actorID, int value){
  if (actorID == ID_ACTOR_LED){
     if (value == 1){
      digitalWrite(led, HIGH);  
     }      
     else{
      digitalWrite(led, LOW);          
     }
  }
  else{
    printActorNotFound();
    return;
  }
    
  Serial.print(COMMAND_ACTOR_SET_VALUE+1);  
  newline();
  Serial.write(eof);   
}

int intForChars(int char0, int char1, int char2){
    return char0*100 + char1*10 + char2 *1;
}
  
int commandIDForString(String string, int position0, int position1, int position2){
  int char0 =  string.charAt(position0) - '0';
  int char1 =  string.charAt(position1) - '0';
  int char2 =  string.charAt(position2) - '0';  
  return intForChars(char0, char1, char2);
}  

void blinkLED(){
  digitalWrite(led, HIGH);   
  delay(1);              
  digitalWrite(led, LOW); 
  delay(40);              
  digitalWrite(led, HIGH);
  delay(1);               
  digitalWrite(led, LOW); 
  delay(3000);   
}  

void newline(){
   Serial.write("\n"); 
}
