import 'package:get/get.dart';

class CartController extends GetxController {
  // Observable list of cart items
  var cartItems = <Map<String, dynamic>>[].obs;

  // Add item to cart
  void addItem(String name, String price) {
    cartItems.add({'name': name, 'price': price});
  }

  // Remove item from cart
  void removeItem(int index) {
    cartItems.removeAt(index);
  }
}
