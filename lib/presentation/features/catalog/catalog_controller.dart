import 'package:flutter/material.dart';
import 'package:cajero/domain/entities/product.dart';
import 'package:cajero/domain/usecases/product/get_products_usecase.dart';
import 'package:cajero/presentation/features/catalog/states/catalog_state.dart';
import 'package:provider/provider.dart';
import 'package:cajero/core/providers/cart_provider.dart';

class CatalogController extends ValueNotifier<CatalogState> {
  final GetProductsUseCase getProductsUseCase;

  CatalogController({required this.getProductsUseCase}) : super(CatalogState.initial()) {
    loadProducts();
  }

  Future<void> loadProducts() async {
    final products = await getProductsUseCase.execute();
    value = value.copyWith(
      products: products,
      filteredProducts: products,
    );
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      value = value.copyWith(
        filteredProducts: value.products,
        searchQuery: query,
      );
      return;
    }

    final filtered = value.products.where((product) =>
        product.name.toLowerCase().contains(query.toLowerCase())
    ).toList();

    value = value.copyWith(
      filteredProducts: filtered,
      searchQuery: query,
    );
  }

  void filterByCategory(String category) {
    if (category == 'Todos') {
      value = value.copyWith(
        filteredProducts: value.products,
        selectedCategory: category,
      );
      return;
    }

    final filtered = value.products.where((product) =>
        product.category == category
    ).toList();

    value = value.copyWith(
      filteredProducts: filtered,
      selectedCategory: category,
    );
  }

  void addToCart(BuildContext context, Product product) {
    context.read<CartProvider>().addItem(product);
    
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} añadido al carrito'),
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> scanBarcode(BuildContext context) async {
    final String? result = await Navigator.pushNamed(context, '/scanner') as String?;
    if (result != null && context.mounted) {
      try {
        final product = value.products.firstWhere(
          (p) => p.id == result || (p.barcode != null && p.barcode == result)
        );
        addToCart(context, product);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Producto no encontrado'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void viewCart(BuildContext context) {
    Navigator.pushNamed(context, '/cart');
  }

  void navigateToHistory(BuildContext context) {
    Navigator.pushNamed(context, '/history');
  }
}
