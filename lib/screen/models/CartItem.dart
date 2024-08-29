import 'dart:convert';

class CartItem {
  final String name;
  final String price;
  final String vendorName;

  CartItem({
    required this.name,
    required this.price,
    required this.vendorName,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'vendorName': vendorName,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      name: map['name'] ?? '',
      price: map['price'] ?? '',
      vendorName: map['vendorName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) =>
      CartItem.fromMap(json.decode(source));
}
