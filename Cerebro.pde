class Cerebro {
  int nMovimientosMemoria = nCuadros*nCuadros;
  int[] movimientos = new int[nMovimientosMemoria];

  Cerebro() {
    for (int i = 0; i < nMovimientosMemoria; i++) {
      movimientos[i] = int(random(0, 4));
    }
  }
}
