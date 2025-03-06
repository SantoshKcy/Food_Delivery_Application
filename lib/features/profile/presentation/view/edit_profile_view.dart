import 'package:flutter/material.dart';
import 'package:food_delivery_application/core/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class EditProfileView extends StatelessWidget {
  EditProfileView({super.key});

  final TextEditingController firstNameController =
      TextEditingController(text: "Santosh");

  final TextEditingController lastNameController =
      TextEditingController(text: "KC");

  final TextEditingController emailController =
      TextEditingController(text: "santosh@gmail.com");

  final TextEditingController phoneController =
      TextEditingController(text: "9840922949");

  final TextEditingController currentPasswordController =
      TextEditingController();

  final TextEditingController newPasswordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor:
            isDarkMode ? Colors.grey[900] : const Color(0xFFFF7918),
        elevation: 0,
        title: Text(
          "Edit Profile",
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
            _buildSectionTitle("Profile Information", isDarkMode),
            _buildTextField("First Name", firstNameController, isDarkMode),
            _buildTextField("Last Name", lastNameController, isDarkMode),
            _buildTextField("Email", emailController, isDarkMode,
                isReadOnly: true),
            _buildTextField("Phone", phoneController, isDarkMode),
            const SizedBox(height: 20),
            _buildSectionTitle("Change Password", isDarkMode),
            _buildTextField(
                "Current Password", currentPasswordController, isDarkMode,
                isPassword: true),
            _buildTextField("New Password", newPasswordController, isDarkMode,
                isPassword: true),
            _buildTextField(
                "Confirm Password", confirmPasswordController, isDarkMode,
                isPassword: true),
            const SizedBox(height: 20),
            _buildSubmitButton(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, bool isDarkMode,
      {bool isPassword = false, bool isReadOnly = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        readOnly: isReadOnly,
        decoration: InputDecoration(
          labelText: label,
          labelStyle:
              TextStyle(color: isDarkMode ? Colors.white70 : Colors.black87),
          filled: true,
          fillColor: isDarkMode ? Colors.grey[900] : Colors.grey[200],
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                BorderSide(color: isDarkMode ? Colors.white54 : Colors.black54),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color:
                    isDarkMode ? Colors.orangeAccent : const Color(0xFFFF7918)),
          ),
        ),
        style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF7918),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          "Save Changes",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
