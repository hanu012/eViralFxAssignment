import 'package:assignment/features/home/Home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'features/auth/login.dart';
import 'features/splash/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => SplashScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/HomeScreen', page: () => HomeScreen()),
      ],

    );
  }
}
