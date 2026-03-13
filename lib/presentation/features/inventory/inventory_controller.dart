import 'package:flutter/material.dart';
import 'package:cajero/domain/entities/product.dart';
import 'package:cajero/domain/usecases/product/get_products_usecase.dart';

class InventoryController extends ChangeNotifier {
  final GetProductsUseCase getProductsUseCase;
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  bool _isLoading = false;

  InventoryController({required this.getProductsUseCase});

  List<Product> get products => _filteredProducts;
  bool get isLoading => _isLoading;

  Future<void> loadInventory() async {
    _isLoading = true;
    notifyListeners();
    _products = await getProductsUseCase.execute();
    _filteredProducts = _products;
    _isLoading = false;
    notifyListeners();
  }

  void search(String query) {
    if (query.isEmpty) {
      _filteredProducts = _products;
    } else {
      _filteredProducts = _products.where((p) => 
        p.name.toLowerCase().contains(query.toLowerCase()) || 
        (p.barcode != null && p.barcode!.contains(query))
      ).toList();
    }
    notifyListeners();
  }
}
