import 'package:cajero/domain/entities/product.dart';
import 'package:cajero/domain/repositories/i_product_repository.dart';

class GetProductsUseCase {
  final IProductRepository repository;

  GetProductsUseCase(this.repository);

  Future<List<Product>> execute() {
    return repository.getProducts();
  }
}
