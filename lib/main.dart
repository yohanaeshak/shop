import 'package:flutter/material.dart';
import 'OrderConfirmationScreen.dart';
import 'checkout.dart';
import 'login_page.dart';
import 'signup_page.dart';
import 'welcome_page.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login', // Set the initial route as login
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/welcome': (context) => WelcomePage(),
        '/checkout': (context) => CheckoutScreen(), // Add CheckoutScreen route here
        '/order_confirmation': (context) => OrderConfirmationScreen(),

      },
    );
  }
}
