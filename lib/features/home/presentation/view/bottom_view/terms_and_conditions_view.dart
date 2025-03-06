import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery_application/core/theme/theme_provider.dart';

class TermsAndConditionsView extends StatelessWidget {
  const TermsAndConditionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.grey[900] : const Color(0xFFFF7918),
        elevation: 0,
        title: Text(
          "Terms & Conditions",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Introduction", isDarkMode),
            _buildText(
                "By using our app, you agree to the following terms and conditions. Please read them carefully before using Hunger End services.",
                isDarkMode),
            const SizedBox(height: 20),

            _buildSectionTitle("User Agreement", isDarkMode),
            _buildText(
                "Users must be at least 18 years old or have parental consent to use the app. You agree to provide accurate and up-to-date information when signing up.",
                isDarkMode),
            const SizedBox(height: 20),

            _buildSectionTitle("Ordering & Payment", isDarkMode),
            _buildBulletPoint("✔ Orders placed through Hunger End are subject to restaurant availability.", isDarkMode),
            _buildBulletPoint("✔ Payment must be completed before delivery, unless Cash on Delivery is selected.", isDarkMode),
            _buildBulletPoint("✔ Prices may vary based on restaurant policies.", isDarkMode),
            const SizedBox(height: 20),

            _buildSectionTitle("Cancellations & Refunds", isDarkMode),
            _buildText(
                "Once an order is placed, cancellations may not always be possible. Refunds are subject to our refund policy, and in case of any issues, please contact customer support.",
                isDarkMode),
            const SizedBox(height: 20),

            _buildSectionTitle("Privacy Policy", isDarkMode),
            _buildText(
                "Your personal data is protected and will not be shared with third parties without consent. Please review our privacy policy for detailed information.",
                isDarkMode),
            const SizedBox(height: 20),

            _buildSectionTitle("User Responsibilities", isDarkMode),
            _buildBulletPoint("✔ Users must not engage in fraudulent activities on the platform.", isDarkMode),
            _buildBulletPoint("✔ Respect restaurant and delivery personnel.", isDarkMode),
            _buildBulletPoint("✔ Do not misuse promo codes or discounts.", isDarkMode),
            const SizedBox(height: 20),

            _buildSectionTitle("Changes to Terms", isDarkMode),
            _buildText(
                "We reserve the right to update these terms at any time. Continued use of the app implies agreement with any modifications.",
                isDarkMode),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isDarkMode) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: isDarkMode ? Colors.white : Colors.black,
      ),
    );
  }

  Widget _buildText(String text, bool isDarkMode) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 16, height: 1.5, color: isDarkMode ? Colors.white70 : Colors.black87),
    );
  }

  Widget _buildBulletPoint(String text, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.circle, size: 8, color: isDarkMode ? Colors.orangeAccent : const Color(0xFFFF7918)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 16, color: isDarkMode ? Colors.white70 : Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
