import 'package:flutter/material.dart';
import 'package:cajero/domain/entities/product.dart';
import 'package:cajero/domain/entities/cart_item.dart';
import 'package:cajero/presentation/features/cart/states/cart_state.dart';

class CartController extends ValueNotifier<CartState> {
  CartController() : super(CartState.initial());

  // Cargar items (ejemplo con datos de prueba)
  void loadMockCart() {
    final mockItems = [
      CartItem(
        product: Product(
          id: '102',
          name: 'Croissant Mantequilla',
          price: 2.25,
          imageUrl: 'https://images.unsplash.com/photo-1555507036-ab1f4038808a?q=60&w=400&t=final-fix',
          category: 'Panes',
          inStock: true,
        ),
        quantity: 3,
      ),
      CartItem(
        product: Product(
          id: '302',
          name: 'Jugo Naranja Natural',
          price: 3.00,
          imageUrl: 'https://images.pexels.com/photos/1337825/pexels-photo-1337825.jpeg?auto=compress&w=400',
          category: 'Bebidas',
          inStock: true,
        ),
        quantity: 2,
      ),
    ];

    value = value.copyWith(items: mockItems);
  }

  void increaseQuantity(String productId) {
    final updatedItems = value.items.map((item) {
      if (item.product.id == productId) {
        return item.copyWith(quantity: item.quantity + 1);
      }
      return item;
    }).toList();

    value = value.copyWith(items: updatedItems);
  }

  void decreaseQuantity(String productId) {
    final updatedItems = value.items.map((item) {
      if (item.product.id == productId && item.quantity > 1) {
        return item.copyWith(quantity: item.quantity - 1);
      }
      return item;
    }).toList();

    value = value.copyWith(items: updatedItems);
  }

  void removeItem(String productId) {
    final updatedItems = value.items.where((item) =>
    item.product.id != productId
    ).toList();

    value = value.copyWith(items: updatedItems);
  }

  void applyDiscountCode(String code) {
    // Aquí iría la lógica para validar código de descuento
    if (code == 'DESCUENTO10') {
      value = value.copyWith(
        discountCode: code,
        discountPercentage: 10.0,
      );

      debugPrint('Código aplicado: 10% de descuento');
    } else {
      debugPrint('Código inválido');
    }
  }

  void clearCart() {
    value = value.copyWith(
      items: [],
      discountCode: null,
      discountPercentage: 0.0,
    );
  }

  void printOrder() {
    debugPrint('Imprimiendo orden...');
    // Aquí iría la lógica de impresión
  }

  void confirmPurchase(BuildContext context) {
    // Navegar a pantalla de pago
    Navigator.pushNamed(context, '/payment', arguments: value.total);
  }
}
