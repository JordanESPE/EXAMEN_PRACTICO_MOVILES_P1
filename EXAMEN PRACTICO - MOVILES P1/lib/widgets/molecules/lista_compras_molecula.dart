import 'package:flutter/material.dart';
import '../../models/compra_model.dart';

// molecula: lista de compras agregadas
class ListaComprasMolecula extends StatelessWidget {
  final List<CompraModel> compras;
  final Function(int) onEliminar;

  const ListaComprasMolecula({
    super.key,
    required this.compras,
    required this.onEliminar,
  });

  @override
  Widget build(BuildContext context) {
    if (compras.isEmpty) {
      return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Icon(Icons.shopping_cart_outlined, size: 60, color: Colors.grey.shade400),
              const SizedBox(height: 12),
              Text(
                'No hay compras agregadas',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.shopping_bag, color: Theme.of(context).primaryColor),
                const SizedBox(width: 10),
                const Text(
                  'Compras Agregadas',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: compras.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final compra = compras[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                title: Text(
                  compra.arbol.tipo,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Cantidad: ${compra.cantidad} | Precio: \$${compra.arbol.precioUnitario}',
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => onEliminar(index),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
