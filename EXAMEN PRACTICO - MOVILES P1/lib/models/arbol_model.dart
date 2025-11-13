class ArbolModel {
  final String tipo;
  final double precioUnitario;
  final double rebajaMenor; // Rebaja por compras entre 100 y 300
  final double rebajaMayor; // Rebaja por compras mayores a 300
  int cantidad;
  double subtotal;
  double descuento;
  double iva;
  double total;

  ArbolModel({
    required this.tipo,
    required this.precioUnitario,
    required this.rebajaMenor,
    required this.rebajaMayor,
    this.cantidad = 0,
    this.subtotal = 0.0,
    this.descuento = 0.0,
    this.iva = 0.0,
    this.total = 0.0,
  });

  // Calcular subtotal sin descuentos
  double calcularSubtotal() {
    subtotal = precioUnitario * cantidad;
    return subtotal;
  }

  // aplicar descuentos segun la cantidad
  double aplicarDescuentos() {
    if (cantidad == 0) {
      descuento = 0.0;
      return 0.0;
    }

    double subtotalCalculado = calcularSubtotal();
    double porcentajeDescuento = 0.0;

    if (cantidad >= 100 && cantidad <= 300) {
      porcentajeDescuento = rebajaMenor;
    } else if (cantidad > 300) {
      porcentajeDescuento = rebajaMayor;
    }

    descuento = subtotalCalculado * porcentajeDescuento;
    return descuento;
  }

  // Calcular IVA (12%)
  double calcularIVA(double montoConDescuento) {
    iva = montoConDescuento * 0.12;
    return iva;
  }

  // Calcular total final
  double totalFinal() {
    double subtotalCalculado = calcularSubtotal();
    double descuentoCalculado = aplicarDescuentos();
    double subtotalConDescuento = subtotalCalculado - descuentoCalculado;
    double ivaCalculado = calcularIVA(subtotalConDescuento);
    total = subtotalConDescuento + ivaCalculado;
    return total;
  }

  // lista de arboles disponibles
  static List<ArbolModel> obtenerArboles() {
    return [
      ArbolModel(
        tipo: 'Paltos',
        precioUnitario: 1200.0,
        rebajaMenor: 0.10,
        rebajaMayor: 0.18,
      ),
      ArbolModel(
        tipo: 'Limones',
        precioUnitario: 1000.0,
        rebajaMenor: 0.125,
        rebajaMayor: 0.20,
      ),
      ArbolModel(
        tipo: 'Chirimoyos',
        precioUnitario: 980.0,
        rebajaMenor: 0.145,
        rebajaMayor: 0.19,
      ),
    ];
  }

  // copiar arbol con nueva cantidad
  ArbolModel copyWith({int? cantidad}) {
    return ArbolModel(
      tipo: tipo,
      precioUnitario: precioUnitario,
      rebajaMenor: rebajaMenor,
      rebajaMayor: rebajaMayor,
      cantidad: cantidad ?? this.cantidad,
    );
  }
}
