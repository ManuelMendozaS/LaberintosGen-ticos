class Agente {
  int posicion = 0;
  int tamano = width/nCuadros;
  boolean vivo = true;
  color relleno = color(0, 0, 255);
  int opacidad = 100;
  float fitness = 0;
  int nPasos = 1;
  boolean sinPasos = false;
  Cerebro cerebro;


  Agente() {
    cerebro = new Cerebro();
  }

  void mostrar() {
    fill(relleno, opacidad);
    int x = posicion%nCuadros;
    int y = posicion/nCuadros;
    rect((width/nCuadros)*x, (height/nCuadros)*y, tamano, tamano);
  }

  void mover(int pasoActualI) {
    if (pasoActualI> cerebro.nMovimientosMemoria-1) {
      muerte();
      sinPasos= true;
    } else {
      int movimiento = cerebro.movimientos[pasoActualI];
      if (movimiento == 0) {
        moverArriba();
        nPasos++;
      } else if (movimiento == 1) {
        moverAbajo();
        nPasos++;
      } else if (movimiento == 2) {
        moverIzquierda();
        nPasos++;
      } else if (movimiento == 3) {
        moverDerecha();
        nPasos++;
      }
    }
  }
  void muerte() {
    vivo = false;
    relleno = color(255, 0, 0);
    calcularFitness();
  }
  void moverArriba() {
    int nuevaPos = posicion-nCuadros;
    if (posicion/nCuadros > 0 && !l.esBarrera(nuevaPos)) {
      posicion-=nCuadros;
    } else {
      muerte();
    }
  }
  //Mover abajo
  void moverAbajo() {
    int nuevaPos = posicion+nCuadros;
    if (posicion/nCuadros < nCuadros-1 && !l.esBarrera(nuevaPos)) {
      posicion+=nCuadros;
    } else {
      muerte();
    }
  }
  //Mover izquierda
  void moverIzquierda() {
    int nuevaPos = posicion-1;
    if (posicion%nCuadros > 0 && !l.esBarrera(nuevaPos)) {
      posicion--;
    } else {
      muerte();
    }
  }
  //Mover derecha
  void moverDerecha() {
    int nuevaPos = posicion+1;
    if (posicion%nCuadros < nCuadros-1 && !l.esBarrera(nuevaPos)) {
      posicion++;
    } else {
      muerte();
    }
  }

  void calcularFitness() {
    float distancia = dist(posicion%nCuadros, posicion/nCuadros, indiceMeta%nCuadros, indiceMeta/nCuadros);
    fitness = 1/distancia - 1/nPasos;
    //fitness =1000-int(distancia);
    if (sinPasos) {
      fitness=0;
    }
  }
}
