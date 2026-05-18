import 'package:flutter/material.dart';

import '../../../../core/utils/currency_formatter.dart';
import '../../../cart/application/cart_controller.dart';
import '../../../cart/presentation/widgets/cart_bottom_sheet.dart';
import '../../../catalog/presentation/pages/categories_page.dart';
import '../../../catalog/presentation/pages/catalog_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../../../../shared/widgets/shopease_logo.dart';
import '../widgets/spotlight_nav_bar.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;
  int _homeRefreshToken = 0;

  void _showCart() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (_) => const CartBottomSheet(),
    );
  }

  void _handleNavTap(int index) {
    if (index == 2) {
      _showCart();
      return;
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  void _goHome() {
    setState(() {
      _selectedIndex = 0;
      _homeRefreshToken++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = CartScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          key: const ValueKey('app-logo-home-button'),
          borderRadius: BorderRadius.circular(8),
          onTap: _goHome,
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: ShopEaseLogo(height: 34),
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Profile',
            onPressed: () {
              setState(() {
                _selectedIndex = 3;
              });
            },
            icon: const Icon(Icons.person_outline_rounded),
          ),
          AnimatedBuilder(
            animation: cart,
            builder: (context, _) {
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: _showCart,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.shopping_cart_outlined),
                        const SizedBox(width: 6),
                        Text('${cart.itemCount}'),
                        const SizedBox(width: 12),
                        Text(CurrencyFormatter.rupees(cart.total)),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          CatalogPage(key: ValueKey(_homeRefreshToken)),
          const CategoriesPage(),
          const SizedBox.shrink(),
          const ProfilePage(),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
          child: SpotlightNavBar(
            selectedIndex: _selectedIndex,
            onItemSelected: _handleNavTap,
          ),
        ),
      ),
    );
  }
}
