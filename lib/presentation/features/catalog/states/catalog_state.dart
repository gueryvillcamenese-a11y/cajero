import 'package:cajero/domain/entities/product.dart';

class CatalogState {
  final List<Product> products;
  final List<Product> filteredProducts;
  final String selectedCategory;
  final bool isLoading;
  final String searchQuery;

  CatalogState({
    required this.products,
    required this.filteredProducts,
    required this.selectedCategory,
    required this.isLoading,
    required this.searchQuery,
  });

  factory CatalogState.initial() {
    return CatalogState(
      products: [],
      filteredProducts: [],
      selectedCategory: 'Todos',
      isLoading: false,
      searchQuery: '',
    );
  }

  CatalogState copyWith({
    List<Product>? products,
    List<Product>? filteredProducts,
    String? selectedCategory,
    bool? isLoading,
    String? searchQuery,
  }) {
    return CatalogState(
      products: products ?? this.products,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      isLoading: isLoading ?? this.isLoading,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
