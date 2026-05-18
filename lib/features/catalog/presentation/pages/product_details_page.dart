import 'package:flutter/material.dart';

import '../../../../core/utils/currency_formatter.dart';
import '../../../cart/application/cart_controller.dart';
import '../../domain/product.dart';
import '../widgets/product_card.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({required this.product, super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: ProductThumbnail(product: product, size: 180)),
            const SizedBox(height: 24),
            Text(
              product.category,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.name,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.star_rounded, size: 20),
                const SizedBox(width: 4),
                Text('${product.rating}'),
                const SizedBox(width: 6),
                Text('(${product.reviewCount} reviews)'),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              CurrencyFormatter.rupees(product.price),
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 20),
            Text(
              'Details',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text(
              product.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_rounded),
                    label: const Text('Back'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _addToCart(context),
                    icon: const Icon(Icons.add_shopping_cart_rounded),
                    label: const Text('Add to Cart'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _addToCart(BuildContext context) {
    CartScope.of(context).add(product);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} added to cart'),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
