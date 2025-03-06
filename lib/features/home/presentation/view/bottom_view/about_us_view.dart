import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery_application/core/theme/theme_provider.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});

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
          "About Us",
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
            _buildSectionTitle("Welcome to Hunger End!", isDarkMode),
            _buildText(
                "Hunger End is your ultimate destination for fast, delicious, and convenient food delivery. We connect you with your favorite restaurants and ensure your meals arrive fresh and on time.",
                isDarkMode),
            const SizedBox(height: 20),

            _buildSectionTitle("Our Mission", isDarkMode),
            _buildText(
                "At Hunger End, our mission is simple: to deliver happiness with every meal. We strive to provide the best dining experience from the comfort of your home, ensuring top-quality service and customer satisfaction.",
                isDarkMode),
            const SizedBox(height: 20),

            _buildSectionTitle("What We Offer", isDarkMode),
            _buildServiceItem(Icons.fastfood, "Wide Varieties of Items", "Order from your favorite foods and enjoy your meals.", isDarkMode),
            _buildServiceItem(Icons.delivery_dining, "Fast & Reliable Delivery", "Enjoy on-time delivery with real-time tracking.", isDarkMode),
            _buildServiceItem(Icons.payment, "Multiple Payment Options", "Pay securely using Cash on Delivery, Digital Wallets, or Online Payments.", isDarkMode),
            _buildServiceItem(Icons.support, "24/7 Customer Support", "Need help? Our support team is always ready to assist you.", isDarkMode),
            const SizedBox(height: 20),

            _buildSectionTitle("Why Choose Hunger End?", isDarkMode),
            _buildWhyChooseItem("✔ Fresh and Quality Ingredients", isDarkMode),
            _buildWhyChooseItem("✔ Affordable Prices & Great Deals", isDarkMode),
            _buildWhyChooseItem("✔ Easy and User-Friendly App", isDarkMode),
            _buildWhyChooseItem("✔ Trusted by Thousands of Customers", isDarkMode),
            const SizedBox(height: 20),

            _buildSectionTitle("Get in Touch", isDarkMode),
            _buildText("Have questions or feedback? Feel free to contact us:", isDarkMode),
            _buildContactItem(Icons.phone, "Phone:", "+977 9840922949", isDarkMode),
            _buildContactItem(Icons.email, "Email:", "support@hungerend.com", isDarkMode),
            _buildContactItem(Icons.location_on, "Address:", "Kathmandu, Nepal", isDarkMode),
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
      style: TextStyle(fontSize: 16, height: 1.5, color: isDarkMode ? Colors.white70 : Colors.black87),
    );
  }

  Widget _buildServiceItem(IconData icon, String title, String description, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: isDarkMode ? Colors.orangeAccent : const Color(0xFFFF7918), size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(fontSize: 14, height: 1.4, color: isDarkMode ? Colors.white70 : Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhyChooseItem(String text, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: isDarkMode ? Colors.orangeAccent : const Color(0xFFFF7918), size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 16, color: isDarkMode ? Colors.white : Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String title, String value, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, color: isDarkMode ? Colors.orangeAccent : const Color(0xFFFF7918), size: 24),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16, color: isDarkMode ? Colors.white70 : Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
