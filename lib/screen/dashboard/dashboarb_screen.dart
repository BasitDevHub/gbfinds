
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../cart_screen/cart_screen.dart';

class DashboarbScreen extends StatefulWidget {
  const DashboarbScreen({super.key});

  @override
  _DashboarbScreenState createState() => _DashboarbScreenState();
}

class _DashboarbScreenState extends State<DashboarbScreen> {

  // Main categories
  final List<String> mainCategories = ['All', 'Items We Eat', 'Items We Wear'];

  // List of product data with categories
  final List<Map<String, String>> products = [
    {'name': 'Apple', 'image': 'assets/image.jpg', 'category': 'Items We Eat'},
    {'name': 'T-Shirt', 'image': 'assets/image.jpg', 'category': 'Items We Wear'},
    {'name': 'Cap', 'image': 'assets/image.jpg', 'category': 'Items We Wear'},
    {'name': 'Nature Poster', 'image': 'assets/image.jpg', 'category': 'Items We Eat'},
    {'name': 'Snacks', 'image': 'assets/image.jpg', 'category': 'Items We Eat'},
  ];

  // Selected main category
  String selectedCategory = 'All';

  // Cart items
  final List<String> cartItems = [];

  @override
  Widget build(BuildContext context) {
    // Filter products based on selected category
    final filteredProducts = selectedCategory == 'All'
        ? products
        : products.where((product) => product['category'] == selectedCategory).toList();

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
              // Navigate to cart screen or show cart dialog
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen(cartItems: cartItems,)),
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
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 16.0, // Horizontal spacing
                mainAxisSpacing: 16.0, // Vertical spacing
                childAspectRatio: 0.75, // Aspect ratio of the card
              ),
              itemCount: filteredProducts.length, // Number of items
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return _buildProductCard(
                  context,
                  productName: product['name']!,
                  productPrice: '\$${(index + 1) * 10}.00',
                  productImage: product['image']!,
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
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            child: Image.asset(
              productImage,
              height: 100,
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
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
            child: Text(
              productPrice,
              style: TextStyle(
                fontSize: 12,
                color: Colors.green,
              ),
            ),
          ),
          Spacer(),
          Container(

            alignment: Alignment.center,
            height: 25,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  cartItems.add(productName);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$productName added to cart'),
                  ),
                );
              },
              child: const Text('Add to Cart'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.green,
              ),
            ),
          ),

          SizedBox(height: 10,)
        ],
      ),
    );
  }
}
