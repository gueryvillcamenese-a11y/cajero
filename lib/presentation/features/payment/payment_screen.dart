import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cajero/core/providers/cart_provider.dart';
import 'package:cajero/presentation/features/payment/widgets/invoice_dialog.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedMethod = 'Efectivo';
  final TextEditingController _amountController = TextEditingController();
  double _change = 0.0;

  @override
  void initState() {
    super.initState();
    _amountController.addListener(_calculateChange);
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _calculateChange() {
    final cart = context.read<CartProvider>();
    final amount = double.tryParse(_amountController.text) ?? 0.0;
    setState(() {
      _change = amount > cart.total ? amount - cart.total : 0.0;
    });
  }

  void _processPayment(CartProvider cart) {
    final amountReceived = double.tryParse(_amountController.text) ?? 0.0;
    
    if (_selectedMethod == 'Efectivo' && amountReceived < cart.total) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('El monto recibido es insuficiente')),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => InvoiceDialog(
        cart: cart,
        paymentMethod: _selectedMethod,
        amountReceived: amountReceived,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Procesar Pago'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'RESUMEN DE COMPRA',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...cart.items.map((item) => _buildSummaryItem(item.product.name, item.quantity, item.subtotal)),
                  const Divider(height: 32),
                  _buildTotalRow('TOTAL A PAGAR', cart.total),
                  const SizedBox(height: 32),
                  const Text(
                    'MÉTODO DE PAGO',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildMethodBox(Icons.payments_outlined, 'Efectivo'),
                      const SizedBox(width: 12),
                      _buildMethodBox(Icons.credit_card_outlined, 'Tarjeta'),
                      const SizedBox(width: 12),
                      _buildMethodBox(Icons.qr_code_2_outlined, 'QR'),
                    ],
                  ),
                  const SizedBox(height: 32),
                  if (_selectedMethod == 'Efectivo') ...[
                    const Text(
                      'MONTO RECIBIDO',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _amountController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.attach_money, color: Color(0xFFFFB74D)),
                        hintText: '0.00',
                        filled: true,
                        fillColor: Colors.grey[50],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    _buildChangeRow('CAMBIO A ENTREGAR', _change),
                  ],
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () => _processPayment(cart),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFB74D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'CONFIRMAR PAGO',
                  style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildSummaryItem(String name, int qty, double price) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.fastfood, size: 20, color: Color(0xFFFFB74D)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
                Text('\$${(price / qty).toStringAsFixed(2)} x $qty', 
                    style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              ],
            ),
          ),
          Text('\$${price.toStringAsFixed(2)}', 
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildTotalRow(String label, double amount) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFFB74D),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            color: Color(0xFF2D3436),
          ),
        ),
      ],
    );
  }

  Widget _buildChangeRow(String label, double amount) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.yellow[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFFB74D).withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.yellow[900],
            ),
          ),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Colors.yellow[900],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMethodBox(IconData icon, String label) {
    final isSelected = _selectedMethod == label;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _selectedMethod = label),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? Colors.yellow[50] : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? const Color(0xFFFFB74D) : Colors.grey.shade200,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected ? const Color(0xFFFFB74D) : Colors.grey,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.yellow[900] : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
