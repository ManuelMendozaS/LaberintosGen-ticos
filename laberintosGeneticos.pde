int nCuadros = 50;
int contadorTiempo =0;
int pasoActual = 0;
int velocidadPasos = 1;

//Meta
int indiceMeta = 0;
//Poblacion
int nPoblacion = 1000;
Poblacion poblacion;
Poblacion temporal;
//Laberinto
Laberinto l;
void setup() {
  size(600, 600);
  indiceMeta = nCuadros*nCuadros-1;
  poblacion = new Poblacion();
  l= new Laberinto();
  indiceMeta =l.casillaMasLejana(0, 0);
}

void draw() {
  background(0);
  l.dibujar();
  for (int i = 0; i < nPoblacion; i++) {
    poblacion.agentes[i].mostrar();
  }
  if ( millis() - contadorTiempo > velocidadPasos) {
    for (int i = 0; i < nPoblacion; i++) {
      if (poblacion.agentes[i].vivo == true) poblacion.agentes[i].mover(pasoActual);
    }
    pasoActual +=1;
    contadorTiempo = millis();
  }
  //Meta
  fill(0, 255, 0);
  stroke(0, 255, 0);
  rect((width/nCuadros)*(indiceMeta%nCuadros), (height/nCuadros)*int(indiceMeta/nCuadros), width/nCuadros, height/nCuadros);

  //Nueva generacion

  if (poblacion.todosMuertos()&&!poblacion.llegoMeta()) {
    temporal = new Poblacion();
    //Ordenar por fitness
    poblacion.ordenar();
    println("///////////////////////");
    println(poblacion.agentes[0].fitness);

    //La quinta parte de la poblacion se rellena con el mejor de la generacion anterior
    for (int i = 0; i < nPoblacion/4; i++) {
      temporal.agentes[i].cerebro = poblacion.agentes[0].cerebro;
    }
    //La segunda cuarta parte de la poblacion se rellena con los mejores de la generacion anterior
    Agente[] torneo = poblacion.seleccionarPorTorneo(nPoblacion/4);
    for (int i = nPoblacion/4; i < nPoblacion/2; i++) {
      temporal.agentes[i].cerebro = torneo[i-nPoblacion/4].cerebro;
    }
    //La tercera cuarta parte de la poblacion se rellena con mezcla por mitad de los mejores de la generacion anterior
    for (int i = nPoblacion/2; i < nPoblacion*3/4; i++) {
      temporal.agentes[i].cerebro = poblacion.mezclarMitad(int(random(0, nPoblacion/4)), int(random(0, nPoblacion/4))).cerebro;
    }
    //La ultima cuarta parte de la poblacion se rellena con mezcla por insercion de los mejores de la generacion anterior
    for (int i = nPoblacion*3/4; i < nPoblacion; i++) {
      temporal.agentes[i].cerebro = poblacion.mezclarInsercion(int(random(0, nPoblacion/4)), int(random(0, nPoblacion/4))).cerebro;
    }
    //Mutar
    temporal.mutar();

    for (int i=0; i<5; i++) {
      temporal.agentes[i].cerebro = poblacion.agentes[0].cerebro;
    }
    //La poblacion actual se reemplaza por la nueva
    poblacion = temporal;
    pasoActual = 0;
  }
  if (poblacion.llegoMeta()) {
    int posInicial = 0;

    poblacion.ordenar();
    for (int i=0; i< poblacion.agentes[0].nPasos; i++) {
      if (poblacion.agentes[0].cerebro.movimientos[i] == 0) {
        posInicial -=nCuadros;
      }
      if (poblacion.agentes[0].cerebro.movimientos[i] == 1) {
        posInicial += nCuadros;
      }
      if (poblacion.agentes[0].cerebro.movimientos[i] == 2) {
        posInicial--;
      }
      if (poblacion.agentes[0].cerebro.movimientos[i] == 3) {
        posInicial++;
      }
      stroke(#DEC743);
      fill(#DEC743);
      rect((posInicial%nCuadros)*(width/nCuadros), (posInicial/nCuadros)*(height/nCuadros), width/nCuadros, height/nCuadros);
    }
    noLoop();
  }
}
