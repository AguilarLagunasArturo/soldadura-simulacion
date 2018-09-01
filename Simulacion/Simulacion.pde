float voltage;
float time;
float offset;
float noise;

float max;
float update;

ArrayList<Float> x_values = new ArrayList<Float>();
ArrayList<Float> y_values = new ArrayList<Float>();

String xy;
PrintWriter output;

void setup() {
  fullScreen();
  //size(800, 450);
  voltage = 0;
  time = 0;
  offset = 0;

  // Variables importantes
  max = 35;     // Voltage maximo
  update = 0.1; // Frecuencia a la que se toma el voltage escala 1:1000 ms
  noise = 0.02;

  // Crea archivo coordenadas
  output = createWriter("coordenadas.txt");
  output.println("0,"+max+","+update+".");

  // Formato y color de lineas
  fill(200, 20, 200);
  strokeWeight(1.5);
  stroke(200);
}

void draw() {
  background(36);

  /**** Parte logica ****/
  // Genera voltage
  voltage = noise(offset) * max;

  // Retraso de x segundos
  delay(floor(1000*update));
  time += update;

  // Generacion de coordenadas en formato string
  xy = time + "," + voltage; 

  // Se escriben coordenadas en archivo .txt
  output.print(xy + ",");

  // Se almacenan las coordenadas para generacion de grafica en tiempo real
  x_values.add(time);
  y_values.add(voltage);

  // Se genera variabilidad en el voltage
  offset += noise;

  /**** Parte grafica ****/
  // Muestra segundos y voltage en tiempo real
  show_xy();
  // Se grafica
  graph(x_values, y_values);
}

// Mostrar coordenadas
void show_xy() {
  textSize(20);
  text(xy, width/2 - (xy.length() * 6), 20);
}

// Grficar datos
void graph(ArrayList<Float> x, ArrayList<Float> y) {
  float y_spacing = -(height-50)/max;
  float rise = height;
  for (int i = 0; i <= max; i ++) {
    textSize(15);
    text(i, 0, rise);
    // line(0, rise, width, rise);
    rise += y_spacing;
  }

  int x_points = x.size();
  float y_point = 0;
  int run = 0;
  float x_spacing = (width-50)/x_points;
  noFill();
  beginShape();
  for (int i = 0; i < x_points; i ++) {
    run += x_spacing;
    y_point = map(y.get(i), 0, max, height, 50);
    vertex(run+25, y_point);
    
    if (i%10 == 0) {
      textSize(15);
      text(x.get(i), run+25, height);
      // line(run+25, height, run+25, 50);
    }
  }
  endShape();
}

// Al presionar tecla salir y guardar
void keyPressed() {
  output.close(); // Cierra el archivo
  exit(); // Programa finaliza
}
