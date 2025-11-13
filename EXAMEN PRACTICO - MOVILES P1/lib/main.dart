import 'package:flutter/material.dart';
import 'tema/app_theme.dart';
import 'config/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Criadero de Arboles',
      debugShowCheckedModeBanner: false,
      
      // Aplicar tema personalizado
      theme: AppTheme.lightTheme,
      
      // Configurar rutas
      initialRoute: AppRoutes.inicio,
      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
