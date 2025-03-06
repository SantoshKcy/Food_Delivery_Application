import 'package:flutter/material.dart';
import 'package:food_delivery_application/features/home/presentation/view/bottom_view/dashboard_view.dart';

class OrderSuccessView extends StatelessWidget {
  const OrderSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Success Check Icon
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE0B2), // Light Orange Background
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: Color(0xFFFF7918), // Primary Orange
                  size: 80,
                ),
              ),
              const SizedBox(height: 30),

              // Success Message
              const Text(
                "Your order has been\nplaced.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),

              const Text(
                "Your items have been ordered and\nare now in the processing stage.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 30),

              // View Order Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to View Order Screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF7918), // Orange
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    "View Order",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // White Text
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Back to Home
              TextButton.icon(
                onPressed: () {
                  Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DashboardView()),
        );
                },
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                label: const Text(
                  "Back to Home",
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
