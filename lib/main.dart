// // // import 'package:firebase_core/firebase_core.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:gbfinds/screen/Vendor/VendorScreen.dart';
// // // import 'package:gbfinds/screen/login/login_screen.dart';
// // // import 'package:get/get.dart';
// // //
// // // import 'firebase_options.dart';
// // //
// // // Future<void> main() async {
// // //   WidgetsFlutterBinding.ensureInitialized();
// // //   await Firebase.initializeApp(
// // //     options: FirebaseOptions(
// // //       apiKey: "AIzaSyAP9waVSx_hPGKYfffhL-Bvy4azD8GeX8I",
// // //       appId: "1:130095153640:ios:de0b2b96b6d4df1131645d",
// // //       messagingSenderId: "130095153640",
// // //       projectId: "orderapp-52aed",
// // //     ),
// // //   );
// // //
// // //
// // //   // await Firebase.initializeApp(
// // //   //   options: DefaultFirebaseOptions.currentPlatform,
// // //   // );
// // //   runApp(MyApp()); // Start the Flutter app after Firebase initialization
// // // }
// // //
// // // class MyApp extends StatelessWidget {
// // //   const MyApp({super.key});
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return GetMaterialApp(
// // //       title: 'Flutter Demo',
// // //       theme: ThemeData(
// // //         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
// // //         useMaterial3: true,
// // //       ),
// // //       home: LoginScreen(),
// // //     );
// // //   }
// // // }
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'firebase_options.dart'; // Ensure this file is properly generated and included
// //
// // import 'package:gbfinds/screen/login/login_screen.dart';
// //
// // Future<void> main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Firebase.initializeApp(
// //     options: DefaultFirebaseOptions.currentPlatform,
// //   );
// //   runApp(MyApp()); // Start the Flutter app after Firebase initialization
// // }
// //
// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return GetMaterialApp(
// //       title: 'Flutter Demo',
// //       theme: ThemeData(
// //         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
// //         useMaterial3: true,
// //       ),
// //       home: LoginScreen(),
// //     );
// //   }
// // }
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'firebase_options.dart'; // Ensure this file is properly generated and included
//
// import 'package:gbfinds/screen/login/login_screen.dart';
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   // Check if Firebase is already initialized
//   try {
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//   } catch (e) {
//     // Handle the case where Firebase is already initialized
//     print("Firebase is already initialized.");
//   }
//
//   runApp(MyApp()); // Start the Flutter app after Firebase initialization
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: LoginScreen(),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart'; // Ensure this file is properly generated and included

import 'package:gbfinds/screen/login/login_screen.dart';
import 'package:gbfinds/screen/Vendor/VendorScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp()); // Start the Flutter app after Firebase initialization
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AuthenticationWrapper(),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return VendorScreen(); // Navigate to VendorScreen if the user is logged in
        } else {
          return LoginScreen(); // Navigate to LoginScreen if the user is not logged in
        }
      },
    );
  }
}
