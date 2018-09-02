int potenciometro = 3;
float voltage = 0;

void setup() {
  Serial.begin(9600);
  pinMode(potenciometro, INPUT);
}

void loop() {
  Serial.println(analogRead(potenciometro));
}
