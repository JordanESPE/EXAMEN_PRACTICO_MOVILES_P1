import 'package:flutter/material.dart';

// atomo: texto de resultado
class TextoResultadoAtomo extends StatelessWidget {
  final String etiqueta;
  final String valor;
  final bool esTotal;

  const TextoResultadoAtomo({
    super.key,
    required this.etiqueta,
    required this.valor,
    this.esTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            etiqueta,
            style: TextStyle(
              fontSize: esTotal ? 18 : 15,
              fontWeight: esTotal ? FontWeight.bold : FontWeight.w500,
              color: esTotal ? Theme.of(context).primaryColor : Colors.black87,
            ),
          ),
          Text(
            valor,
            style: TextStyle(
              fontSize: esTotal ? 18 : 15,
              fontWeight: esTotal ? FontWeight.bold : FontWeight.w600,
              color: esTotal ? Theme.of(context).primaryColor : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
