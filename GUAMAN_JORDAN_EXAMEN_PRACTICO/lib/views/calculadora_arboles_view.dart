import 'package:flutter/material.dart';
import '../controllers/arbol_controller.dart';
import '../models/arbol_model.dart';

// vista principal - organismo
class CalculadoraArbolesView extends StatefulWidget {
  const CalculadoraArbolesView({super.key});

  @override
  State<CalculadoraArbolesView> createState() => _CalculadoraArbolesViewState();
}

class _CalculadoraArbolesViewState extends State<CalculadoraArbolesView> {
  final ArbolController _controller = ArbolController();
  final TextEditingController _cantidadController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  List<ArbolModel> _arboles = [];
  String? _tipoArbolSeleccionado;
  bool _mostrarResumen = false;

  @override
  void initState() {
    super.initState();
    _arboles = ArbolModel.obtenerArboles();
    _tipoArbolSeleccionado = _arboles.first.tipo;
  }

  @override
  void dispose() {
    _cantidadController.dispose();
    super.dispose();
  }

  void _agregarPedido() {
    if (_formKey.currentState!.validate()) {
      final arbolSeleccionado = _arboles.firstWhere(
        (arbol) => arbol.tipo == _tipoArbolSeleccionado,
      );
      
      final cantidad = int.parse(_cantidadController.text);
      
      // crear una copia del arbol con la cantidad
      final arbolConCantidad = arbolSeleccionado.copyWith(cantidad: cantidad);
      
      _controller.agregarCompra(arbolConCantidad, cantidad);
      
      // limpiar solo el campo de cantidad
      _cantidadController.clear();
      
      setState(() {
        _mostrarResumen = false;
      });
    }
  }

  void _calcularTotal() {
    if (_controller.compras.isEmpty) {
      return;
    }

    setState(() {
      _mostrarResumen = true;
    });
  }

  void _limpiar() {
    setState(() {
      _controller.limpiarCompras();
      _mostrarResumen = false;
      _cantidadController.clear();
    });
  }

  void _eliminarPedido(int index) {
    setState(() {
      _controller.compras.removeAt(index);
      _mostrarResumen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Arboles'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
                // formulario de compra
                _buildFormularioCompra(),
                
                const SizedBox(height: 20),
                
                // lista de pedidos agregados
                if (_controller.compras.isNotEmpty)
                  _buildListaPedidos(),
                
                const SizedBox(height: 20),
                
                // botones de accion
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _calcularTotal,
                        child: const Text(
                          'Calcular Total',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                    if (_controller.compras.isNotEmpty) ...[
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _limpiar,
                          child: const Text(
                            'Limpiar',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // resumen
                if (_mostrarResumen)
                  _buildResumen(),
              ],
            ),
          ),
        ),
      );
  }

  Widget _buildFormularioCompra() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Datos de Compra',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _tipoArbolSeleccionado,
              decoration: const InputDecoration(
                labelText: 'Tipo de Arbol',
              ),
              items: _arboles.map((arbol) {
                return DropdownMenuItem<String>(
                  value: arbol.tipo,
                  child: Text('${arbol.tipo} - \$${arbol.precioUnitario.toStringAsFixed(0)}'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _tipoArbolSeleccionado = value;
                });
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _cantidadController,
              keyboardType: TextInputType.number,
              validator: _controller.validarCantidad,
              decoration: const InputDecoration(
                labelText: 'Cantidad de Arboles',
                hintText: 'Ingrese la cantidad',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _agregarPedido,
              child: const Text(
                'Agregar Pedido',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF66BB6A),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListaPedidos() {
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
            child: const Text(
              'Pedidos Agregados',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _controller.compras.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final compra = _controller.compras[index];
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
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                subtitle: Text(
                  'Cantidad: ${compra.cantidad} | Precio: \$${compra.arbol.precioUnitario.toStringAsFixed(0)}',
                  style: const TextStyle(fontSize: 14),
                ),
                trailing: TextButton(
                  onPressed: () => _eliminarPedido(index),
                  child: const Text(
                    'Eliminar',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildResumen() {
    final resumen = _controller.obtenerResumen();
    
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
            const Text(
              'Resumen de Compra',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
            const Divider(height: 24, thickness: 2),
            
            // detalle de cada compra
            ...resumen['compras'].map<Widget>((compra) {
              final arbol = compra.arbol;
              final subtotal = arbol.calcularSubtotal();
              final descuento = arbol.aplicarDescuentos();
              final porcentaje = descuento > 0 
                  ? (descuento / subtotal * 100).toStringAsFixed(1)
                  : '0';
              
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${arbol.tipo} (${arbol.cantidad} unidades)',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Precio unitario: \$${arbol.precioUnitario.toStringAsFixed(2)}'),
                    Text('Subtotal: \$${subtotal.toStringAsFixed(2)}'),
                    if (descuento > 0)
                      Text(
                        'Descuento aplicado ($porcentaje%): -\$${descuento.toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    Text(
                      'Total: \$${(subtotal - descuento).toStringAsFixed(2)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            }).toList(),
            
            const Divider(height: 20, thickness: 2),
            
            // totales generales
            _buildLineaResumen('Total de arboles:', '${resumen['totalArboles']} unidades'),
            const SizedBox(height: 8),
            _buildLineaResumen('Subtotal general:', '\$${resumen['subtotal'].toStringAsFixed(2)}'),
            if (resumen['descuentosPorTipo'] > 0)
              _buildLineaResumen(
                'Descuentos por cantidad:',
                '-\$${resumen['descuentosPorTipo'].toStringAsFixed(2)}',
                esDescuento: true,
              ),
            if (resumen['descuentoAdicional'] > 0) ...[
              _buildLineaResumen(
                'Descuento adicional (15%):',
                '-\$${resumen['descuentoAdicional'].toStringAsFixed(2)}',
                esDescuento: true,
              ),
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.orange.shade300, width: 2),
                ),
                child: Text(
                  'Descuento adicional del 15% aplicado por superar 1000 arboles (Total: ${resumen['totalArboles']} arboles)',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
            if (resumen['descuentoAdicional'] == 0 && resumen['totalArboles'] > 0)
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue.shade200, width: 2),
                ),
                child: Text(
                  'No se aplica descuento adicional (requiere mas de 1000 arboles, actual: ${resumen['totalArboles']})',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            _buildLineaResumen(
              'Subtotal con descuentos:',
              '\$${resumen['subtotalConDescuentos'].toStringAsFixed(2)}',
            ),
            _buildLineaResumen('IVA (12%):', '\$${resumen['iva'].toStringAsFixed(2)}'),
            const Divider(height: 20, thickness: 2),
            _buildLineaResumen(
              'TOTAL A PAGAR:',
              '\$${resumen['total'].toStringAsFixed(2)}',
              esTotal: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLineaResumen(String etiqueta, String valor, {bool esDescuento = false, bool esTotal = false}) {
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
              color: esTotal
                  ? Theme.of(context).primaryColor
                  : esDescuento
                      ? Colors.red
                      : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
