import 'package:flutter/material.dart';

import '../../../../core/utils/currency_formatter.dart';
import '../../domain/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.product,
    required this.onAddToCart,
    this.onOpenDetails,
    this.compact = false,
    super.key,
  });

  final Product product;
  final VoidCallback onAddToCart;
  final VoidCallback? onOpenDetails;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onOpenDetails,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                ProductThumbnail(product: product, size: compact ? 72 : 90),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.category,
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        product.name,
                        maxLines: compact ? 1 : 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.star_rounded, size: 16),
                          const SizedBox(width: 3),
                          Text('${product.rating}'),
                          const SizedBox(width: 8),
                          Text(CurrencyFormatter.rupees(product.price)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: FilledButton.icon(
                          onPressed: onAddToCart,
                          icon: const Icon(Icons.add_shopping_cart_rounded),
                          label: const Text('Add'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CompactProductTile extends StatelessWidget {
  const CompactProductTile({
    required this.product,
    required this.onOpenDetails,
    super.key,
  });

  final Product product;
  final VoidCallback onOpenDetails;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onOpenDetails,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductThumbnail(product: product, size: 72),
                const SizedBox(height: 10),
                Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 4),
                Text(
                  CurrencyFormatter.rupees(product.price),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductThumbnail extends StatelessWidget {
  const ProductThumbnail({required this.product, this.size = 90, super.key});

  final Product product;
  final double size;

  @override
  Widget build(BuildContext context) {
    if (product.imageUrl != null && product.imageUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          product.imageUrl!,
          width: size,
          height: size,
          fit: BoxFit.cover,
        ),
      );
    }

    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Color(0xFFEDE7DE),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: SizedBox(
        width: size,
        height: size,
        child: const Icon(Icons.shopping_bag_outlined, size: 40),
      ),
    );
  }
}
