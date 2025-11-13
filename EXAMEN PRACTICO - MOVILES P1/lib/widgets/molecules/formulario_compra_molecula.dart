import 'package:flutter/material.dart';
import '../atoms/dropdown_atomo.dart';
import '../atoms/campo_texto_atomo.dart';
import '../atoms/boton_atomo.dart';

// molecula: fila de formulario de compra
class FormularioCompraMolecula extends StatelessWidget {
  final String? tipoArbolSeleccionado;
  final List<String> tiposArboles;
  final TextEditingController cantidadController;
  final VoidCallback onAgregar;
  final String? Function(String?)? validarCantidad;

  const FormularioCompraMolecula({
    super.key,
    required this.tipoArbolSeleccionado,
    required this.tiposArboles,
    required this.cantidadController,
    required this.onAgregar,
    this.validarCantidad,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Seleccionar Arbol',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 16),
            DropdownAtomo(
              value: tipoArbolSeleccionado,
              items: tiposArboles,
              hint: 'Seleccione tipo de arbol',
              onChanged: (value) {},
            ),
            const SizedBox(height: 16),
            CampoTextoAtomo(
              controller: cantidadController,
              label: 'Cantidad',
              hint: 'Ingrese la cantidad de arboles',
              validator: validarCantidad,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            BotonAtomo(
              texto: 'Agregar a la Compra',
              onPressed: onAgregar,
              icono: Icons.add_shopping_cart,
            ),
          ],
        ),
      ),
    );
  }
}
