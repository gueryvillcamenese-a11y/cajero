import 'package:flutter/material.dart';
import 'package:cajero/domain/entities/cart_item.dart';
import 'package:cajero/core/theme/app_colors.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback? onRemove;

  const CartItemWidget({
    super.key,
    required this.item,
    required this.onIncrease,
    required this.onDecrease,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Imagen del producto (OBLIGATORIO)
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade50,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  item.product.imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                        strokeWidth: 2,
                        color: AppColors.brandPrimary,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade200,
                      child: const Icon(
                        Icons.fastfood_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Info: Nombre y Precio (OBLIGATORIO)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${item.product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFD09306),
                    ),
                  ),
                ],
              ),
            ),

            // Controles de cantidad
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Botón restar
                  SizedBox(
                    width: 32,
                    height: 32,
                    child: IconButton(
                      onPressed: onDecrease,
                      icon: const Icon(Icons.remove, size: 16),
                      padding: EdgeInsets.zero,
                      color: Colors.grey.shade700,
                    ),
                  ),

                  // Cantidad
                  SizedBox(
                    width: 24,
                    child: Text(
                      '${item.quantity}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Botón sumar
                  SizedBox(
                    width: 32,
                    height: 32,
                    child: IconButton(
                      onPressed: onIncrease,
                      icon: const Icon(Icons.add, size: 16),
                      padding: EdgeInsets.zero,
                      color: AppColors.brandPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
