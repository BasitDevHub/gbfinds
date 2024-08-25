import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:gbfinds/screen/dashboard/dashboarb_screen.dart';

class VendorScreen extends StatelessWidget {
  const VendorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Reference to the vendors node in Firebase Realtime Database
    final DatabaseReference vendorRef =
        FirebaseDatabase.instance.ref().child('UserDetail');

    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        backgroundColor: Colors.green,
        title: const Text('Vendors'),
        centerTitle: true,

      ),

      body: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          // Slider widget
          Container(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 130,
              child: PageView(
                children: [
                  Container(


                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.red,

                    ),
                      child: const Center(
                          child: Text('Slide 1',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 24)))),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.red,

                    ),
                      child: const Center(
                          child: Text('Slide 1',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 24)))),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.red,

                    ),
                      child: const Center(
                          child: Text('Slide 1',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 24)))),

                ],
              ),
            ),
          ),

          const Text(
            'Order from the best and enjoy top-quality service! ',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),

          const Divider(
            height: 2,
            color: Colors.black,
          ),
          // ListView of vendors
          Expanded(
            child: StreamBuilder(
              stream: vendorRef.onValue,
              builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Error loading vendors'));
                }
                if (!snapshot.hasData ||
                    snapshot.data!.snapshot.value == null) {
                  return const Center(child: Text('No vendors found'));
                }

                Map<dynamic, dynamic> vendorsMap =
                    snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
                List<Map<String, dynamic>> vendors =
                    vendorsMap.values.map((vendor) {
                  return {
                    'name': vendor['ownerName'] ?? 'No Name',
                    'location': vendor['shopAddress'] ?? 'No Address',
                    'shopName': vendor['ownerShopName'] ?? 'No Shop Name',
                  };
                }).toList();

                return ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: vendors.length,
                  itemBuilder: (context, index) {
                    final vendor = vendors[index];
                    return VendorCard(
                      name: vendor['name']!,
                      location: vendor['location']!,
                      shopName: vendor['shopName']!,
                      onPress: () {
                        Get.to(() => DashboardScreen(shopName: vendor['shopName'],));
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class VendorCard extends StatelessWidget {
  final String name;
  final String location;
  final VoidCallback onPress;
  final String? shopName;

  const VendorCard({
    required this.name,
    required this.location,
    required this.onPress,
    required this.shopName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(8.0),
            title: Text(
              shopName!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(name ,textAlign: TextAlign.left,),
                Text(location),
              ],
            ),
          ),
          // Add the button below the vendor details
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: onPress,
                  child: const Text('Browse to Order'),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.location_disabled_outlined, // Replace with your icon
                  size: 30,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
