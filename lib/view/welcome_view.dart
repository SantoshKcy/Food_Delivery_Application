import 'package:flutter/material.dart';
import 'package:food_delivery_app/view/login_view.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding:
            const EdgeInsets.all(40.0), // Adjusted padding for better layout
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo/Image
            Image.asset(
              'assets/images/welcome.png',
              height: 180,
            ),
            const SizedBox(height: 30), // Reduced gap

            // Welcome Message
            const Text(
              "Welcome to Hunger End",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
                height: 10), // Small gap between title and description
            const Text(
              "It’s a pleasure to meet you. We are excited that you’re here so let’s get started!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 50), // Adjusted spacing before the button

            // Get Started Button
            ElevatedButton(
              onPressed: () {
                // Navigate to the Login Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginView()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: const Text(
                'Get Started',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
