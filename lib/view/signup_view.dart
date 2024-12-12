import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Page Title
            const Text(
              'SIGN UP',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),

            // Input Fields
            _buildTextField(label: 'First Name'),
            const SizedBox(height: 10),
            _buildTextField(label: 'Last Name'),
            const SizedBox(height: 10),
            _buildTextField(label: 'Phone Number'),
            const SizedBox(height: 10),
            _buildTextField(label: 'Email Address'),
            const SizedBox(height: 10),
            _buildTextField(label: 'Password', obscureText: true),
            const SizedBox(height: 10),
            _buildTextField(label: 'Confirm Password', obscureText: true),
            const SizedBox(height: 20),

            // Terms and Conditions Checkbox
            Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (value) {
                    // Handle checkbox value change
                  },
                ),
                const Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: 'I accept to all the ',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                      children: [
                        TextSpan(
                          text: 'Terms and Conditions.',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Sign Up Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle sign-up logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Sign In Link
            Center(
              child: Text.rich(
                TextSpan(
                  text: 'Already have an account? ',
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                  children: [
                    TextSpan(
                      text: 'Sign In',
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, '/login');
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build text fields
  Widget _buildTextField({required String label, bool obscureText = false}) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        prefixIcon: Icon(
          _getIconForField(label),
          color: Colors.grey,
        ),
      ),
    );
  }

  // Helper method to get the appropriate icon for each field
  IconData _getIconForField(String label) {
    switch (label) {
      case 'First Name':
      case 'Last Name':
        return Icons.person;
      case 'Phone Number':
        return Icons.phone;
      case 'Email Address':
        return Icons.email;
      case 'Password':
      case 'Confirm Password':
        return Icons.lock;
      default:
        return Icons.text_fields;
    }
  }
}
