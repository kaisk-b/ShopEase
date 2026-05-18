class Product {
  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.description,
    required this.rating,
    required this.reviewCount,
    this.isPopular = false,
    this.imageUrl,
  });

  final String id;
  final String name;
  final int price;
  final String category;
  final String description;
  final double rating;
  final int reviewCount;
  final bool isPopular;
  final String? imageUrl;

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: '${map['id']}',
      name: map['name'] as String? ?? 'Unnamed product',
      price: (map['price'] as num?)?.round() ?? 0,
      category: map['category'] as String? ?? 'General',
      description: map['description'] as String? ?? '',
      rating: (map['rating'] as num?)?.toDouble() ?? 4,
      reviewCount: (map['review_count'] as num?)?.round() ?? 0,
      isPopular: map['is_popular'] as bool? ?? false,
      imageUrl: map['image_url'] as String?,
    );
  }
}
