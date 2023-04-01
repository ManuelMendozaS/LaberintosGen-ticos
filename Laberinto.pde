class Laberinto {
  int nVeces= 0;
  int[][] laberinto;
  int[] dx = {0, 0, 1, -1};
  int[] dy = {1, -1, 0, 0};

  Laberinto() {
    // Inicializar el laberinto con paredes en todas las celdas
    laberinto = new int[nCuadros][nCuadros];
    for (int i = 0; i < nCuadros; i++) {
      for (int j = 0; j < nCuadros; j++) {
        laberinto[i][j] = 1;
      }
    }

    generarLaberintoAleatorio(0, 0);
  }
  void generarLaberintoAleatorio(int x, int y) {
    // Marcar la celda actual como visitada
    laberinto[x][y] = 0;

    // Crear un arreglo de direcciones aleatorias
    int[] direcciones = {0, 1, 2, 3};
    shuffleArray(direcciones);

    // Recorrer el arreglo de direcciones aleatorias
    for (int i = 0; i < 4; i++) {
      int direccion = direcciones[i];
      int nx = x + dx[direccion];
      int ny = y + dy[direccion];

      // Verificar si la celda vecina es válida y no ha sido visitada
      if (nx >= 0 && nx < nCuadros && ny >= 0 && ny < nCuadros && laberinto[nx][ny] == 1) {
        // Eliminar la pared entre la celda actual y la celda vecina
        laberinto[x + dx[direccion] / 2][y + dy[direccion] / 2] = 0;
        // Llamar recursivamente al algoritmo para la celda vecina
        if (nVeces<nCuadros*(nCuadros/6)) {
          generarLaberintoAleatorio(nx, ny);
        }
      }
    }
    nVeces++;
  }
  void dibujar() {
    // Dibujar el laberinto
    for (int i = 0; i < nCuadros; i++) {
      for (int j = 0; j < nCuadros; j++) {
        if (laberinto[j][i] == 1) {
          fill(0);
          stroke(128);
          rect((width/nCuadros)*i, (width/nCuadros)*j, width/nCuadros, height/nCuadros);
        }
        // Si la celda es un camino, dibujar un rectángulo blanco
        else {
          fill(255);

          stroke(128);
          rect((width/nCuadros)*i, (width/nCuadros)*j, width/nCuadros, height/nCuadros);
        }
      }
    }
  }
  void shuffleArray(int[] array) {
    for (int i = array.length - 1; i > 0; i--) {
      int j = (int) random(i + 1);
      int temp = array[i];
      array[i] = array[j];
      array[j] = temp;
    }
  }

  //indice de casilla blanca mas lejana
  int casillaMasLejana(int x, int y) {
    int[] casilla = {x, y};
    int[] casillaMasLejana = {x, y};
    int distancia = 0;
    int distanciaMasLejana = 0;
    for (int i = 0; i < nCuadros; i++) {
      for (int j = 0; j < nCuadros; j++) {
        if (laberinto[i][j] == 0) {
          casilla[0] = i;
          casilla[1] = j;
          distancia = (int) dist(x, y, casilla[0], casilla[1]);
          if (distancia > distanciaMasLejana) {
            distanciaMasLejana = distancia;
            casillaMasLejana[0] = casilla[0];
            casillaMasLejana[1] = casilla[1];
          }
        }
      }
    }
    return casillaMasLejana[0]*nCuadros+casillaMasLejana[1];
  }
  //Calcular si es barrera
  boolean esBarrera(int x) {
    int i = x/nCuadros;
    int j = x%nCuadros;

    if (laberinto[i][j] == 1) {
      return true;
    } else {
      return false;
    }
  }
}
