import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:restaurant_booking/screens/home/home_screen.dart';
import 'package:restaurant_booking/screens/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'utils/preference.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if ((await Firebase.apps.length) == 0) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: 'AIzaSyACnkHx3gvDYiQhiBK8pHL77WhcHuZLjS4',
          appId: '1:801103195124:android:dbc8b116eeeb4e7839a7a1',
          messagingSenderId: '801103195124',
          projectId: 'restaurant-booking-62175',
          storageBucket: 'restaurant-booking-62175.appspot.com',
        )
    );
  } else {
    await Firebase.app(); // if already initialized, use that one
  }
  await Preference.init();
  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  Preference.isLogin?HomeScreen():LoginScreen(),
    );
  }
}





