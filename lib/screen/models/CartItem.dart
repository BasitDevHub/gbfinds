// import 'package:shared_preferences/shared_preferences.dart';
//
// class CartItem {
//   final String vendorName;
//   final String itemName;
//   final String itemPrice;
//
//   CartItem({
//     required this.vendorName,
//     required this.itemName,
//     required this.itemPrice,
//   });
//
//   // Convert a CartItem into a Map (which can be stored as JSON)
//   Map<String, String> toMap() {
//     return {
//       'vendorName': vendorName,
//       'itemName': itemName,
//       'itemPrice': itemPrice,
//     };
//   }
//
//   // Convert a Map into a CartItem
//   factory CartItem.fromMap(Map<String, String> map) {
//     return CartItem(
//       vendorName: map['vendorName']!,
//       itemName: map['itemName']!,
//       itemPrice: map['itemPrice']!,
//     );
//   }
// }
//
//
class CartItem {
  final String name;
  final String price;
  final String vendor;

  CartItem({
    required this.name,
    required this.price,
    required this.vendor,
  });

  // Convert a Map to a CartItem
  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      name: map['name'] as String? ?? '',
      price: map['price'] as String? ?? '',
      vendor: map['vendor'] as String? ?? '',
    );
  }

  // Convert a CartItem to a Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'vendor': vendor,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CartItem) return false;
    return name == other.name && price == other.price && vendor == other.vendor;
  }

  @override
  int get hashCode => name.hashCode ^ price.hashCode ^ vendor.hashCode;
}
