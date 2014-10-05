//Spacebrew to OSC example/
// by Brett Refner and Joselyn McDonald
//http://docs.spacebrew.cc/gettingstarted/
//Use this example to read incomming values/messages from Spacebrew and send them as OSC

import spacebrew.*;

// CHANGE THIS TO YOUR SERVER IP
String server="sandbox.spacebrew.cc";
String name="Spacebrew to OSC";
String description ="This gets messages from Spacebrew and sends them as OSC";

Spacebrew sb;

// OSC STUFF

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress oscReceiverAddress;
String oscIP = "127.0.0.1"; // keep this unless sending OSC to someone else
int oscPortIn   = 12000;
int oscPortOut  = 12001;

String oscMessageAddress = "/spacebrew";

void setup() {
  size(600, 400);

  // instantiate the sb variable
  sb = new Spacebrew( this );

  // add each thing you publish to
  // sb.addPublish( "buttonPress", "boolean", buttonSend ); 

  // add each thing you subscribe to
  sb.addSubscribe( "oscRange", "range" );
  sb.addSubscribe( "oscBool", "boolean" );
  sb.addSubscribe( "oscString", "string" );

  // connect to spacebrew
  sb.connect(server, name, description );
  
  // connect OSC
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,oscPortIn);
  oscReceiverAddress = new NetAddress(oscIP, oscPortOut);
  
}

void draw() {
  // do whatever you want to do here  
}


void onRangeMessage( String name, int value ){
  OscMessage myMessage = new OscMessage( oscMessageAddress + "/range/" + name );
  myMessage.add(value);
  oscP5.send( myMessage, oscReceiverAddress );
  println(value); 
}

void onBooleanMessage( String name, boolean value ){
  OscMessage myMessage = new OscMessage( oscMessageAddress + "/boolean/" + name );
  myMessage.add(value);
  oscP5.send( myMessage, oscReceiverAddress );
  //turn on println to debug println(value); 

 
}

void onStringMessage( String name, String value ){
  OscMessage myMessage = new OscMessage( oscMessageAddress + "/string/" + name );
  myMessage.add(value);
  oscP5.send( myMessage, oscReceiverAddress );
   //turn on println to debug println(value); 

}

void onCustomMessage( String name, String type, String value ){
  // not doing anything here ;) 
}
