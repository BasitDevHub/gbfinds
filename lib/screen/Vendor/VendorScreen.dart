//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:get/get.dart';
//
// import '../dashboard/dashboarb_screen.dart';
// import '../login/login_screen.dart';
// import '../map_screen/MyHomePage.dart';
// import '../order_detail/OrderProgressScreen.dart';
//
// class VendorScreen extends StatelessWidget {
//   const VendorScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final DatabaseReference vendorRef =
//     FirebaseDatabase.instance.ref().child('VendorsDetail');
//
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(16),
//             bottomRight: Radius.circular(16),
//           ),
//         ),
//         backgroundColor: Colors.blue,
//         title: const Text('Vendors',
//             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//         centerTitle: true,
//         actions: [
//           Builder(
//             builder: (context) => IconButton(
//               icon: const Icon(Icons.menu),
//               onPressed: () {
//                 Scaffold.of(context).openDrawer();
//               },
//             ),
//           ),
//         ],
//       ),
//       drawer: _buildDrawer(context),
//       body: Column(
//         children: [
//           const SizedBox(height: 12),
//           _buildSlider(),
//           const Text(
//             'Order from the best and enjoy top-quality service!',
//             style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
//             textAlign: TextAlign.center,
//           ),
//           const Divider(height: 2, color: Colors.black),
//           Expanded(
//             child: StreamBuilder(
//               stream: vendorRef.onValue,
//               builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 if (snapshot.hasError) {
//                   return const Center(child: Text('Error loading vendors'));
//                 }
//                 if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
//                   return const Center(child: Text('No vendors found'));
//                 }
//
//                 final vendorsMap = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
//                 final vendors = vendorsMap.entries.map((entry) {
//                   final vendor = entry.value as Map<dynamic, dynamic>;
//                   return {
//                     'name': vendor['ownerName'] ?? 'No Name',
//                     'location': vendor['shopAddress'] ?? 'No Address',
//                     'shopName': vendor['ownerShopName'] ?? 'No Shop Name',
//                     'accountName': vendor['ownerAccountName'] ?? 'No account Name',
//                     'accountNo': vendor['ownerAccountNo'] ?? 'No account no Name',
//                     'vendorId': vendor['vendorId'] ?? 'no ',
//                     'rating': vendor['rating']?.toDouble() ?? 0.0,
//                   };
//                 }).toList();
//
//                 print('dats is${vendors}');
//                 return ListView.builder(
//                   padding: const EdgeInsets.all(8.0),
//                   itemCount: vendors.length,
//                   itemBuilder: (context, index) {
//                     final vendor = vendors[index];
//                     return VendorCard(
//                       name: vendor['name']!,
//                       location: vendor['location']!,
//                       shopName: vendor['shopName']!,
//                       rating: vendor['rating'],
//                       vendorId: vendor['vendorId']!,
//                       accoutName: vendor['ownerAccountName'],
//                       accountNumber:  vendor['ownerAccountNo'],
//                       onPress: () {
//                         Get.to(() => DashboardScreen(
//                           shopName: vendor['shopName']!,
//                           vendorId: vendor['vendorId']!,
//                           accountNo: vendor['ownerAccountNo'],
//                           accountName: vendor['ownerAccountName'], // Fixed here
//                         ));},
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSlider() {
//     return Container(
//       padding: const EdgeInsets.all(8.0),
//       child: SizedBox(
//         height: 130,
//         child: PageView(
//           children: [
//             _buildSlide('Slide 1'),
//             _buildSlide('Slide 2'),
//             _buildSlide('Slide 3'),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSlide(String text) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16),
//         color: Colors.red,
//       ),
//       child: Center(
//         child: Text(
//           text,
//           style: const TextStyle(color: Colors.white, fontSize: 24),
//         ),
//       ),
//     );
//   }
//
//   Drawer _buildDrawer(BuildContext context) {
//     return Drawer(
//       child: Column(
//         children: [
//           const UserAccountsDrawerHeader(
//             accountName: Text('John Doe'),
//             accountEmail: Text('john.doe@example.com'),
//             currentAccountPicture: CircleAvatar(
//               backgroundColor: Colors.white,
//               child: Icon(Icons.person, color: Colors.blue),
//             ),
//             decoration: BoxDecoration(color: Colors.blue),
//           ),
//           ListTile(
//             leading: const Icon(Icons.home),
//             title: const Text('Home'),
//             onTap: () {
//               Navigator.pop(context);
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.search),
//             title: const Text('My Orders'),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => OrderProgressScreen()),
//               );
//             },
//           ),
//           const Spacer(),
//           ListTile(
//             leading: const Icon(Icons.logout),
//             title: const Text('Logout'),
//             onTap: () async {
//               try {
//                 await FirebaseAuth.instance.signOut();
//                 Get.offAll(() => LoginScreen()); // Navigate to the login screen after logout
//               } catch (e) {
//                 // Handle logout error if necessary
//                 print("Error during logout: $e");
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
// class VendorCard extends StatelessWidget {
//   final String name;
//   final String location;
//   final VoidCallback onPress;
//   final String shopName;
//   final double rating;
//   final String vendorId; // Add this line
//   final String accoutName; // Add this line
//   final String accountNumber; // Add this line
//
//   const VendorCard({
//     required this.name,
//     required this.location,
//     required this.onPress,
//     required this.shopName,
//     required this.rating,
//     required this.vendorId,
//     required this.accoutName,
//     required this.accountNumber,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 5,
//       margin: const EdgeInsets.only(bottom: 8.0),
//       child: Column(
//         children: [
//           ListTile(
//             contentPadding: const EdgeInsets.all(8.0),
//             title: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   shopName,
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.location_disabled_outlined, color: Colors.blue, size: 30),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => MyHomePage()),
//                     );
//                   },
//                 ),
//               ],
//             ),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(name),
//                 Text(location),
//                 Center(
//                   child: RatingBar.builder(
//                     initialRating: rating,
//                     minRating: 1,
//                     direction: Axis.horizontal,
//                     allowHalfRating: true,
//                     itemCount: 5,
//                     itemSize: 20.0,
//                     itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
//                     ignoreGestures: true,
//                     onRatingUpdate: (_) {},
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: ElevatedButton(
//                   onPressed: onPress,
//                   child: const Text('Browse to Order'),
//                 ),
//               ),
//               IconButton(
//                 icon: const Icon(Icons.star_rate),
//                 color: Colors.amber,
//                 onPressed: () => _showRatingDialog(context, shopName),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // class VendorCard extends StatelessWidget {
// //   final String name;
// //   final String location;
// //   final VoidCallback onPress;
// //   final String shopName;
// //   final double rating;
// //
// //   const VendorCard({
// //     required this.name,
// //     required this.location,
// //     required this.onPress,
// //     required this.shopName,
// //     required this.rating,
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Card(
// //       elevation: 5,
// //       margin: const EdgeInsets.only(bottom: 8.0),
// //       child: Column(
// //         children: [
// //           ListTile(
// //             contentPadding: const EdgeInsets.all(8.0),
// //             title: Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 Text(
// //                   shopName,
// //                   style: const TextStyle(fontWeight: FontWeight.bold),
// //                 ),
// //                 IconButton(
// //                   icon: const Icon(Icons.location_disabled_outlined, color: Colors.blue, size: 30),
// //                   onPressed: () {
// //                     Navigator.push(
// //                       context,
// //                       MaterialPageRoute(builder: (context) => MyHomePage()),
// //                     );
// //                   },
// //                 ),
// //               ],
// //             ),
// //             subtitle: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(name),
// //                 Text(location),
// //                 Center(
// //                   child: RatingBar.builder(
// //                     initialRating: rating,
// //                     minRating: 1,
// //                     direction: Axis.horizontal,
// //                     allowHalfRating: true,
// //                     itemCount: 5,
// //                     itemSize: 20.0,
// //                     itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
// //                     ignoreGestures: true,
// //                     onRatingUpdate: (_) {},
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               Padding(
// //                 padding: const EdgeInsets.all(8.0),
// //                 child: ElevatedButton(
// //                   onPressed: onPress,
// //                   child: const Text('Browse to Order'),
// //                 ),
// //               ),
// //               IconButton(
// //                 icon: const Icon(Icons.star_rate),
// //                 color: Colors.amber,
// //                 onPressed: () => _showRatingDialog(context, shopName),
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// // class VendorCard extends StatelessWidget {
// //   final String name;
// //   final String location;
// //   final VoidCallback onPress;
// //   final String shopName;
// //   final double rating;
// //   final String vendorId; // Add this line
// //   final String accoutName; // Add this line
// //   final String accountNumber; // Add this line
// //
// //   const VendorCard({
// //     required this.name,
// //     required this.location,
// //     required this.onPress,
// //     required this.shopName,
// //     required this.rating,
// //     required this.vendorId, required this.accoutName, required this.accountNumber, // Add this line
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Card(
// //       elevation: 5,
// //       margin: const EdgeInsets.only(bottom: 8.0),
// //       child: Column(
// //         children: [
// //           ListTile(
// //             contentPadding: const EdgeInsets.all(8.0),
// //             title: Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 Text(
// //                   shopName,
// //                   style: const TextStyle(fontWeight: FontWeight.bold),
// //                 ),
// //                 IconButton(
// //                   icon: const Icon(Icons.location_disabled_outlined, color: Colors.blue, size: 30),
// //                   onPressed: () {
// //                     Navigator.push(
// //                       context,
// //                       MaterialPageRoute(builder: (context) => MyHomePage()),
// //                     );
// //                   },
// //                 ),
// //               ],
// //             ),
// //             subtitle: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(name),
// //                 Text(location),
// //                 Center(
// //                   child: RatingBar.builder(
// //                     initialRating: rating,
// //                     minRating: 1,
// //                     direction: Axis.horizontal,
// //                     allowHalfRating: true,
// //                     itemCount: 5,
// //                     itemSize: 20.0,
// //                     itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
// //                     ignoreGestures: true,
// //                     onRatingUpdate: (_) {},
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               Padding(
// //                 padding: const EdgeInsets.all(8.0),
// //                 child: ElevatedButton(
// //                   onPressed: onPress,
// //                   child: const Text('Browse to Order'),
// //                 ),
// //               ),
// //               IconButton(
// //                 icon: const Icon(Icons.star_rate),
// //                 color: Colors.amber,
// //                 onPressed: () => _showRatingDialog(context, shopName ),
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
//
// void _showRatingDialog(BuildContext context, String shopName) {
//   double userRating = 5.0;
//
//   showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: const Text('Rate Vendor'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             RatingBar.builder(
//               initialRating: userRating,
//               minRating: 1,
//               direction: Axis.horizontal,
//               allowHalfRating: true,
//               itemCount: 5,
//               itemSize: 40.0,
//               itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
//               onRatingUpdate: (rating) => userRating = rating,
//             ),
//             const SizedBox(height: 16),
//             Text('Your rating: $userRating'),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () async {
//               await _updateVendorRating(shopName, userRating);
//               Navigator.of(context).pop();
//             },
//             child: const Text('Submit'),
//           ),
//         ],
//       );
//     },
//   );
// }
//
// Future<void> _updateVendorRating(String shopName, double rating) async {
//   final DatabaseReference vendorRef =
//   FirebaseDatabase.instance.ref().child('VendorsDetail');
//
//   final snapshot = await vendorRef.once();
//   final vendorsMap = snapshot.snapshot.value as Map<dynamic, dynamic>?;
//
//   if (vendorsMap != null) {
//     final vendorKey = vendorsMap.keys.firstWhere(
//           (key) => vendorsMap[key]['ownerShopName'] == shopName,
//       orElse: () => '',
//     );
//
//     if (vendorKey.isNotEmpty) {
//       await vendorRef.child(vendorKey).update({'rating': rating});
//     }
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../dashboard/dashboarb_screen.dart';
import '../login/login_screen.dart';
import '../map_screen/MyHomePage.dart';
import '../order_detail/OrderProgressScreen.dart';

class VendorScreen extends StatelessWidget {
  const VendorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DatabaseReference vendorRef =
    FirebaseDatabase.instance.ref().child('VendorsDetail');

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
        title: const Text(
          'Vendors',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: Column(
        children: [
          const SizedBox(height: 12),
          _buildSlider(),
          const Text(
            'Order from the best and enjoy top-quality service!',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          const Divider(height: 2, color: Colors.black),
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
                if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
                  return const Center(child: Text('No vendors found'));
                }

                final vendorsMap =
                snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
                final vendors = vendorsMap.entries.map((entry) {
                  final vendor = entry.value as Map<dynamic, dynamic>;
                  return {
                    'name': vendor['ownerName'] ?? 'No Name',
                    'location': vendor['shopAddress'] ?? 'No Address',
                    'shopName': vendor['ownerShopName'] ?? 'No Shop Name',
                    'vendorId': vendor['vendorId'] ?? 'no',
                    'rating': vendor['rating']?.toDouble() ?? 0.0,
                    'ownerAccountName': vendor['ownerAccountName'] ?? 'No Account Name',
                    'ownerAccountNo': vendor['ownerAccountNo'] ?? 'No Account Number',
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
                      rating: vendor['rating'],
                      vendorId: vendor['vendorId']!,
                      accoutName: vendor['ownerAccountName']!,
                      accountNumber: vendor['ownerAccountNo']!,
                      onPress: () {
                        Get.to(() => DashboardScreen(
                          shopName: vendor['shopName']!,
                          vendorId: vendor['vendorId']!,
                          accountNo: vendor['ownerAccountNo']!,
                          accountName: vendor['ownerAccountName']!,
                        ));
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

  Widget _buildSlider() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 130,
        child: PageView(
          children: [
            _buildSlide('Slide 1'),
            _buildSlide('Slide 2'),
            _buildSlide('Slide 3'),
          ],
        ),
      ),
    );
  }

  Widget _buildSlide(String text) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.red,
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text('John Doe'),
            accountEmail: Text('john.doe@example.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.blue),
            ),
            decoration: BoxDecoration(color: Colors.blue),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text('My Orders'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrderProgressScreen()),
              );
            },
          ),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              try {
                await FirebaseAuth.instance.signOut();
                Get.offAll(() => LoginScreen()); // Navigate to the login screen after logout
              } catch (e) {
                // Handle logout error if necessary
                print("Error during logout: $e");
              }
            },
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
  final String shopName;
  final double rating;
  final String vendorId;
  final String accoutName;
  final String accountNumber;

  const VendorCard({
    required this.name,
    required this.location,
    required this.onPress,
    required this.shopName,
    required this.rating,
    required this.vendorId,
    required this.accoutName,
    required this.accountNumber,
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
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  shopName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.location_disabled_outlined, color: Colors.blue, size: 30),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                  },
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name),
                Text(location),
                Center(
                  child: RatingBar.builder(
                    initialRating: rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 20.0,
                    itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
                    ignoreGestures: true,
                    onRatingUpdate: (_) {},
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: onPress,
                  child: const Text('Browse to Order'),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.star_rate),
                color: Colors.amber,
                onPressed: () => _showRatingDialog(context, shopName),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void _showRatingDialog(BuildContext context, String shopName) {
  double userRating = 5.0;

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Rate Vendor'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RatingBar.builder(
              initialRating: userRating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 40.0,
              itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
              onRatingUpdate: (rating) => userRating = rating,
            ),
            const SizedBox(height: 16),
            Text('Your rating: $userRating'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await _updateVendorRating(shopName, userRating);
              Navigator.of(context).pop();
            },
            child: const Text('Submit'),
          ),
        ],
      );
    },
  );
}

Future<void> _updateVendorRating(String shopName, double rating) async {
  final DatabaseReference vendorRef =
  FirebaseDatabase.instance.ref().child('VendorsDetail');

  try {
    // Update rating in Firebase Realtime Database
    await vendorRef.update({
      'rating': rating,
    });
  } catch (e) {
    print('Error updating vendor rating: $e');
  }
}
