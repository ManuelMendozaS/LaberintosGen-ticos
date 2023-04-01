class Poblacion {
  Agente[] agentes;
  Poblacion() {
    agentes = new Agente[nPoblacion];
    for (int i=0; i<nPoblacion; i++) {
      agentes[i] = new Agente();
    }
  }


  //Verificar si todos los agentes murieron
  boolean todosMuertos() {
    for (int i=0; i<nPoblacion; i++) {
      if (agentes[i].vivo) return false;
    }
    
    return true;
  }
  //Ordenar por fitness de mayor a menor
  void ordenar() {
    for (int i=0; i<nPoblacion; i++) {
      for (int j=0; j<nPoblacion-1; j++) {
        if (agentes[j].fitness < agentes[j+1].fitness) {
          Agente temp = agentes[j];
          agentes[j] = agentes[j+1];
          agentes[j+1] = temp;
        }
      }
    }
  }
  //mezclarMitad
  Agente mezclarMitad(int indicePadre, int indiceMadre) {
    Agente hijo = new Agente();
    for (int i=0; i<agentes[indicePadre].nPasos/2; i++) {
      hijo.cerebro.movimientos[i] = agentes[indicePadre].cerebro.movimientos[i] ;
    }
    for (int i=agentes[indicePadre].nPasos/2; i<agentes[indicePadre].nPasos; i++) {
      hijo.cerebro.movimientos[i] = agentes[indiceMadre].cerebro.movimientos[i];
    }
    return hijo;
  }
  //mezclarInsercion
  Agente mezclarInsercion(int indicePadre, int indiceMadre) {
    Agente hijo = new Agente();
    for (int i=0; i<hijo.cerebro.movimientos.length; i++) {
      int random = (int) random(0, 2);
      if (random == 0) {
        hijo.cerebro.movimientos[i] = agentes[indicePadre].cerebro.movimientos[i];
      } else {
        hijo.cerebro.movimientos[i] = agentes[indiceMadre].cerebro.movimientos[i];
      }
    }
    return hijo;
  }
  //Mutar
  void mutar() {
    for (int i=0; i<nPoblacion; i++) {
      for (int j=0; j<agentes[0].cerebro.movimientos.length; j++) {
        int random =int (random(1000));
        if (random < 5) {
          agentes[i].cerebro.movimientos[j] = (int) random(0, 4);
        }
      }
    }
  }
  //Función para seleccionar individuos por torneo
//Recibe como parámetros la población y el número de individuos a seleccionar
Agente[] seleccionarPorTorneo(int nSeleccionados) {
  Agente[] agentesSeleccionados = new Agente[nSeleccionados]; //creamos un arreglo para guardar los individuos seleccionados
  int tamPoblacion = nPoblacion; //obtenemos el tamaño de la población
  for (int i = 0; i < nSeleccionados; i++) {
    int indice1 = int(random(tamPoblacion)); //elegimos aleatoriamente dos individuos de la población
    int indice2 = int(random(tamPoblacion));
    Agente agente1 = poblacion.agentes[indice1];
    Agente agente2 = poblacion.agentes[indice2];
    //comparamos los fitness de los dos individuos y seleccionamos al que tenga el mayor
    if (agente1.fitness > agente2.fitness) {
      agentesSeleccionados[i] = agente1;
    } else {
      agentesSeleccionados[i] = agente2;
    }
  }
  return agentesSeleccionados; //retornamos la nueva población con los individuos seleccionados
}
  boolean llegoMeta() {
    boolean llego = false;
    for (int i=0; i<nPoblacion; i++) {
      if( agentes[i].posicion == indiceMeta) llego = true;
    }
    return llego;
  }

}
