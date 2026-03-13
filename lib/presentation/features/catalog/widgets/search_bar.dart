import 'package:flutter/material.dart';
import 'package:cajero/core/theme/app_colors.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onSearch;
  final VoidCallback onScan;

  const SearchBar({
    super.key,
    required this.controller,
    required this.onSearch,
    required this.onScan,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ElevatedButton.icon(
            onPressed: onScan,
            icon: const Icon(Icons.qr_code_scanner, size: 18),
            label: const Text(
              'ACTIVAR ESCÁNER',
              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.1),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFB74D),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: controller,
              onChanged: onSearch,
              decoration: const InputDecoration(
                hintText: 'Buscar snacks o bebidas...',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
