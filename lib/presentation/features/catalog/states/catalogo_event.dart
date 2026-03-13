import 'package:cajero/domain/entities/product.dart';

abstract class CatalogEvent {}

class LoadProductsEvent extends CatalogEvent {}

class SearchProductsEvent extends CatalogEvent {
  final String query;
  SearchProductsEvent(this.query);
}

class FilterByCategoryEvent extends CatalogEvent {
  final String category;
  FilterByCategoryEvent(this.category);
}

class ScanBarcodeEvent extends CatalogEvent {}

class AddToCartEvent extends CatalogEvent {
  final Product product;
  AddToCartEvent(this.product);
}

class ViewCartEvent extends CatalogEvent {}
