import 'package:flutter/material.dart';
import 'package:food_delivery_application/core/theme/theme_provider.dart';
import 'package:food_delivery_application/features/home/presentation/view/bottom_view/about_us_view.dart';
import 'package:food_delivery_application/features/home/presentation/view/bottom_view/edit_profile_view.dart';
import 'package:food_delivery_application/features/home/presentation/view/bottom_view/order_view.dart';
import 'package:food_delivery_application/features/home/presentation/view/bottom_view/refund_policy_view.dart';
import 'package:food_delivery_application/features/home/presentation/view/bottom_view/terms_and_conditions_view.dart';
import 'package:food_delivery_application/features/home/presentation/view/bottom_view/wishlist_view.dart';
import 'package:provider/provider.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      backgroundColor:
          isDarkMode ? Colors.black : Colors.grey[100], // Dark Mode Support
      appBar: AppBar(
        backgroundColor:
            isDarkMode ? Colors.grey[900] : const Color(0xFFFF7918),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: isDarkMode ? Colors.white : Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "My Profile",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Profile Section
            _buildProfileSection(isDarkMode), // Pass Dark Mode state

            const SizedBox(height: 20),

            // General Section (Includes Dark Mode Toggle)
            _buildSection(
                "General",
                [
                  _buildListTile(Icons.person, "Edit Profile", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfileView()),
                    );
                  }, isDarkMode),
                  _buildListTile(
                      Icons.history, "Order History", () {
                        Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderView()),
                    );
                      }, isDarkMode),
                  _buildListTile(
                      Icons.favorite, "My Favourites", () {
                        Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WishlistView()),
                    );
                      }, isDarkMode),
                  _buildDarkModeToggle(context, isDarkMode),
                ],
                isDarkMode),

            const SizedBox(height: 20),

            // Help & Support Section
            _buildSection(
                "Help & Support",
                [
                  _buildListTile(Icons.info, "About Us", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AboutUsView()),
                    );
                  }, isDarkMode),
                  _buildListTile(Icons.description, "Terms & Conditions", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TermsAndConditionsView()),
                    );
                  }, isDarkMode),
                  _buildListTile(Icons.refresh, "Refund Policy", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RefundPolicyView()),
                    );
                  }, isDarkMode),
                ],
                isDarkMode),

            const SizedBox(height: 30),

            // Sign Out Button
            _buildSignOutButton(),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // 🔹 Profile Section with Dark Mode Text Color
  Widget _buildProfileSection(bool isDarkMode) {
    return Column(
      children: [
        CircleAvatar(
          radius: 45,
          backgroundColor: Colors.grey[300],
          child: const Icon(Icons.person, size: 50, color: Colors.black54),
        ),
        const SizedBox(height: 10),
        Text(
          "Santosh KC",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black),
        ),
        Text(
          "kcsantosh2003@gmail.com",
          style: TextStyle(
              fontSize: 14, color: isDarkMode ? Colors.white : Colors.black54),
        ),
      ],
    );
  }

  // 🔹 General & Help & Support Sections
  Widget _buildSection(String title, List<Widget> children, bool isDarkMode) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          if (!isDarkMode)
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 5,
              spreadRadius: 2,
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
          Column(children: children),
        ],
      ),
    );
  }

  // 🔹 ListTile for Menu Items (Updated with White Text in Dark Mode)
  Widget _buildListTile(
      IconData icon, String title, VoidCallback onTap, bool isDarkMode) {
    return ListTile(
      leading: Icon(icon, color: isDarkMode ? Colors.white : Colors.black),
      title: Text(
        title,
        style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
      ),
      trailing: Icon(Icons.arrow_forward_ios,
          size: 18, color: isDarkMode ? Colors.white : Colors.black),
      onTap: onTap,
    );
  }

  // 🔹 Dark Mode Toggle (Text color updates based on mode)
  Widget _buildDarkModeToggle(BuildContext context, bool isDarkMode) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return ListTile(
      leading: Icon(Icons.dark_mode,
          color: isDarkMode ? Colors.white : Colors.black),
      title: Text("Dark Mode",
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
      trailing: Switch(
        value: isDarkMode,
        activeColor: const Color(0xFFFF7918),
        onChanged: (value) {
          themeProvider.toggleTheme();
        },
      ),
    );
  }

  // 🔹 Sign Out Button
  Widget _buildSignOutButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          side: const BorderSide(color: Color(0xFFFF7918)),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout, color: Color(0xFFFF7918)),
            SizedBox(width: 8),
            Text("Sign Out",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF7918))),
          ],
        ),
      ),
    );
  }
}
