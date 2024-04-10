enum SNCFCity {
  paris,
  lyon,
  marseille,
  lille,
  bordeaux;

  String get name {
    switch (this) {
      case paris:
        return 'Paris';
      case lyon:
        return 'Lyon';
      case marseille:
        return 'Marseille';
      case lille:
        return 'Lille';
      case bordeaux:
        return 'Bordeaux';
    }
  }

  double get latitude {
    switch (this) {
      case paris:
        return 48.8543789;
      case lyon:
        return 45.7676156;
      case marseille:
        return 43.3011519;
      case lille:
        return 50.6294044;
      case bordeaux:
        return 44.8438523;
    }
  }

  double get longitude {
    switch (this) {
      case paris:
        return 2.3418425;
      case lyon:
        return 4.8302671;
      case marseille:
        return 5.3782421;
      case lille:
        return 3.0558961;
      case bordeaux:
        return -0.589277;
    }
  }
}
