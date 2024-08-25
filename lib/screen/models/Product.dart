class Product {
  String id;
  String category;
  String imageUrl;
  String name;
  String price;

  Product({
    required this.id,
    required this.category,
    required this.imageUrl,
    required this.name,
    required this.price,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      category: map['category'],
      imageUrl: map['imageUrl'],
      name: map['name'],
      price: map['price'],
    );
  }
}
