import 'package:flutter/material.dart';

import '../../../../core/utils/currency_formatter.dart';
import '../../application/cart_controller.dart';

class CartBottomSheet extends StatelessWidget {
  const CartBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = CartScope.of(context);

    return AnimatedBuilder(
      animation: cart,
      builder: (context, _) {
        return SizedBox(
          height: 420,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Cart',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: cart.isEmpty
                      ? const Center(child: Text('Your cart is empty'))
                      : ListView.separated(
                          itemCount: cart.items.length,
                          separatorBuilder: (context, index) => const Divider(),
                          itemBuilder: (context, index) {
                            final item = cart.items[index];

                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(item.name),
                              subtitle: Text(item.category),
                              trailing: Text(
                                CurrencyFormatter.rupees(item.price),
                              ),
                            );
                          },
                        ),
                ),
                const Divider(),
                Text(
                  'Total: ${CurrencyFormatter.rupees(cart.total)}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: cart.isEmpty
                            ? null
                            : () {
                                cart.clear();
                                Navigator.pop(context);
                              },
                        child: const Text('Clear Cart'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: cart.isEmpty
                            ? null
                            : () {
                                final total = cart.total;
                                cart.clear();
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Fake order placed. Total: '
                                      '${CurrencyFormatter.rupees(total)}',
                                    ),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                        child: const Text('Checkout'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
