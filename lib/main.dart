import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/screens/Login_Screen.dart';
import 'package:food_delivery_app/screens/admin_screen.dart';
import 'package:food_delivery_app/screens/auth_wrapper_screen.dart';
import 'package:food_delivery_app/screens/home_screen.dart';
import 'package:food_delivery_app/screens/sign_in_screen.dart';
import 'package:food_delivery_app/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const FoodDeliveryApp());
}

class FoodDeliveryApp extends StatelessWidget {
  const FoodDeliveryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  debugShowCheckedModeBanner: false,
  home: AuthWrapper(),
  initialRoute: '/splash',
  routes: {
    '/splash': (context) => SplashScreen(),
    '/login': (context) => LoginScreen(),
    '/home': (context) => HomeScreen(categories: [] ),
    '/adminHome': (context) => AdminScreen(),
    '/signIn' :  (context) => SignInScreen(),
     // صفحة الإدارة اللي هتصممها
  },
);

  }
}



