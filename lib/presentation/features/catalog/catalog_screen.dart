import 'package:cajero/domain/usecases/product/get_products_usecase.dart' show GetProductsUseCase;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cajero/presentation/features/catalog/catalog_controller.dart';
import 'package:cajero/presentation/features/catalog/states/catalog_state.dart';
import 'package:cajero/presentation/features/catalog/widgets/search_bar.dart' as custom;
import 'package:cajero/presentation/features/catalog/widgets/category_filters.dart';
import 'package:cajero/presentation/features/catalog/widgets/product_grid.dart';
import 'package:cajero/presentation/features/catalog/widgets/bottom_cart.dart';
import 'package:cajero/core/providers/cart_provider.dart';
import 'package:cajero/injection/injection_container.dart';
import 'package:cajero/presentation/routes/app_routes.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  late CatalogController _controller;
  final TextEditingController _searchController = TextEditingController();

  final List<String> _categories = ['Todos', 'Dulces', 'Bebidas', 'Panes', 'Snacks'];

  @override
  void initState() {
    super.initState();
    // Inicializamos el controlador usando el Service Locator (sl) configurado
    _controller = CatalogController(getProductsUseCase: sl.getProductsUseCase);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => _controller.navigateToHistory(context),
          icon: const Icon(Icons.history_outlined, color: Color(0xFF4B5563)),
          tooltip: 'Historial de Ventas',
        ),
        title: const Text(
          'Venta Activa',
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            },
            icon: const Icon(Icons.logout, color: Colors.red),
          ),
          Container(
            margin: const EdgeInsets.only(right: 16, left: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.profile);
              },
              icon: const Icon(Icons.person_outline),
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
      body: ValueListenableBuilder<CatalogState>(
        valueListenable: _controller,
        builder: (context, state, child) {
          return Column(
            children: [
              // Barra de Búsqueda con la corrección de la función anónima
              custom.SearchBar(
                controller: _searchController,
                onSearch: (value) => _controller.searchProducts(value),
                onScan: () => _controller.scanBarcode(context),
              ),

              // Filtros de Categoría
              CategoryFilters(
                categories: _categories,
                selectedCategory: state.selectedCategory,
                onCategorySelected: (category) => _controller.filterByCategory(category),
              ),

              // Cuadrícula de Productos
              Expanded(
                child: ProductGrid(
                  products: state.filteredProducts,
                  onProductTap: (product) {
                    _controller.addToCart(context, product);
                  },
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFFFFB74D),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) Navigator.pushNamed(context, AppRoutes.inventory);
          if (index == 2) Navigator.pushNamed(context, AppRoutes.reports);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Ventas'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory_2_outlined), label: 'Inventario'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Reportes'),
        ],
      ),
      bottomSheet: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.totalItems == 0) return const SizedBox.shrink();
          return BottomCart(
            itemCount: cart.totalItems,
            total: cart.total,
            onCheckout: () => _controller.viewCart(context),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _controller.dispose();
    super.dispose();
  }
}