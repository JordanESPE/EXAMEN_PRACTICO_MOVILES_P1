import '../models/arbol_model.dart';
import '../models/compra_model.dart';

class ArbolController {
  List<CompraModel> compras = [];
  
  // validar que la cantidad sea valida
  String? validarCantidad(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese una cantidad';
    }
    
    final cantidad = int.tryParse(value);
    if (cantidad == null) {
      return 'Ingrese un numero valido';
    }
    
    if (cantidad < 0) {
      return 'La cantidad no puede ser negativa';
    }
    
    if (cantidad == 0) {
      return 'La cantidad debe ser mayor a 0';
    }
    
    return null;
  }

  // agregar una compra
  void agregarCompra(ArbolModel arbol, int cantidad) {
    arbol.cantidad = cantidad;
    compras.add(CompraModel(arbol: arbol, cantidad: cantidad));
  }

  // limpiar compras
  void limpiarCompras() {
    compras.clear();
  }

  // calcular el total de arboles en todas las compras
  int calcularTotalArboles() {
    int total = 0;
    for (var compra in compras) {
      total += compra.cantidad;
    }
    return total;
  }

  // calcular subtotal de todas las compras
  double calcularSubtotalGeneral() {
    double subtotal = 0.0;
    for (var compra in compras) {
      subtotal += compra.arbol.calcularSubtotal();
    }
    return subtotal;
  }

  // calcular descuentos por cantidad de cada tipo de arbol
  double calcularDescuentosPorTipo() {
    double descuentoTotal = 0.0;
    for (var compra in compras) {
      descuentoTotal += compra.arbol.aplicarDescuentos();
    }
    return descuentoTotal;
  }

  // calcular descuento adicional del 15% si supera 1000 arboles
  double calcularDescuentoAdicional() {
    int totalArboles = calcularTotalArboles();
    if (totalArboles > 1000) {
      double subtotal = calcularSubtotalGeneral();
      double descuentosPorTipo = calcularDescuentosPorTipo();
      double subtotalConDescuentos = subtotal - descuentosPorTipo;
      return subtotalConDescuentos * 0.15;
    }
    return 0.0;
  }

  // calcular IVA sobre el monto con descuentos
  double calcularIVATotal() {
    double subtotal = calcularSubtotalGeneral();
    double descuentosPorTipo = calcularDescuentosPorTipo();
    double descuentoAdicional = calcularDescuentoAdicional();
    double montoConDescuentos = subtotal - descuentosPorTipo - descuentoAdicional;
    return montoConDescuentos * 0.12;
  }

  // calcular el total final a pagar
  double calcularTotalFinal() {
    double subtotal = calcularSubtotalGeneral();
    double descuentosPorTipo = calcularDescuentosPorTipo();
    double descuentoAdicional = calcularDescuentoAdicional();
    double iva = calcularIVATotal();
    
    return subtotal - descuentosPorTipo - descuentoAdicional + iva;
  }

  // obtener resumen de la compra
  Map<String, dynamic> obtenerResumen() {
    return {
      'totalArboles': calcularTotalArboles(),
      'subtotal': calcularSubtotalGeneral(),
      'descuentosPorTipo': calcularDescuentosPorTipo(),
      'descuentoAdicional': calcularDescuentoAdicional(),
      'subtotalConDescuentos': calcularSubtotalGeneral() - 
          calcularDescuentosPorTipo() - calcularDescuentoAdicional(),
      'iva': calcularIVATotal(),
      'total': calcularTotalFinal(),
      'compras': compras,
    };
  }
}
