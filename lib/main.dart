import 'package:flutter/material.dart';
import 'package:food_delivery_app/view/dashboard_view.dart';
import 'package:food_delivery_app/view/loading_page_view.dart';
import 'package:food_delivery_app/view/login_view.dart';
import 'package:food_delivery_app/view/signup_view.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoadingPageView(),
        '/login': (context) => const LoginView(),
        '/signup': (context) => const SignUpView(),
        '/home': (context) => const DashboardView(),
      },
    ),
  );
}
