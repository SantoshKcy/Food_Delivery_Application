import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery_application/core/theme/theme_provider.dart';

class RefundPolicyView extends StatelessWidget {
  const RefundPolicyView({super.key});

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
          "Refund Policy",
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
                "Our refund policy ensures fairness and transparency for our customers. Please read the details carefully.",
                isDarkMode),
            const SizedBox(height: 20),

            _buildSectionTitle("Eligibility for Refunds", isDarkMode),
            _buildBulletPoint("✔ Orders canceled before preparation are eligible for a full refund.", isDarkMode),
            _buildBulletPoint("✔ If the restaurant fails to deliver due to unforeseen circumstances, a refund will be issued.", isDarkMode),
            _buildBulletPoint("✔ Issues related to incorrect or missing items may qualify for partial or full refunds.", isDarkMode),
            const SizedBox(height: 20),

            _buildSectionTitle("Non-Refundable Situations", isDarkMode),
            _buildBulletPoint("✔ Refunds will not be issued for orders where incorrect address details were provided.", isDarkMode),
            _buildBulletPoint("✔ If the order is delivered as per request, no refund claims will be entertained.", isDarkMode),
            _buildBulletPoint("✔ Delays due to traffic or weather conditions do not qualify for a refund.", isDarkMode),
            const SizedBox(height: 20),

            _buildSectionTitle("Refund Processing Time", isDarkMode),
            _buildText(
                "Refunds may take up to 7 business days to process, depending on the payment method used.",
                isDarkMode),
            const SizedBox(height: 20),

            _buildSectionTitle("How to Request a Refund", isDarkMode),
            _buildText(
                "To request a refund, please contact our support team with your order details and reason for refund.",
                isDarkMode),
            const SizedBox(height: 20),

            _buildSectionTitle("Contact Support", isDarkMode),
            _buildContactItem(Icons.phone, "Phone:", "+977 9840922949", isDarkMode),
            _buildContactItem(Icons.email, "Email:", "support@hungerend.com", isDarkMode),
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
