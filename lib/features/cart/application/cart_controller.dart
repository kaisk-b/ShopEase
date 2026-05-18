import 'package:flutter/widgets.dart';

import '../../catalog/domain/product.dart';

class CartController extends ChangeNotifier {
  final List<Product> _items = [];

  List<Product> get items => List.unmodifiable(_items);
  int get itemCount => _items.length;
  int get total => _items.fold(0, (sum, item) => sum + item.price);
  bool get isEmpty => _items.isEmpty;

  void add(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  int quantityFor(Product product) {
    return _items.where((item) => item.id == product.id).length;
  }
}

class CartScope extends InheritedNotifier<CartController> {
  const CartScope({
    required CartController controller,
    required super.child,
    super.key,
  }) : super(notifier: controller);

  static CartController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<CartScope>();
    assert(scope != null, 'CartScope was not found above this widget.');
    return scope!.notifier!;
  }
}
