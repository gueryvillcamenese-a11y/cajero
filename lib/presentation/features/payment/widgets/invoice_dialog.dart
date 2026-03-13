import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:cajero/core/providers/cart_provider.dart';
import 'package:cajero/core/providers/order_provider.dart';
import 'package:cajero/domain/entities/order.dart';

class InvoiceDialog extends StatelessWidget {
  final CartProvider cart;
  final String paymentMethod;
  final double amountReceived;

  const InvoiceDialog({
    super.key,
    required this.cart,
    required this.paymentMethod,
    this.amountReceived = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    final subtotal = cart.total / 1.15;
    final isv = cart.total - subtotal;
    final change = amountReceived > cart.total ? amountReceived - cart.total : 0.0;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              const Icon(Icons.check_circle_outline, color: Color(0xFFFFB74D), size: 64),
              const SizedBox(height: 16),
              const Text(
                '¡VENTA EXITOSA!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Demi Cashier - POS System',
                style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
              ),
              const Divider(height: 32),

              // Info
              _buildInfoRow('Fecha:', dateFormat.format(now)),
              _buildInfoRow('Método:', paymentMethod),
              const SizedBox(height: 16),

              // Items Header
              const Row(
                children: [
                  Expanded(flex: 3, child: Text('Producto', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(child: Text('Cant.', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(flex: 2, child: Text('Total', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold))),
                ],
              ),
              const SizedBox(height: 8),
              
              // Items List
              ...cart.items.map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    Expanded(flex: 3, child: Text(item.product.name, style: const TextStyle(fontSize: 13))),
                    Expanded(child: Text('${item.quantity}', textAlign: TextAlign.center, style: const TextStyle(fontSize: 13))),
                    Expanded(flex: 2, child: Text('\$${item.subtotal.toStringAsFixed(2)}', textAlign: TextAlign.right, style: const TextStyle(fontSize: 13))),
                  ],
                ),
              )),

              const Divider(height: 32),

              // Totals
              _buildTotalRow('Subtotal (Sin Imp.):', '\$${subtotal.toStringAsFixed(2)}'),
              _buildTotalRow('ISV (15%):', '\$${isv.toStringAsFixed(2)}'),
              const SizedBox(height: 8),
              _buildTotalRow('TOTAL:', '\$${cart.total.toStringAsFixed(2)}', isBold: true, fontSize: 18),
              
              if (paymentMethod == 'Efectivo') ...[
                const SizedBox(height: 8),
                _buildTotalRow('Recibido:', '\$${amountReceived.toStringAsFixed(2)}'),
                _buildTotalRow('Cambio:', '\$${change.toStringAsFixed(2)}', color: Colors.green[700]),
              ],

              const SizedBox(height: 32),

              // Actions
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // Aquí iría la lógica de impresión real
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Simulando impresión...')),
                        );
                      },
                      icon: const Icon(Icons.print),
                      label: const Text('Imprimir'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFFFFB74D),
                        side: const BorderSide(color: Color(0xFFFFB74D)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Guardar en el historial antes de limpiar y cerrar
                        final orderProvider = context.read<OrderProvider>();
                        orderProvider.addOrder(Order(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          items: List.from(cart.items),
                          total: cart.total,
                          date: DateTime.now(),
                          paymentMethod: paymentMethod,
                          amountReceived: amountReceived,
                        ));

                        cart.clear();
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFB74D),
                      ),
                      child: const Text('LISTO'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildTotalRow(String label, String value, {bool isBold = false, double fontSize = 14, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: fontSize,
          )),
          Text(value, style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: fontSize,
            color: color,
          )),
        ],
      ),
    );
  }
}
