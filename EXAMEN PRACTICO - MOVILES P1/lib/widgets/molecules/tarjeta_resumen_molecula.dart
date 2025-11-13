import 'package:flutter/material.dart';
import '../atoms/texto_resultado_atomo.dart';

// molecula: tarjeta de resumen de compra
class TarjetaResumenMolecula extends StatelessWidget {
  final Map<String, dynamic> resumen;

  const TarjetaResumenMolecula({
    super.key,
    required this.resumen,
  });

  String formatearMoneda(double valor) {
    return '\$${valor.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.green.shade50,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(Icons.receipt_long, color: Theme.of(context).primaryColor, size: 28),
                const SizedBox(width: 10),
                const Text(
                  'Resumen de Compra',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                  ),
                ),
              ],
            ),
            const Divider(height: 24, thickness: 2),
            TextoResultadoAtomo(
              etiqueta: 'Total de arboles:',
              valor: '${resumen['totalArboles']}',
            ),
            const SizedBox(height: 8),
            TextoResultadoAtomo(
              etiqueta: 'Subtotal:',
              valor: formatearMoneda(resumen['subtotal']),
            ),
            if (resumen['descuentosPorTipo'] > 0)
              TextoResultadoAtomo(
                etiqueta: 'Descuento por cantidad:',
                valor: '-${formatearMoneda(resumen['descuentosPorTipo'])}',
              ),
            if (resumen['descuentoAdicional'] > 0) ...[
              TextoResultadoAtomo(
                etiqueta: 'Descuento adicional (15%):',
                valor: '-${formatearMoneda(resumen['descuentoAdicional'])}',
              ),
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange.shade300),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.celebration, color: Colors.orange, size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Felicidades! Obtuviste 15% de descuento por superar 1000 arboles',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            TextoResultadoAtomo(
              etiqueta: 'Subtotal con descuentos:',
              valor: formatearMoneda(resumen['subtotalConDescuentos']),
            ),
            TextoResultadoAtomo(
              etiqueta: 'IVA (12%):',
              valor: formatearMoneda(resumen['iva']),
            ),
            const Divider(height: 20, thickness: 2),
            TextoResultadoAtomo(
              etiqueta: 'TOTAL A PAGAR:',
              valor: formatearMoneda(resumen['total']),
              esTotal: true,
            ),
          ],
        ),
      ),
    );
  }
}
