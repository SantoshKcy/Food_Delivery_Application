import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Sign Up',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                      style: TextStyle(color: Colors.black, fontSize: 18),
                      children: [
                        TextSpan(
                          text: 'Terms and Conditions.',
                          style: TextStyle(
                            color: Colors.orange,
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
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Sign In Link
            Center(
              child: Text.rich(
                TextSpan(
                  text: 'Already have an account? ',
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                  children: [
                    TextSpan(
                      text: 'Sign In',
                      style: const TextStyle(
                        color: Colors.orange,
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
        labelStyle: const TextStyle(
          fontSize: 18,
        ),
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
