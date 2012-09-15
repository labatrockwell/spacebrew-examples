String server="ec2-184-72-140-184.compute-1.amazonaws.com";
String name="processingPowertail";
String description ="This is an example client that has a powertail and a light atteched and it turns on the light via the power tail.";
import processing.serial.*;

Serial myPort;  // Create object from Serial class
boolean poweswitchState = false;

SpacebrewClient c;
int numClicks = 0;
int sec0;

boolean toSend = false;
String stringSend = " Button Time ";

void setup() {
  frameRate(240);
  size(600, 400);
  
  c = new SpacebrewClient( this );
  
  // add each thing you publish and subscribe to
  c.addPublish( "procPressTesting", toSend );
  c.addPublish( "currentPower", poweswitchState );
    
  c.addSubscribe( "powerSwitch", "boolean" );
  c.addSubscribe( "powerState", "boolean" );
  c.addSubscribe( "text", "string" );
  
  // connect!
  c.connect("ws://"+server+":9000", name, description );
  
  
  // connect to serial
    myPort = new Serial(this, Serial.list()[0], 9600);
   myPort.bufferUntil('\n');
}

void draw() {
  background( 255 );
  fill(20);
  textSize(100);
  text(numClicks, 20, 120);
  textSize(30);
  text("Push spacebar to send message", 20, 320);

  
    }
  
  

void keyPressed() {   // test your connection via procesing
   c.send( "procPressTesting", toSend);
   toSend = !toSend;
}





void onBooleanMessage( String name, boolean value ){
println("got bool message "+name +" : "+ value); 
  
  if (name.equals("powerSwitch")){

   poweswitchState = !poweswitchState;
          if (poweswitchState == true){
             myPort.write('H');
             c.send("currentPower", poweswitchState);
          }
          else{
            myPort.write('L');
            c.send("currentPower", poweswitchState);
        
          } 
            println("POWER SWITCH got bool message "+name +" : "+ value); 
}
else if (name.equals("powerState")){
  println("POWER STATE got bool message "+name +" : "+ value); 
  if (value == true){
    myPort.write('H');
    c.send("currentPower", poweswitchState);
  }
    else {
    myPort.write('L');
            c.send("currentPower", poweswitchState);
  
}
}
}

void onStringMessage( String name, String value ){
  println("got string message "+name +" : "+ value);  
     poweswitchState = !poweswitchState;
          if (poweswitchState == true){
             myPort.write('H');
             c.send("currentPower", poweswitchState);
          }
          else{
            myPort.write('L');
            c.send("currentPower", poweswitchState);
            
          } 
}


/* Arduino Code/

////////////////////////////////////////////////////////////////////
const int PowerTail = 2; // the pin that the LED is attached to
int incomingByte;      // a variable to read incoming serial data into

void setup() {
  // initialize serial communication:
  Serial.begin(9600);
  // initialize the LED pin as an output:
  pinMode(ledPin, OUTPUT);
}

void loop() {
  // see if there's incoming serial data:
  if (Serial.available() > 0) {
    // read the oldest byte in the serial buffer:
    incomingByte = Serial.read();
    // if it's a capital H (ASCII 72), turn on the LED:
    if (incomingByte == 'H') {
      digitalWrite(ledPin, HIGH);
    } 
    // if it's an L (ASCII 76) turn off the LED:
    if (incomingByte == 'L') {
      digitalWrite(ledPin, LOW);
    }
  }
}
*/

