import '../../../core/services/supabase_service.dart';
import '../domain/product.dart';

abstract class ProductRepository {
  Future<List<Product>> fetchProducts();
}

class MockProductRepository implements ProductRepository {
  const MockProductRepository();

  @override
  Future<List<Product>> fetchProducts() async {
    return sampleProducts;
  }
}

class SupabaseProductRepository implements ProductRepository {
  SupabaseProductRepository({SupabaseService? service})
    : _service = service ?? SupabaseService();

  final SupabaseService _service;

  @override
  Future<List<Product>> fetchProducts() async {
    final response = await _service.client
        .from('products')
        .select(
          'id, name, price, category, description, rating, review_count, '
          'is_popular, image_url',
        )
        .order('id');

    return response
        .map<Product>(
          (item) => Product.fromMap(Map<String, dynamic>.from(item)),
        )
        .toList();
  }
}

const sampleProducts = [
  Product(
    id: 'headphones',
    name: 'Wireless Headphones',
    price: 1999,
    category: 'Audio',
    description: 'Comfortable everyday headphones with crisp sound.',
    rating: 4.7,
    reviewCount: 214,
    isPopular: true,
  ),
  Product(
    id: 'smart-watch',
    name: 'Smart Watch',
    price: 2499,
    category: 'Wearables',
    description: 'Track workouts, messages, and daily habits.',
    rating: 4.5,
    reviewCount: 180,
    isPopular: true,
  ),
  Product(
    id: 'backpack',
    name: 'Backpack',
    price: 999,
    category: 'Travel',
    description: 'Lightweight daily backpack with roomy storage.',
    rating: 4.3,
    reviewCount: 96,
    isPopular: true,
  ),
  Product(
    id: 'running-shoes',
    name: 'Running Shoes',
    price: 1799,
    category: 'Footwear',
    description: 'Breathable trainers built for daily runs and long walks.',
    rating: 4.4,
    reviewCount: 121,
    isPopular: true,
  ),
  Product(
    id: 'cotton-hoodie',
    name: 'Cotton Hoodie',
    price: 1299,
    category: 'Fashion',
    description: 'Soft fleece hoodie with a relaxed everyday fit.',
    rating: 4.2,
    reviewCount: 78,
  ),
  Product(
    id: 'desk-lamp',
    name: 'LED Desk Lamp',
    price: 899,
    category: 'Home',
    description: 'Adjustable study lamp with warm and cool light modes.',
    rating: 4.6,
    reviewCount: 143,
  ),
  Product(
    id: 'water-bottle',
    name: 'Steel Water Bottle',
    price: 599,
    category: 'Fitness',
    description: 'Insulated bottle that keeps drinks cold for hours.',
    rating: 4.1,
    reviewCount: 64,
  ),
  Product(
    id: 'gaming-mouse',
    name: 'Gaming Mouse',
    price: 1499,
    category: 'Gaming',
    description: 'Fast, precise mouse with programmable side buttons.',
    rating: 4.8,
    reviewCount: 240,
    isPopular: true,
  ),
  Product(
    id: 'skin-care-kit',
    name: 'Skin Care Kit',
    price: 1199,
    category: 'Beauty',
    description: 'Simple daily care set with cleanser, serum, and moisturizer.',
    rating: 4.4,
    reviewCount: 88,
  ),
  Product(
    id: 'notebook-set',
    name: 'Notebook Set',
    price: 349,
    category: 'Stationery',
    description: 'Pack of ruled notebooks for classes, planning, and notes.',
    rating: 4.0,
    reviewCount: 47,
  ),
  Product(
    id: 'bluetooth-speaker',
    name: 'Bluetooth Speaker',
    price: 1599,
    category: 'Audio',
    description: 'Portable speaker with punchy bass and long battery life.',
    rating: 4.6,
    reviewCount: 132,
    isPopular: true,
  ),
  Product(
    id: 'sunglasses',
    name: 'Polarized Sunglasses',
    price: 799,
    category: 'Fashion',
    description: 'Lightweight UV-protection sunglasses for daily wear.',
    rating: 4.2,
    reviewCount: 73,
  ),
  Product(
    id: 'laptop-stand',
    name: 'Aluminium Laptop Stand',
    price: 1399,
    category: 'Electronics',
    description: 'Sturdy stand that improves desk posture and airflow.',
    rating: 4.7,
    reviewCount: 165,
    isPopular: true,
  ),
  Product(
    id: 'yoga-mat',
    name: 'Anti-Skid Yoga Mat',
    price: 699,
    category: 'Fitness',
    description: 'Comfortable non-slip mat for yoga and home workouts.',
    rating: 4.3,
    reviewCount: 91,
  ),
  Product(
    id: 'coffee-mug',
    name: 'Ceramic Coffee Mug',
    price: 299,
    category: 'Home',
    description: 'Minimal ceramic mug with a comfortable grip.',
    rating: 4.1,
    reviewCount: 52,
  ),
  Product(
    id: 'phone-case',
    name: 'Shockproof Phone Case',
    price: 499,
    category: 'Electronics',
    description: 'Slim protective case with raised camera edges.',
    rating: 4.4,
    reviewCount: 118,
  ),
  Product(
    id: 'duffel-bag',
    name: 'Weekend Duffel Bag',
    price: 1899,
    category: 'Travel',
    description: 'Spacious travel bag with shoe pocket and side storage.',
    rating: 4.5,
    reviewCount: 84,
  ),
  Product(
    id: 'wireless-keyboard',
    name: 'Wireless Keyboard',
    price: 1699,
    category: 'Electronics',
    description: 'Quiet compact keyboard for work, study, and gaming setups.',
    rating: 4.6,
    reviewCount: 152,
    isPopular: true,
  ),
  Product(
    id: 'face-serum',
    name: 'Vitamin C Face Serum',
    price: 649,
    category: 'Beauty',
    description: 'Lightweight serum for a bright, fresh skincare routine.',
    rating: 4.3,
    reviewCount: 76,
  ),
  Product(
    id: 'novel-pack',
    name: 'Bestseller Novel Pack',
    price: 899,
    category: 'Books',
    description: 'Set of three easy-read bestselling fiction novels.',
    rating: 4.5,
    reviewCount: 104,
  ),
  Product(
    id: 'fitness-band',
    name: 'Fitness Band',
    price: 1299,
    category: 'Wearables',
    description: 'Slim activity tracker with heart-rate and sleep insights.',
    rating: 4.2,
    reviewCount: 99,
  ),
  Product(
    id: 'casual-sneakers',
    name: 'Casual Sneakers',
    price: 1499,
    category: 'Footwear',
    description: 'Everyday sneakers with cushioned soles and clean styling.',
    rating: 4.3,
    reviewCount: 86,
  ),
  Product(
    id: 'gaming-controller',
    name: 'Wireless Game Controller',
    price: 2199,
    category: 'Gaming',
    description: 'Responsive controller for mobile, desktop, and TV gaming.',
    rating: 4.6,
    reviewCount: 137,
  ),
  Product(
    id: 'gel-pen-set',
    name: 'Gel Pen Set',
    price: 249,
    category: 'Stationery',
    description: 'Smooth-writing assorted gel pens for study and planning.',
    rating: 4.1,
    reviewCount: 58,
  ),
  Product(
    id: 'study-guide',
    name: 'Exam Study Guide',
    price: 499,
    category: 'Books',
    description: 'Compact revision guide with practice questions and tips.',
    rating: 4.4,
    reviewCount: 72,
  ),
  Product(
    id: 'organic-fruit-box',
    name: 'Organic Fruit Box',
    price: 799,
    category: 'Grocery',
    description: 'Fresh seasonal fruit selection for healthy snacking.',
    rating: 4.5,
    reviewCount: 112,
    isPopular: true,
  ),
  Product(
    id: 'basmati-rice',
    name: 'Premium Basmati Rice',
    price: 649,
    category: 'Grocery',
    description: 'Aromatic long-grain rice for everyday meals.',
    rating: 4.3,
    reviewCount: 93,
  ),
  Product(
    id: 'full-hd-monitor',
    name: 'Full HD Monitor',
    price: 7999,
    category: 'Computer',
    description:
        '24-inch monitor with sharp colors for work and entertainment.',
    rating: 4.6,
    reviewCount: 126,
    isPopular: true,
  ),
  Product(
    id: 'webcam',
    name: 'HD Webcam',
    price: 1199,
    category: 'Computer',
    description: 'Clear video camera for meetings, classes, and streaming.',
    rating: 4.2,
    reviewCount: 67,
  ),
  Product(
    id: 'mens-shirt',
    name: 'Men Cotton Shirt',
    price: 999,
    category: 'Men',
    description: 'Breathable cotton shirt with a polished casual fit.',
    rating: 4.2,
    reviewCount: 81,
  ),
  Product(
    id: 'leather-wallet',
    name: 'Leather Wallet',
    price: 699,
    category: 'Men',
    description: 'Slim wallet with card slots and a soft leather finish.',
    rating: 4.1,
    reviewCount: 54,
  ),
  Product(
    id: 'baby-blanket',
    name: 'Soft Baby Blanket',
    price: 599,
    category: 'Baby',
    description: 'Gentle cotton blanket for naps and stroller rides.',
    rating: 4.7,
    reviewCount: 69,
  ),
  Product(
    id: 'baby-toy-set',
    name: 'Baby Toy Set',
    price: 749,
    category: 'Baby',
    description: 'Colorful early-learning toys with soft rounded edges.',
    rating: 4.4,
    reviewCount: 75,
  ),
  Product(
    id: 'football',
    name: 'Training Football',
    price: 899,
    category: 'Sports',
    description: 'Durable football for practice, parks, and weekend matches.',
    rating: 4.3,
    reviewCount: 90,
  ),
  Product(
    id: 'cricket-bat',
    name: 'Willow Cricket Bat',
    price: 1999,
    category: 'Sports',
    description: 'Balanced cricket bat for casual and club-level play.',
    rating: 4.5,
    reviewCount: 101,
  ),
];
