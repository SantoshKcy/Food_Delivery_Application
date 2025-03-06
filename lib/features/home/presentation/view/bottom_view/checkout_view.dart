import 'package:flutter/material.dart';
import 'package:food_delivery_application/features/home/presentation/view/bottom_view/order_success_view.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  String deliveryAddress = "Add delivery address"; // Default Placeholder
  String selectedPaymentMethod = "Select Payment Method"; // Default Text

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF7918),
        elevation: 0,
        title: const Text(
          "Checkout",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        leading: IconButton(
    icon: const Icon(Icons.arrow_back, color: Colors.white), // 🔹 Changed color to White
    onPressed: () => Navigator.pop(context),
  ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 20), // 🔹 Added gap after App Bar

            // Delivery Address Section
            _buildCard(
              child: ListTile(
                leading:
                    const Icon(Icons.add_location_alt, color: Colors.black),
                title: Text(deliveryAddress),
                trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                onTap: () => _showAddressForm(context),
              ),
            ),
            const SizedBox(height: 10),

            // Items Summary
            _buildCard(
              child: ListTile(
                title: const Text("Your Items (3 items)",
                    style: TextStyle(fontSize: 16)),
                trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 10),

            // Payment Summary
            _buildPaymentSummary(),
            const SizedBox(height: 10),

            // Payment Method Selection
            _buildCard(
              child: ListTile(
                leading: const Icon(Icons.payment, color: Colors.black),
                title: Text(selectedPaymentMethod),
                trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                onTap: () => _showPaymentMethodPopup(context),
              ),
            ),
            const SizedBox(height: 20),

// 🔹 Dynamic Place Order / Pay Now Button
SizedBox(
  width: double.infinity,
  child: ElevatedButton(
    onPressed: () {
      if (selectedPaymentMethod == "Khalti (Digital Wallet)") {
        _showSnackbar("Redirecting to Khalti Payment Gateway...");
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const OrderSuccessView()),
        );
      }
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFFF7918), // Orange
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      padding: const EdgeInsets.symmetric(vertical: 14),
    ),
    child: Text(
      selectedPaymentMethod == "Khalti (Digital Wallet)" ? "Pay Now" : "Place Order",
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white, // White Text
      ),
    ),
  ),
),

          ],
        ),
      ),
    );
  }

  // 🔹 Build Card Layout
  Widget _buildCard({required Widget child}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: child,
      ),
    );
  }

  // 🔹 Payment Summary
  Widget _buildPaymentSummary() {
    int billTotal = 3038;
    int deliveryCharge = 150;
    int discount = 0;
    int grandTotal = billTotal + deliveryCharge - discount;

    return _buildCard(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Payment Summary",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildSummaryRow("BILL TOTAL", "Rs. $billTotal.00"),
            _buildSummaryRow("DELIVERY CHARGE", "Rs. $deliveryCharge.00"),
            _buildSummaryRow("Discount", "Rs. $discount.00"),
            const Divider(),
            _buildSummaryRow("GRAND TOTAL", "Rs. $grandTotal.00", isBold: true),
          ],
        ),
      ),
    );
  }

  // 🔹 Summary Row for Payment Details
  Widget _buildSummaryRow(String title, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 14,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          ),
          Text(
            value,
            style: TextStyle(
                fontSize: 14,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          ),
        ],
      ),
    );
  }

  // 🔹 Show Delivery Address Form
  void _showAddressForm(BuildContext context) {
    final TextEditingController addressController = TextEditingController();
    final TextEditingController cityController = TextEditingController();
    final TextEditingController zipCodeController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Enter Delivery Address"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField(addressController, "Address"),
                _buildTextField(cityController, "City"),
                _buildTextField(zipCodeController, "Zip Code"),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel")),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  deliveryAddress =
                      "${addressController.text}, ${cityController.text} - ${zipCodeController.text}";
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF7918)),
              child: const Text("Save", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  // 🔹 Show Payment Method Popup
  void _showPaymentMethodPopup(BuildContext context) {
    String tempPaymentMethod = selectedPaymentMethod;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Select Payment Method"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile(
                    value: "Cash on Delivery",
                    groupValue: tempPaymentMethod,
                    title: const Text("Cash on Delivery"),
                    subtitle: const Text("Pay when you receive your order."),
                    onChanged: (value) {
                      setState(() => tempPaymentMethod = value.toString());
                    },
                  ),
                  RadioListTile(
                    value: "Khalti (Digital Wallet)",
                    groupValue: tempPaymentMethod,
                    title: const Text("Khalti (Digital Wallet)"),
                    subtitle: const Text("Pay securely via Khalti app."),
                    onChanged: (value) {
                      setState(() => tempPaymentMethod = value.toString());
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel")),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedPaymentMethod = tempPaymentMethod;
                    });
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF7918)),
                  child: const Text("Confirm",
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // 🔹 Show Snackbar Messages
  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  // 🔹 Build Text Field
  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
