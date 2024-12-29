import 'package:flutter/material.dart';
import 'OrderConfirmationScreen.dart';
import 'checkout.dart';
import 'listViewHomePage.dart';
import 'login_page.dart';
import 'signup_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/order_confirmation', // افتح OrderConfirmationScreen عند التشغيل
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/welcome': (context) => WelcomePage(),
        '/checkout': (context) => CheckoutScreen(),
        '/order_confirmation': (context) => OrderConfirmationScreen(), // أضف المسار لشاشة OrderConfirmationScreen
      },
    );
  }
}
