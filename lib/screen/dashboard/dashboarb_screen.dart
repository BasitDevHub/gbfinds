import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../cart_screen/cart_screen.dart';
import '../models/CartItem.dart';
import '../models/Item.dart';
import '../models/Product.dart';
import '../order_screen/PurchaseScreen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, required this.shopName});

  final String shopName;

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DatabaseReference databaseRef =
      FirebaseDatabase.instance.ref('allItems');

  // Main categories
  final List<String> mainCategories = ['All', 'Items We Eat', 'Items We Wear'];

  // Selected main category
  String selectedCategory = 'All';

  // Cart items
  final List<String> cartItems = [];

  List<Product> allItems = [];
  List<Product> filteredItems = [];

  bool isLoading = true; // Track loading state

  void fetchAndHandleItems() async {
    final databaseReference =
        FirebaseDatabase.instance.ref("allItems").child(widget.shopName);

    DataSnapshot dataSnapshot = await databaseReference.get();

    if (dataSnapshot.exists) {
      final data = dataSnapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        final Map<String, dynamic> typedData = data.map(
          (key, value) =>
              MapEntry(key.toString(), value as Map<dynamic, dynamic>),
        );

        List<Product> items = [];

        typedData.forEach((key, value) {
          if (value is Map<dynamic, dynamic>) {
            final itemMap = value.cast<String, dynamic>();

            try {
              final item = Product.fromMap(itemMap); // Change to Product
              items.add(item);
            } catch (e) {
              print('Error creating Product: $e'); // Adjusted error message
            }
          }
        });

        setState(() {
          allItems = items;
          filteredItems = items; // Set initial filtered items
          isLoading = false; // Data fetching complete
        });
      }
    } else {
      print('No data available');
      setState(() {
        isLoading = false; // Data fetching complete
      });
    }
  }

  void fetchItemsWeEat() async {
    final databaseReference = FirebaseDatabase.instance
        .ref("vendors")
        .child(widget.shopName)
        .child("Food");

    DataSnapshot dataSnapshot = await databaseReference.get();

    if (dataSnapshot.exists) {
      final data = dataSnapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        final Map<String, dynamic> typedData = data.map(
          (key, value) =>
              MapEntry(key.toString(), value as Map<dynamic, dynamic>),
        );

        List<Product> itemsWeEatList = [];
        typedData.forEach((key, value) {
          if (value is Map<dynamic, dynamic>) {
            final itemMap = value.cast<String, dynamic>();
            try {
              final item = Product.fromMap(itemMap);
              itemsWeEatList.add(item);
            } catch (e) {
              print('Error creating Product: $e');
            }
          }
        });

        setState(() {
          allItems = itemsWeEatList;
          filteredItems =
              itemsWeEatList; // Set to show "Items We Eat" initially
          isLoading = false; // Data fetching complete
        });
      }
    } else {
      print('No data available');
      setState(() {
        isLoading = false; // Data fetching complete
      });
    }
  }

  void fetchItemsWeWear() async {
    final databaseReference = FirebaseDatabase.instance
        .ref("vendors")
        .child(widget.shopName)
        .child("Clothing");

    DataSnapshot dataSnapshot = await databaseReference.get();

    if (dataSnapshot.exists) {
      final data = dataSnapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        final Map<String, dynamic> typedData = data.map(
          (key, value) =>
              MapEntry(key.toString(), value as Map<dynamic, dynamic>),
        );

        List<Product> itemsWeWearList = [];
        typedData.forEach((key, value) {
          if (value is Map<dynamic, dynamic>) {
            final itemMap = value.cast<String, dynamic>();
            try {
              final item = Product.fromMap(itemMap);
              itemsWeWearList.add(item);
            } catch (e) {
              print('Error creating Product: $e');
            }
          }
        });

        setState(() {
          allItems = itemsWeWearList;
          filteredItems =
              itemsWeWearList; // Set to show "Items We Wear" initially
          isLoading = false; // Data fetching complete
        });
      }
    } else {
      print('No data available');
      setState(() {
        isLoading = false; // Data fetching complete
      });
    }
  }

  void filterItems() {
    setState(() {
      isLoading = true; // Set loading state to true when filtering
      if (selectedCategory == 'All') {
        fetchAndHandleItems(); // Fetch all items if "All" is selected
      } else if (selectedCategory == 'Items We Eat') {
        fetchItemsWeEat();
      } else if (selectedCategory == 'Items We Wear') {
        fetchItemsWeWear();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAndHandleItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        backgroundColor: Colors.green,
        title: const Text('Product Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CartScreen(
                          cartItems: cartItems,
                        )),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Chips for categories
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: mainCategories.map((category) {
                return FilterChip(
                  label: Text(category),
                  selected: selectedCategory == category,
                  onSelected: (selected) {
                    setState(() {
                      selectedCategory = category;
                      filterItems();
                    });
                  },
                  selectedColor: Colors.green,
                  backgroundColor: Colors.grey.shade300,
                  checkmarkColor: Colors.white,
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(
                    child:
                        CircularProgressIndicator()) // Show loading indicator while fetching
                : filteredItems.isEmpty
                    ? Center(child: Text('No items available'))
                    : GridView.builder(
                        padding: const EdgeInsets.all(8.0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemCount: filteredItems.length,
                        itemBuilder: (context, index) {
                          final item = filteredItems[index];
                          return _buildProductCard(
                            context,
                            productName: item.name,
                            productPrice: item.price,
                            productImage: item.imageUrl,
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(BuildContext context,
      {required String productName,
      required String productPrice,
      required String productImage}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
            child: Image.network(
              productImage,
              height: 60,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              productName,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
            child: Text(
              'Rs:' + productPrice,
              style: TextStyle(
                fontSize: 12,
                color: Colors.green,
              ),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () async {

                  CartItem cartItem = CartItem(
                    vendorName: widget.shopName,
                    itemName: productName,
                    itemPrice: productPrice,
                  );

                  await CartPreferences.addItemToCart(cartItem);

                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('$productName added to cart'),
                      ),);
                },

                  // onPressed: () {
                  //   setState(() {
                  //     cartItems.add(productName);
                  //   });
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(
                  //       content: Text('$productName added to cart'),
                  //     ),
                  //   );
                  // },
                  icon: Icon(Icons.add_shopping_cart)),

              SizedBox(width: 32,)
,
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PurchaseScreen(
                        productName: productName,
                        price: productPrice,
                      ),
                    ),
                  );
                },
                child: Text('Buy Now'),
              )
              // Add to Cart Button
              // Buy Now Button
            ],
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
