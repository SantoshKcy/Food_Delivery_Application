import 'package:flutter/material.dart';
import 'package:food_delivery_app/core/app_theme/app_theme.dart';
// import 'package:food_delivery_app/view/dashboard_view.dart';
import 'package:food_delivery_app/view/loading_page_view.dart';
import 'package:food_delivery_app/view/login_view.dart';
import 'package:food_delivery_app/view/onboarding_screen.dart';
// import 'package:food_delivery_app/view/signup_view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      theme: getApplicationTheme(),
      routes: {
        '/': (context) => const LoadingPageView(),
        '/welcome': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginView(),
        // '/signup': (context) => const SignUpView(),
        // '/dashboard': (context) => const DashboardView(),
      },
    );
  }
}
