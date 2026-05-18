import 'package:flutter/material.dart';

import '../../../../core/utils/currency_formatter.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../cart/application/cart_controller.dart';
import '../../data/product_repository.dart';
import '../../domain/product.dart';
import '../widgets/product_card.dart';
import 'product_details_page.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({ProductRepository? repository, super.key})
    : repository = repository ?? const MockProductRepository();

  final ProductRepository repository;

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  late Future<List<Product>> _productsFuture;
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _productsFuture = widget.repository.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: _productsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return EmptyState(
            icon: Icons.cloud_off_rounded,
            title: 'Categories could not load',
            subtitle: '${snapshot.error}',
          );
        }

        final products = snapshot.data ?? [];
        if (products.isEmpty) {
          return const EmptyState(
            icon: Icons.category_outlined,
            title: 'No categories yet',
            subtitle: 'Products will be grouped here by category.',
          );
        }

        final categories = products.map((product) => product.category).toSet()
          ..addAll(const ['Grocery', 'Computer', 'Men', 'Baby', 'Sports']);
        final sortedCategories = categories.toList()..sort();
        final visibleProducts = _selectedCategory == null
            ? products
            : products
                  .where((product) => product.category == _selectedCategory)
                  .toList();
        final popularProducts = products
            .where((product) => product.isPopular)
            .take(4)
            .toList();

        return LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 760;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Category',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w900),
                      ),
                      Text(
                        'Sort by: Default',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  _PopularStrip(
                    products: popularProducts,
                    onOpenDetails: (product) => _openDetails(context, product),
                  ),
                  const SizedBox(height: 20),
                  if (isWide)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 180,
                          child: _CategoryPanel(
                            categories: sortedCategories,
                            selectedCategory: _selectedCategory,
                            onSelected: _selectCategory,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _ProductGrid(
                            products: visibleProducts,
                            onOpenDetails: (product) =>
                                _openDetails(context, product),
                            onAddToCart: (product) =>
                                _addToCart(context, product),
                          ),
                        ),
                      ],
                    )
                  else ...[
                    _CategoryRail(
                      categories: sortedCategories,
                      selectedCategory: _selectedCategory,
                      onSelected: _selectCategory,
                    ),
                    const SizedBox(height: 16),
                    _ProductGrid(
                      products: visibleProducts,
                      onOpenDetails: (product) =>
                          _openDetails(context, product),
                      onAddToCart: (product) => _addToCart(context, product),
                    ),
                  ],
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _selectCategory(String? category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  void _openDetails(BuildContext context, Product product) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => ProductDetailsPage(product: product),
      ),
    );
  }

  void _addToCart(BuildContext context, Product product) {
    CartScope.of(context).add(product);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} added to cart'),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}

class _PopularStrip extends StatelessWidget {
  const _PopularStrip({required this.products, required this.onOpenDetails});

  final List<Product> products;
  final ValueChanged<Product> onOpenDetails;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Popular Picks',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 174,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final product = products[index];

              return CompactProductTile(
                product: product,
                onOpenDetails: () => onOpenDetails(product),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _CategoryPanel extends StatelessWidget {
  const _CategoryPanel({
    required this.categories,
    required this.selectedCategory,
    required this.onSelected,
  });

  final List<String> categories;
  final String? selectedCategory;
  final ValueChanged<String?> onSelected;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CategoryListTile(
              label: 'All',
              icon: Icons.apps_rounded,
              selected: selectedCategory == null,
              onTap: () => onSelected(null),
            ),
            const Divider(),
            for (final category in categories)
              _CategoryListTile(
                label: category,
                icon: _categoryIcon(category),
                selected: selectedCategory == category,
                onTap: () => onSelected(category),
              ),
          ],
        ),
      ),
    );
  }
}

class _CategoryRail extends StatelessWidget {
  const _CategoryRail({
    required this.categories,
    required this.selectedCategory,
    required this.onSelected,
  });

  final List<String> categories;
  final String? selectedCategory;
  final ValueChanged<String?> onSelected;

  @override
  Widget build(BuildContext context) {
    final items = ['All', ...categories];

    return SizedBox(
      height: 104,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final label = items[index];
          final category = label == 'All' ? null : label;

          return _CategoryTile(
            label: label,
            icon: label == 'All' ? Icons.apps_rounded : _categoryIcon(label),
            selected: selectedCategory == category,
            onTap: () => onSelected(category),
          );
        },
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 92,
      child: Card(
        color: selected ? Theme.of(context).colorScheme.primaryContainer : null,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 28),
                const SizedBox(height: 8),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w800,
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

class _CategoryListTile extends StatelessWidget {
  const _CategoryListTile({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          color: selected
              ? Theme.of(context).colorScheme.primaryContainer
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductGrid extends StatelessWidget {
  const _ProductGrid({
    required this.products,
    required this.onOpenDetails,
    required this.onAddToCart,
  });

  final List<Product> products;
  final ValueChanged<Product> onOpenDetails;
  final ValueChanged<Product> onAddToCart;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const EmptyState(
        icon: Icons.inventory_2_outlined,
        title: 'No products here yet',
        subtitle: 'This category is ready for future products.',
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth >= 900
            ? 4
            : constraints.maxWidth >= 560
            ? 3
            : 2;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.66,
          ),
          itemBuilder: (context, index) {
            final product = products[index];

            return _CategoryProductCard(
              product: product,
              onOpenDetails: () => onOpenDetails(product),
              onAddToCart: () => onAddToCart(product),
            );
          },
        );
      },
    );
  }
}

class _CategoryProductCard extends StatelessWidget {
  const _CategoryProductCard({
    required this.product,
    required this.onOpenDetails,
    required this.onAddToCart,
  });

  final Product product;
  final VoidCallback onOpenDetails;
  final VoidCallback onAddToCart;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onOpenDetails,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: ProductThumbnail(product: product, size: 92)),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.star_rounded, size: 14),
                  const SizedBox(width: 2),
                  Text(
                    '${product.rating}',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      '(${product.reviewCount})',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w800),
              ),
              const Spacer(),
              Text(
                CurrencyFormatter.rupees(product.price),
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                height: 36,
                child: FilledButton(
                  onPressed: onAddToCart,
                  child: const Text('Add'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

IconData _categoryIcon(String category) {
  return switch (category) {
    'Audio' => Icons.headphones_rounded,
    'Beauty' => Icons.spa_rounded,
    'Books' => Icons.menu_book_rounded,
    'Computer' || 'Electronics' => Icons.computer_rounded,
    'Fashion' || 'Men' => Icons.checkroom_rounded,
    'Fitness' || 'Sports' => Icons.fitness_center_rounded,
    'Footwear' => Icons.directions_run_rounded,
    'Gaming' => Icons.sports_esports_rounded,
    'Grocery' => Icons.local_grocery_store_rounded,
    'Home' => Icons.chair_rounded,
    'Stationery' => Icons.edit_note_rounded,
    'Travel' => Icons.luggage_rounded,
    'Wearables' => Icons.watch_rounded,
    'Baby' => Icons.child_care_rounded,
    _ => Icons.category_rounded,
  };
}
