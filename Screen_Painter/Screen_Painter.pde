/* --------------------------------------------------------------------------
 * SimpleOpenNI DepthImage Test
 * --------------------------------------------------------------------------
 * Processing Wrapper for the OpenNI/Kinect library
 * http://code.google.com/p/simple-openni
 * --------------------------------------------------------------------------
 * prog:  Max Rheiner / Interaction Design / zhdk / http://iad.zhdk.ch/
 * date:  02/16/2011 (m/d/y)
 * ----------------------------------------------------------------------------
 */

import SimpleOpenNI.*;
import processing.serial.*;
int linefeed=10;
Serial myPort;

  int redVal = 0;
  int greenVal = 0;
  int blueVal = 0;
  int alphaVal = 255;
  char selectedColor = 'k';

SimpleOpenNI  context;

void setup()
{
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[4], 1200);
  myPort.bufferUntil(linefeed);
  
  context = new SimpleOpenNI(this);
   
  // mirror is by default enabled
  context.setMirror(true);
  
  // enable depthMap generation 
  if(context.enableDepth() == false)
  {
     println("Can't open the depthMap, maybe the camera is not connected!"); 
     exit();
     return;
  }

 
  fill(255,0,0);
  size(640, 480); 
}

void draw()
{
  // update the cam
  context.update();
  
  
  PImage depthImage = context.depthImage();
  
  // draw depthImageMap
 // image(depthImage,0,0);
  
  int maxX=0;
  int maxY=0;
  float maxVal=0;
  
  
  noStroke();

  
  
  
//  for(int x=0; x < 640; x++){
//     for(int y = 0; y< 480; y++){
//        color c = get(x,y);
//        if(brightness(c)>maxVal){
//           maxX=x;
//           maxY=y;
//           maxVal=brightness(c);
//        }
//     } 
//  }
//  fill(255,0,0);
//  ellipse(maxX, maxY, 20, 20);
  
  //
  int[] depthValues = context.depthMap();
  
  
  
  
//  
  for(int x=0; x < 640; x++){
     for(int y = 0; y< 480; y++){
        int depthValue = depthValues[y*640+x];
        if(depthValue<750 && depthValue!=0){
          
//        int position = mouseX + (mouseY*640);
//        int depth = depthValues[position];
//        
       // if(brightness(c)>200){
          drawCircleFor(x,y, depthValue);
          //           maxX=x;
//           maxY=y;
//           maxVal=brightness(c);
        }
     } 
  }
//  fill(255,0,0);
//  ellipse(maxX, maxY, 20, 20);
//  
  
//  
}

void mousePressed(){
  
  int[] depthValues = context.depthMap();
  int clickPosition = mouseX + (mouseY*640);
  int clickedDepth = depthValues[clickPosition];
  
  float inches = clickedDepth/25.4;
  
  println("milimeters: "+clickedDepth+" inches: "+inches);
//  
//   color c = get(mouseX, mouseY);
//  println("brightness: "+brightness(c));
}

void drawCircleFor(int anX, int aY, int aDepth){
  float penSize = (750-aDepth)/45;

  fill(redVal,greenVal,blueVal, penSize);
    
  ellipse(anX, aY, 2, 2);
}

void keyPressed(){
  char r = 'r';
  char g = 'g';
  char b = 'b';
  char k = 'k';
  char q = 'q';
  char s = 's';
  println("Pressed "+key);
  if(key==r){
    if(redVal!=255){
      redVal=255;
    }else{
      redVal=0;
    }
  }
  if(key==g){
    if(greenVal!=255){
      greenVal=255;
    }else{
      greenVal=0;
    }
  }
  if(key==b){
    if(blueVal!=255){
      blueVal=255;
    }else{
      blueVal=0;
    }
  }
  if (key==k){
    redVal=0;
    greenVal=0;
    blueVal=0;
  }
  if(key==q){
    fill(redVal,greenVal,blueVal);
    background(0);
  }
  if(key==s){
     save(int(random(100000))+"drawing.png"); 
  }
   println("R:"+redVal+"G:"+greenVal+"B:"+blueVal);
}

void serialEvent(Serial myPort){
  String myString = myPort.readStringUntil(linefeed);
  
  if(myString != null){
    myString = trim(myString);
    
    int sensors[] = int(split(myString, ','));
//    for (int sensorNum = 0; sensorNum < sensors.length; sensorNum++){
//      print("Sensor "+sensorNum+ ": "+ sensors[sensorNum] + "\t");
//    }
//    println();
  
    redVal = sensors[0];
    greenVal = sensors[1];
    blueVal = sensors[2];
    alphaVal = sensors[3];
    String colorString = "";
    colorString+="Red: ";
    colorString+=redVal;
   println(colorString);
    
    if(sensors[4]==1){
      fill(redVal,greenVal,blueVal);
      background(0);
    }
    if(sensors[5]==1){
      save("/./images/"+int(random(100000))+"drawing.png"); 
    }
    
  }
}
