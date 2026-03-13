import 'package:flutter/foundation.dart';
import 'package:cajero/domain/entities/order.dart';

class OrderProvider extends ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders => List.unmodifiable(_orders.reversed);

  void addOrder(Order order) {
    _orders.add(order);
    notifyListeners();
  }

  void clearHistory() {
    _orders.clear();
    notifyListeners();
  }
}
