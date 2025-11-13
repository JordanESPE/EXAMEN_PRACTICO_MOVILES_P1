import 'package:flutter/material.dart';

// atomo: boton personalizado
class BotonAtomo extends StatelessWidget {
  final String texto;
  final VoidCallback onPressed;
  final Color? color;
  final IconData? icono;

  const BotonAtomo({
    super.key,
    required this.texto,
    required this.onPressed,
    this.color,
    this.icono,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icono ?? Icons.calculate),
      label: Text(
        texto,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
