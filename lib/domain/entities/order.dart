import 'package:cajero/domain/entities/cart_item.dart';

class Order {
  final String id;
  final List<CartItem> items;
  final double total;
  final DateTime date;
  final String paymentMethod;
  final double amountReceived;

  Order({
    required this.id,
    required this.items,
    required this.total,
    required this.date,
    required this.paymentMethod,
    this.amountReceived = 0.0,
  });

  double get change => amountReceived > total ? amountReceived - total : 0.0;
}
