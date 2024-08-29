import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class OrderProgressScreen extends StatelessWidget {

  OrderProgressScreen();


  @override
  Widget build(BuildContext context) {
    // Reference to the orders node in Firebase Realtime Database
    final DatabaseReference orderRef =
    FirebaseDatabase.instance.ref().child('Orders').child('243242342342342');

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        backgroundColor: Colors.blue,
        title: const Text('Vendors',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.clear_sharp),
              onPressed: () {
                Navigator.pop(context); // Correctly using the context here
              },
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: orderRef.onValue,
        builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading order details'));
          }
          if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
            return const Center(child: Text('No order details found'));
          }

          Map<dynamic, dynamic> orderData =
          snapshot.data!.snapshot.value as Map<dynamic, dynamic>;

          // Extract order details
          String status = orderData['status'] ?? 'Unknown';
          String estimatedDelivery = orderData['estimatedDelivery'] ?? 'N/A';

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order ID:',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Current Status: $status',
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Estimated Delivery: $estimatedDelivery',
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Implement functionality if needed
                  },
                  child: const Text('Contact Support'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
