class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String category;
  final bool inStock;
  final String? barcode;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.inStock,
    this.barcode,
  });
}
