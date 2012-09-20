/*****************************************************************
  SPACEBREW - Processing text sender
*****************************************************************/
String server="ec2-184-72-140-184.compute-1.amazonaws.com";  // change to the url of your host if not local!

SpacebrewClient sb;
String name="JRTprocessingNumber";
String description ="This app lets you send some text to Sb via Processing. It can also receive text!";

// inputs + outputs
int sendNumber =0;
boolean sendBoolean = false;

float diameter; 
float angle = 0;
float angle2 = 0;
int james = 0;

void setup() {
    size(640, 640);
  diameter = height - 10;
  noStroke();
  noStroke();
  fill(255, 204, 0);
  
  sb = new SpacebrewClient( this );
  
  // add each thing you publish and subscribe to
  sb.addPublish( "p5OutNumber", sendNumber);
  sb.addPublish( "p5OutText", sendBoolean );

  // connect!
  sb.connect(server, name, description );
}

void draw() {
  background(0);
  fill(255, 204, 0);
  textSize(30);
 
  
  
   float d1 = 10 + (sin(angle) * diameter/2) + diameter/2;
   // i should use bang when i find the asymptope.. 
   // wither with calc or when it goes form + to -
   // maybe i can find it when it goes by zero crossingre
  
   ellipse(0, height/2, d1, d1);
   float zoom = map(mouseY,0,height, .0009,1);
  
   float m = map(mouseX , 0, width, .0001, zoom);
    angle += m;
 // println ("angle1 :"+angle+" angle2 :"+angle2);
   float s = map(d1 , 0, height, 0, 1024);
   
  sb.send( "p5OutNumber", int(s));
  if ( s >= 1020)
  { 
    sendBoolean = true;
    sb.send("p5Bang",sendBoolean);
    println (sendBoolean);
    println ("...");
  }
  
   
  // float s = map(d1 , 0, 360, .001, .5);
 
   
   
}




