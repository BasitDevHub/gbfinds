
import 'dart:io'; // Import the dart:io library for File
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gbfinds/screen/Vendor/VendorScreen.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../cart_screen/cart_screen.dart';
import '../models/CartItem.dart';

class PurchaseScreen extends StatefulWidget {
  final List<CartItem> cartItems;
  final String shopName;
  final String vendorId;
  final String accountName;
  final String accountNumber;
  PurchaseScreen({super.key, required this.cartItems, required this.shopName, required this.vendorId, required this.accountName, required this.accountNumber});

  @override
  _PurchaseScreenState createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  XFile? _imageFile;

  final ImagePicker _picker = ImagePicker();
  String _vendorName = '';
  String _accountNumber = '';
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref('users');

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = pickedFile;
    });
  }

  double _calculateTotalPrice() {
    return widget.cartItems.fold(0.0, (total, item) {
      final price = double.tryParse(item.price) ?? 0.0;
      return total + price;
    });
  }

  void _placeOrder() {
    // Add logic for placing an order
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Order Placed'),
        content: const Text('Your order has been placed successfully.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = _calculateTotalPrice();

    String ownerEasy;
    Stream accountno;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){

          Navigator.pop(context);

        }, icon: const Icon(Icons.arrow_back ,color: Colors.white ,size: 24,),),
        centerTitle: true,
        title: const Text('Purchase Summary' ,style: TextStyle(color: Colors.white  ,fontWeight: FontWeight.bold),),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Vendor Account Information Section
            const Text(
              'Vendor Account Information',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 10),
             Card(
              elevation: 4,
              child: ListTile(
                title: Text('Vendor Account: ${widget.accountName}'),
                subtitle: Text('Account Number: ${widget.accountNumber}'),
                contentPadding: EdgeInsets.all(16.0),
              ),
            ),
            const SizedBox(height: 20),

            // Receipt Section
            const Text(
              'Receipt',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: widget.cartItems.length,
                itemBuilder: (context, index) {
                  final item = widget.cartItems[index];
                  return ListTile(
                    title: Text(item.name),
                    subtitle: Text('Rs: ${item.price}'),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),

            // Total Price Section
            Text(
              'Total Price: Rs. ${totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 20),

            // Upload Payment Screenshot Section
            const Text(
              'Upload Payment Screenshot',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 10),
            _imageFile == null
                ? GestureDetector(
              onTap: _pickImage,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.grey),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.add_a_photo, color: Colors.blueGrey, size: 40),
                    SizedBox(height: 10),
                    Text(
                      'Tap to upload screenshot',
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                  ],
                ),
              ),
            )
                : Column(
              children: [
                Image.file(
                  File(_imageFile!.path),
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text('Change Screenshot'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Place Order Button
            Center(
              child: ElevatedButton(
                onPressed: (){
                  _placeOrder();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VendorScreen()),
                  );                },
                child: const Text('Place Order'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text color
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
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
          setState(() {
            _vendorName = data['ownerAccountName'] ?? '';
            _accountNumber = data['ownerAccountNo'] ?? '';
          });
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

  @override
  void initState() {
    super.initState();
    fetchVendorDetails();
  }

}
