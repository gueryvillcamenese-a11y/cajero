import 'package:cajero/domain/entities/cart_item.dart';

class CartState {
  final List<CartItem> items;
  final String? discountCode;
  final double discountPercentage;
  final bool isLoading;

  CartState({
    required this.items,
    this.discountCode,
    this.discountPercentage = 0.0,
    this.isLoading = false,
  });

  // Cálculos
  double get subtotal {
    return items.fold(0.0, (sum, item) => sum + item.subtotal);
  }

  double get tax {
    return subtotal * 0.08; // 8% de impuesto
  }

  double get discount {
    return subtotal * (discountPercentage / 100);
  }

  double get total {
    return subtotal + tax - discount;
  }

  int get totalItems {
    return items.fold(0, (sum, item) => sum + item.quantity);
  }

  factory CartState.initial() {
    return CartState(items: []);
  }

  CartState copyWith({
    List<CartItem>? items,
    String? discountCode,
    double? discountPercentage,
    bool? isLoading,
  }) {
    return CartState(
      items: items ?? this.items,
      discountCode: discountCode ?? this.discountCode,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
