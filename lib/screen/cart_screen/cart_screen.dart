
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/CartItem.dart';
import '../order_screen/PurchaseScreen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key, required this.shopName, required this.vendorId, required this.accountName, required this.accountNumber});

  final String shopName;
  final String vendorId;

  final String accountName;
  final String accountNumber;
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> cartItems = [];

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  Future<void> _loadCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cartItemsJson = prefs.getStringList('cart_items') ?? [];

    setState(() {
      cartItems = cartItemsJson.map((json) => CartItem.fromJson(json)).toList();
    });
  }

  void _navigateToPurchaseScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PurchaseScreen(
          cartItems: cartItems, shopName: widget.shopName, vendorId: widget.vendorId, accountName: widget.accountName, accountNumber: widget.accountNumber // Pass cart items to PurchaseScreen
        ),
      ),
    );
  }

  Future<void> _removeFromCart(int index) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cartItemsJson = prefs.getStringList('cart_items') ?? [];

    cartItemsJson.removeAt(index); // Remove the item at the specified index
    await prefs.setStringList('cart_items', cartItemsJson);

    setState(() {
      cartItems.removeAt(index); // Update the UI by removing the item from the list
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Item removed from cart'),
      ),
    );
  }

  double _calculateTotalPrice() {
    return cartItems.fold(0.0, (total, item) {
      final price = double.tryParse(item.price) ?? 0.0;
      return total + price;
    });
  }



  @override
  Widget build(BuildContext context) {
    final totalPrice = _calculateTotalPrice();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 24,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        backgroundColor: Colors.blue,
        title: const Text(
          'Cart',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: cartItems.isEmpty
          ? Center(child: Text('No items in cart'))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 2),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 5,
                                      blurRadius: 10,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name,
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Rs: ' + item.price,
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                      ),
                                    ),
                                    Text(
                                      'Vendor: ' + item.vendorName,
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                _removeFromCart(index); // Handle deletion
                              },
                              icon: Icon(Icons.delete),
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Total Price: Rs. ${totalPrice.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
          ),
          BottomAppBar(

            child: Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _navigateToPurchaseScreen,
                child: Text('Buy Now' ,style: TextStyle(color: Colors.white ,fontWeight: FontWeight.w700), ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,

                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void fetchVendorDetails() async {
    try {
      final databaseReference = FirebaseDatabase.instance
          .ref('vendorsDetail')
          .child(widget.vendorId);

      DataSnapshot dataSnapshot = await databaseReference.get();

      if (dataSnapshot.exists) {
        final data = dataSnapshot.value as Map<dynamic, dynamic>?;

        if (data != null) {
          // Extract the relevant vendor details
          final String ownerName = data['ownerName'] ?? 'N/A';
          final String ownerContact = data['ownerContact'] ?? 'N/A';
          final String shopAddress = data['shopAddress'] ?? 'N/A';
          final String email = data['email'] ?? 'N/A';

          // Display or use the details as needed
          print('Owner Name: $ownerName');
          print('Owner Contact: $ownerContact');
          print('Shop Address: $shopAddress');
          print('Email: $email');
        } else {
          print('No data found for the vendor');
        }
      } else {
        print('Vendor does not exist');
      }
    } catch (e) {
      print('Error fetching vendor details: $e');
    }
  }

}
