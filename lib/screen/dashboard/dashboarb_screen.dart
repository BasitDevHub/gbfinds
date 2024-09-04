
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cart_screen/cart_screen.dart';
import '../models/CartItem.dart';
import '../models/Product.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, required this.shopName, required this.vendorId, required this.accountNo, required this.accountName});

  final String shopName;
  final String accountNo;
  final String accountName;
  final String vendorId;

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
    print('Dashboard: ${widget.shopName }  and ${widget.vendorId}');
    print('user account information: ${widget.accountName }  and ${widget.accountNo}');

    fetchVendorDetails();
  }

  @override
  Widget build(BuildContext context) {
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
          'Vendor Items',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
              size: 24,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen(shopName: widget.shopName, vendorId: widget.vendorId,  accountName: widget.accountName, accountNumber: widget.accountNo,)),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [

          SizedBox(height: 8,),

          const Text(
            textAlign: TextAlign.center,
            'If you want order Add item  to cart\n Place an order' ,style: TextStyle(fontWeight: FontWeight.w100 ,),)
,
          // Filter Chips for categories
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: mainCategories.map((category) {
                return FilterChip(
                  label: Text(
                    category,
                    style: TextStyle(color: Colors.white),
                  ),
                  selected: selectedCategory == category,
                  onSelected: (selected) {
                    setState(() {
                      selectedCategory = category;
                      filterItems();
                    });
                  },
                  selectedColor: Colors.blue,
                  backgroundColor: Colors.blueGrey,
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


  Future<void> _addToCart(String productName, String productPrice, String shopName ) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cartItems = prefs.getStringList('cart_items') ?? [];

    final cartItem = CartItem(
      name: productName,
      price: productPrice,
      vendorName: widget.shopName,
    ).toJson();

    cartItems.add(cartItem);
    try {
      await prefs.setStringList('cart_items', cartItems);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$productName added to cart'),
        ),
      );
    } catch (e) {
      print('Error adding to cart: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add $productName to cart'),
        ),
      );
    }
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

              SizedBox(width: 4,),
              Text('Add to cart'),
              IconButton(
                  onPressed: () async {

                    await _addToCart(productName ,productPrice, widget.shopName);

                  },
                  icon: Icon(Icons.add_shopping_cart)),

              SizedBox(
                width: 32,
              ),


              // GestureDetector(
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => PurchaseScreen(
              //
              //         ),
              //       ),
              //     );
              //   },
              //   child: Text('Order Now'),
              // )
              // Add to Cart Button
              // Buy Now Button
            ],
          ),
          const SizedBox(height: 5),
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
          print('data from dashboard: $ownerName');
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
