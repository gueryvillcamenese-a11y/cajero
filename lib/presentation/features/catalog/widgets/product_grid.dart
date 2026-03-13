import 'package:flutter/material.dart';
import 'package:cajero/domain/entities/product.dart';
import 'package:cajero/presentation/features/catalog/widgets/product_card.dart';

class ProductGrid extends StatelessWidget {
  final List<Product> products;
  final ValueChanged<Product> onProductTap;

  const ProductGrid({
    super.key,
    required this.products,
    required this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Center(
        child: Text(
          'No se encontraron productos',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 80),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.72,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCard(
          product: product,
          onTap: () => onProductTap(product),
        );
      },
    );
  }
}
