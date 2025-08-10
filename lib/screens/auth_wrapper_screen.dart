import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/screens/Login_Screen.dart';
import 'package:food_delivery_app/screens/admin_screen.dart';
import 'package:food_delivery_app/screens/home_screen.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // لو في حالة تحميل
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: const Center(child: CircularProgressIndicator()));
        }
        // لو المستخدم مسجل دخول
        else if (snapshot.hasData) {
          final user = snapshot.data;
          final email = user!.email;
          if(email == 'omar.badawi.rm2020@gmail.com'){
            return AdminScreen();
          } else{
            return HomeScreen(categories: []);
          }
        } else{
          return LoginScreen();
        }
      },
    );
  }
}
