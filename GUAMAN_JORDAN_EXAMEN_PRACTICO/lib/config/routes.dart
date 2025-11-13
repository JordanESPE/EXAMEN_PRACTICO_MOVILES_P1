import 'package:flutter/material.dart';
import '../views/pantalla_inicio_view.dart';
import '../views/calculadora_arboles_view.dart';
import '../views/detalles_compra_view.dart';

class AppRoutes {
  // Nombres de las rutas
  static const String inicio = '/';
  static const String calculadora = '/calculadora';
  static const String detalles = '/detalles';

  // Mapa de rutas
  static Map<String, WidgetBuilder> routes = {
    inicio: (context) => const PantallaInicioView(),
    calculadora: (context) => const CalculadoraArbolesView(),
    detalles: (context) => const DetallesCompraView(),
  };

  // Ruta para manejar rutas no encontradas
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case detalles:
        // manejar parametros para la ruta de detalles
        final args = settings.arguments as Map<String, dynamic>?;
        if (args != null) {
          return MaterialPageRoute(
            builder: (context) => const DetallesCompraView(),
            settings: RouteSettings(arguments: args),
          );
        }
        return MaterialPageRoute(
          builder: (context) => const PantallaInicioView(),
        );
      
      default:
        return MaterialPageRoute(
          builder: (context) => const PantallaInicioView(),
        );
    }
  }
}
