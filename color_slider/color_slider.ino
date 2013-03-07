int sliderPin1 = A0;//Red
int sliderPin2 = A1;//Green
int sliderPin3 = A2;//Blue
int sliderPin4 = A3;//Alpha

int gPin = 9;
int rPin = 10;
int bPin = 11;

int fillButtonPin = 2;
int saveButtonPin = 3;
boolean fillButtonPressed = false;
boolean saveButtonPressed = false;

int sensorValue = 0;  // variable to store the value coming from the sensor

int rHigh = 512;
int rLow = 512;

void setup() {
  
  Serial.begin(1200);
  
  rHigh = analogRead(sliderPin1);
  rLow = analogRead(sliderPin1);
  
}

void loop() {
  
  // read the value from the sensor:
  int sensor1Value = analogRead(sliderPin1);   
  int sensor2Value = analogRead(sliderPin2);   
  int sensor3Value = analogRead(sliderPin3);   
  int sensor4Value = analogRead(sliderPin4);

  //For calibrating range:
  //println(sensor1Value);
  
  int r = map(sensor1Value, 0, 1023, 0, 255);
  int g = map(sensor2Value, 0, 1023, 0, 255);
  int b = map(sensor3Value, 0, 1023, 0, 255);
  int a = map(sensor4Value, 0, 1023, 0, 255);
  
   //For calibrating range:
  //println(r);
  
  int rLight = map(sensor1Value, 0, 1023, 0, 128);
  int gLight = map(sensor2Value, 0, 1023, 0, 128);
  int bLight = map(sensor3Value, 0, 1023, 0, 128);
  
  analogWrite(rPin, rLight);
  analogWrite(gPin, gLight);
  analogWrite(bPin, bLight);
  
  String msg = "";
  msg += r;
  msg+=",";
  msg+=g;
  msg+=",";
  msg+=b;
  msg+=",";
  msg+=a;
  msg+=",";
  
  String fill = "";
  fill+="0,";
  String save = "";
  save+="0";
    //Fill & Save button logic:
  if(digitalRead(fillButtonPin)==HIGH && !fillButtonPressed){
    //Serial.println("Fill");
    fillButtonPressed = true;
    fill="";
    fill+='1,';
  }
   if(digitalRead(saveButtonPin)==HIGH && !saveButtonPressed){
    //Serial.println("Save");
    saveButtonPressed = true;
    save = "";
    save+='1';
  }
  //To avoid multiple presses:
  if(digitalRead(fillButtonPin)==LOW && fillButtonPressed){
    fillButtonPressed = false;
  }
   if(digitalRead(saveButtonPin)==LOW && saveButtonPressed){
    saveButtonPressed = false;
  }
  
  msg+=fill;
  msg+=save;
  Serial.println(msg);

  
  delay(200);
               
}
