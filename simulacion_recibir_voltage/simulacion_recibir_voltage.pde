/** Librerias **/
import processing.serial.*;
import cc.arduino.*;

/** Variables globales **/
// Serial myPort;     
Arduino arduino;
int potenciometro = 0;
float max_voltage = 30;
float voltage = 0;

void setup() {
  println("**** SETTING UP ****");
  size(800, 450);
  background(36);

  // List all the available serial ports:
  //printArray(Serial.list());
  // Open the port you are using at the rate you want:
  // myPort = new Serial(this, Serial.list()[32], 9600);

  // printArray(Arduino.list());
  arduino = new Arduino(this, Arduino.list()[32], 57600);
  arduino.pinMode(potenciometro, Arduino.INPUT);
}

void draw() {
  background(36);
  voltage = arduino.analogRead(potenciometro) * max_voltage / 1023;
  println(voltage);
}
