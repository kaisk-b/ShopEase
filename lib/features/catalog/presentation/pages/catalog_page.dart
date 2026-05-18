import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../core/config/app_assets.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../shared/widgets/shopease_logo.dart';
import '../../../cart/application/cart_controller.dart';
import '../../data/product_repository.dart';
import '../../domain/product.dart';
import '../widgets/product_card.dart';
import 'product_details_page.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({ProductRepository? repository, super.key})
    : repository = repository ?? const MockProductRepository();

  final ProductRepository repository;

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  late Future<List<Product>> _productsFuture;
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
    _productsFuture = widget.repository.fetchProducts();
    _searchController.addListener(() {
      setState(() {
        _query = _searchController.text.trim().toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
            title: 'Products could not load',
            subtitle: '${snapshot.error}',
          );
        }

        final products = snapshot.data ?? [];
        if (products.isEmpty) {
          return const EmptyState(
            icon: Icons.inventory_2_outlined,
            title: 'No products yet',
            subtitle: 'Add products to your catalog to show them here.',
          );
        }

        final filteredProducts = _filterProducts(products);
        final popularProducts = filteredProducts
            .where((product) => product.isPopular)
            .take(6)
            .toList();

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _CatalogHeroHeader(),
              const SizedBox(height: 20),
              Text(
                'Welcome to ShopEase',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Find products you love.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 20),
              SearchField(controller: _searchController),
              const SizedBox(height: 24),
              _SectionHeader(
                title: _query.isEmpty ? 'Popular Products' : 'Search Results',
              ),
              const SizedBox(height: 12),
              if (filteredProducts.isEmpty)
                EmptyState(
                  icon: Icons.search_off_rounded,
                  title: 'No products found',
                  subtitle: 'Try searching for another product or category.',
                )
              else ...[
                if (popularProducts.isNotEmpty)
                  for (final product in popularProducts) ...[
                    ProductCard(
                      product: product,
                      onOpenDetails: () => _openDetails(context, product),
                      onAddToCart: () => _addToCart(context, product),
                    ),
                    const SizedBox(height: 8),
                  ],
                const SizedBox(height: 16),
                const _SectionHeader(title: 'All Products'),
                const SizedBox(height: 12),
                for (final product in filteredProducts) ...[
                  ProductCard(
                    product: product,
                    compact: true,
                    onOpenDetails: () => _openDetails(context, product),
                    onAddToCart: () => _addToCart(context, product),
                  ),
                  const SizedBox(height: 8),
                ],
              ],
            ],
          ),
        );
      },
    );
  }

  List<Product> _filterProducts(List<Product> products) {
    if (_query.isEmpty) {
      return products;
    }

    return products.where((product) {
      return product.name.toLowerCase().contains(_query) ||
          product.category.toLowerCase().contains(_query) ||
          product.description.toLowerCase().contains(_query);
    }).toList();
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

  void _openDetails(BuildContext context, Product product) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => ProductDetailsPage(product: product),
      ),
    );
  }
}

class _CatalogHeroHeader extends StatelessWidget {
  const _CatalogHeroHeader();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: 260,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(AppAssets.headerLifestyle, fit: BoxFit.cover),
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.22),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.25),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const ShopEaseLogo(
                                height: 34,
                                textColor: Colors.white,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.9),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  'Collections',
                                  style: Theme.of(context).textTheme.labelLarge
                                      ?.copyWith(fontWeight: FontWeight.w800),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            'Our Everyday Collections',
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  height: 1.05,
                                ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 330,
                            child: Text(
                              'Fresh picks, popular essentials, and curated deals for your next cart.',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({required this.controller, super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: 'Search products or categories',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: controller.text.isEmpty
            ? null
            : IconButton(
                tooltip: 'Clear search',
                onPressed: controller.clear,
                icon: const Icon(Icons.close_rounded),
              ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
    );
  }
}
