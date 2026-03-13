import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cajero/core/providers/cart_provider.dart';
import 'package:cajero/presentation/features/cart/widgets/cart_item_widget.dart';
import 'package:cajero/presentation/features/cart/widgets/cart_summary.dart';
import 'package:cajero/core/theme/app_colors.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F6F8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Orden Actual',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.read<CartProvider>().clear();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Carrito vaciado')),
              );
            },
            child: const Text(
              'Limpiar',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFFECAB0F),
              ),
            ),
          ),
        ],
      ),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.items.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Tu carrito está vacío',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              // Customer Info
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.person_outline,
                              size: 18,
                              color: Colors.grey.shade600,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Cliente General',
                              style: TextStyle(
                                color: Color(0xFF374151),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFB74D).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        '#ORD-4292',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Lista de productos
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    final item = cart.items[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: CartItemWidget(
                        item: item,
                        onIncrease: () => cart.increaseQuantity(
                          item.product.id,
                        ),
                        onDecrease: () => cart.decreaseQuantity(
                          item.product.id,
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Summary
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CartSummary(
                  subtotal: cart.subtotal,
                  tax: cart.tax,
                  total: cart.total,
                  totalItems: cart.totalItems,
                ),
              ),

              const SizedBox(height: 16),

              // Action Buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Imprimiendo orden...')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade200,
                          foregroundColor: Colors.grey.shade800,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Icon(Icons.print),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 3,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/payment');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFB74D),
                          foregroundColor: const Color(0xFF1F2937),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 8,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check_circle),
                            SizedBox(width: 8),
                            Text(
                              'Confirmar Compra',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Payment Options
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildPaymentOption(
                      context: context,
                      icon: Icons.payments,
                      label: 'Efectivo',
                    ),
                    const SizedBox(width: 24),
                    _buildPaymentOption(
                      context: context,
                      icon: Icons.qr_code_scanner,
                      label: 'Escanear',
                    ),
                    const SizedBox(width: 24),
                    _buildPaymentOption(
                      context: context,
                      icon: Icons.qr_code,
                      label: 'Código QR',
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPaymentOption({
    required BuildContext context,
    required IconData icon,
    required String label,
  }) {
    return GestureDetector(
      onTap: () {
        if (label == 'QR Code') {
          Navigator.pushNamed(context, '/payment');
        } else {
          debugPrint('Pago seleccionado: $label');
        }
      },
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Icon(
              icon,
              size: 20,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
