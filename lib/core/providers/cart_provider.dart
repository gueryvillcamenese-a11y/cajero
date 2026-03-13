import 'package:flutter/foundation.dart';
import 'package:cajero/domain/entities/product.dart';
import 'package:cajero/domain/entities/cart_item.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get totalItems => _items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal => _items.fold(0.0, (sum, item) => sum + item.subtotal);

  double get tax => subtotal * 0.15; // 15% IVA fijo

  double get total => subtotal + tax;

  bool get isEmpty => _items.isEmpty;

  void addItem(Product product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);

    if (index >= 0) {
      _items[index] = _items[index].copyWith(quantity: _items[index].quantity + 1);
    } else {
      _items.add(CartItem(product: product, quantity: 1));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  void updateQuantity(String productId, int newQuantity) {
    if (newQuantity <= 0) {
      removeItem(productId);
      return;
    }
    
    final index = _items.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      _items[index] = _items[index].copyWith(quantity: newQuantity);
      notifyListeners();
    }
  }

  void increaseQuantity(String productId) {
    final index = _items.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      updateQuantity(productId, _items[index].quantity + 1);
    }
  }

  void decreaseQuantity(String productId) {
    final index = _items.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      updateQuantity(productId, _items[index].quantity - 1);
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
