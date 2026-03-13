import 'package:flutter/material.dart';
import 'package:cajero/injection/injection_container.dart';
import 'package:cajero/presentation/features/inventory/inventory_controller.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  late InventoryController _controller;

  @override
  void initState() {
    super.initState();
    _controller = InventoryController(getProductsUseCase: sl.getProductsUseCase);
    _controller.loadInventory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Consulta de Inventario'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, child) {
          if (_controller.isLoading) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFFFFB74D)));
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    onChanged: _controller.search,
                    decoration: const InputDecoration(
                      hintText: 'Buscar por nombre o SKU...',
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              _buildFilters(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Text(
                      'Mostrando ${_controller.products.length} productos',
                      style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Icon(Icons.tune, size: 16, color: Colors.yellow[800]),
                    const SizedBox(width: 4),
                    Text('Filtrar', style: TextStyle(fontSize: 12, color: Colors.yellow[800], fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _controller.products.length,
                  itemBuilder: (context, index) {
                    final item = _controller.products[index];
                    return _buildInventoryItem(
                      item.name, 
                      'SKU: ${item.barcode ?? "N/A"}', 
                      item.price, 
                      item.inStock ? 'En Stock' : 'Agotado', 
                      item.inStock ? Colors.green : Colors.red
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.qr_code_scanner),
                    label: const Text('Escanear', style: TextStyle(fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFB74D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
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
        currentIndex: 1,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Ventas'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory_2_outlined), label: 'Inventario'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Reportes'),
          BottomNavigationBarItem(icon: Icon(Icons.groups_outlined), label: 'Equipo'),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _filterChip('Todos', true),
          _filterChip('Snacks', false),
          _filterChip('Bebidas', false),
          _filterChip('Panes', false),
        ],
      ),
    );
  }

  Widget _filterChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFFFB74D) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isSelected ? Colors.transparent : Colors.grey.shade200),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildInventoryItem(String name, String sku, double price, String status, Color statusColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.fastfood, color: Color(0xFFFFB74D)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(sku, style: const TextStyle(color: Colors.grey, fontSize: 10)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 4),
                    Text(status, style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('\$${price.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const Text('Detalles', style: TextStyle(color: Color(0xFFFFB74D), fontSize: 10, fontWeight: FontWeight.bold, decoration: TextDecoration.underline)),
            ],
          ),
        ],
      ),
    );
  }
}
