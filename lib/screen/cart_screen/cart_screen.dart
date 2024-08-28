
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/CartItem.dart'; // Import the CartItem model

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Future<List<CartItem>> _cartItemsFuture;

  @override
  void initState() {
    super.initState();
    _fetchCartItems();
    _cartItemsFuture = _fetchCartItems(); // Fetch cart items on initialization
  }

  Future<List<CartItem>> _fetchCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? cartItemsStrings = prefs.getStringList('cartItems');

    if (cartItemsStrings != null) {
      return cartItemsStrings
          .map((itemString) => CartItem.fromMap(jsonDecode(itemString)))
          .toList();
    }
    print('list $cartItemsStrings');
    return [];
  }

  Future<void> _removeItem(CartItem item) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? cartItemsStrings = prefs.getStringList('cartItems');

    if (cartItemsStrings != null) {
      List<CartItem> cartItems = cartItemsStrings
          .map((itemString) => CartItem.fromMap(jsonDecode(itemString)))
          .toList();

      cartItems.remove(item); // Remove the item based on overridden equality

      // Update SharedPreferences
      List<String> updatedCartItemsStrings = cartItems
          .map((item) => jsonEncode(item.toMap()))
          .toList();
      await prefs.setStringList('cartItems', updatedCartItemsStrings);

      // Refresh the UI
      setState(() {
        _cartItemsFuture = _fetchCartItems();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);

        },icon: Icon(Icons.arrow_back ,color: Colors.white,size: 24,),),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        backgroundColor: Colors.blue,
        title: const Text('Cart' ,style: TextStyle(color: Colors.white ,fontWeight: FontWeight.bold),),
       centerTitle: true,
      ),
      body: FutureBuilder<List<CartItem>>(
        future: _cartItemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No items in cart'));
          } else {
            final cartItems = snapshot.data!;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return ListTile(
                        title: Container(

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),

                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,

                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(7),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(item.name),
                              Text('Rs. ${item.price}', textAlign: TextAlign.center),
                              Text('Vendor: ${item.vendor}'),
                            ],
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            _removeItem(item);
                          },
                          icon: Icon(Icons.delete),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle order now action
                        print('Order Now button pressed');
                      },
                      child: Text('Order Now' ,style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        textStyle: TextStyle(fontSize: 15 ,),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
