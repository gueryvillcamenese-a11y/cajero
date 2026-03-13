import 'package:cajero/domain/entities/product.dart';

abstract class IProductRepository {
  Future<List<Product>> getProducts();
}
