import 'package:shared_preferences/shared_preferences.dart';

class CartItem {
  final String vendorName;
  final String itemName;
  final String itemPrice;

  CartItem({
    required this.vendorName,
    required this.itemName,
    required this.itemPrice,
  });

  // Convert a CartItem into a Map (which can be stored as JSON)
  Map<String, String> toMap() {
    return {
      'vendorName': vendorName,
      'itemName': itemName,
      'itemPrice': itemPrice,
    };
  }

  // Convert a Map into a CartItem
  factory CartItem.fromMap(Map<String, String> map) {
    return CartItem(
      vendorName: map['vendorName']!,
      itemName: map['itemName']!,
      itemPrice: map['itemPrice']!,
    );
  }
}

class CartPreferences {
  static const String _cartKey = 'cartItems';

  // Save a new item to the cart
  static Future<void> addItemToCart(CartItem cartItem) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? cartItems = prefs.getStringList(_cartKey) ?? [];

    // Convert the CartItem to a JSON string and add it to the list
    cartItems.add(cartItem.toMap().toString());

    await prefs.setStringList(_cartKey, cartItems);
  }

  // Retrieve all items from the cart
  static Future<List<CartItem>> getCartItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? cartItems = prefs.getStringList(_cartKey) ?? [];

    // Convert each JSON string back into a CartItem object
    return cartItems
        .map((item) => CartItem.fromMap(_stringToMap(item)))
        .toList();
  }

  // Remove all items from the cart (clear the cart)
  static Future<void> clearCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cartKey);
  }

  // Helper function to convert a string back into a Map
  static Map<String, String> _stringToMap(String source) {
    Map<String, String> map = {};
    source
        .substring(1, source.length - 1)
        .split(', ')
        .forEach((element) {
      var keyValue = element.split(': ');
      map[keyValue[0]] = keyValue[1];
    });
    return map;
  }
}
