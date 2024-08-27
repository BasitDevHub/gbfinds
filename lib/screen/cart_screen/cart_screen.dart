// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class CartScreen extends StatelessWidget {
//   final List<String> cartItems;
//
//   const CartScreen({super.key, required this.cartItems});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(16),
//             bottomRight: Radius.circular(16),
//           ),
//         ),
//         title: const Text('Cart'),
//         backgroundColor: Colors.green,
//       ),
//       body: ListView.builder(
//         padding: const EdgeInsets.all(16.0),
//         itemCount: cartItems.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(cartItems[index]),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

import '../models/CartItem.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> _cartItems = [];

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  Future<void> _loadCartItems() async {
    List<CartItem> items = await CartPreferences.getCartItems();
    setState(() {
      _cartItems = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              await CartPreferences.clearCart();
              setState(() {
                _cartItems = [];
              });
            },
          ),
        ],
      ),
      body: _cartItems.isEmpty
          ? Center(child: Text('Your cart is empty'))
          : ListView.builder(
        itemCount: _cartItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_cartItems[index].itemName),
            subtitle: Text(_cartItems[index].vendorName),
            trailing: Text(_cartItems[index].itemPrice),
          );
        },
      ),
    );
  }
}
