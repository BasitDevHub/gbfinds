class Item {
  String id;
  String category;
  String imageUrl;
  String name;
  String price;

  Item({
    required this.id,
    required this.category,
    required this.imageUrl,
    required this.name,
    required this.price,
  });

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      category: map['category'],
      imageUrl: map['imageUrl'],
      name: map['name'],
      price: map['price'],
    );
  }
}
